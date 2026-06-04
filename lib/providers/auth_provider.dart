import 'package:flutter/foundation.dart';

/// Represents a user account with basic registration/login details.
class AuthUser {
  final String email;
  final String password;
  final String name;
  final String phone;

  AuthUser({
    required this.email,
    required this.password,
    required this.name,
    required this.phone,
  });

  /// Creates a copy with optional field overrides.
  AuthUser copyWith({
    String? email,
    String? password,
    String? name,
    String? phone,
  }) {
    return AuthUser(
      email: email ?? this.email,
      password: password ?? this.password,
      name: name ?? this.name,
      phone: phone ?? this.phone,
    );
  }
}

/// Manages authentication state (registration & login) for the app.
/// In a production app this would communicate with a backend API.
/// For demo purposes, it stores registered users in memory.
class AuthProvider extends ChangeNotifier {
  // ── Private State ─────────────────────────────────────────────
  final List<AuthUser> _registeredUsers = [];
  AuthUser? _currentUser;
  bool _isLoading = false;
  String? _errorMessage;

  // ── Public Getters ────────────────────────────────────────────
  bool get isLoggedIn => _currentUser != null;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  AuthUser? get currentUser => _currentUser;
  List<AuthUser> get registeredUsers => List.unmodifiable(_registeredUsers);

  // ── Registration ──────────────────────────────────────────────
  /// Registers a new user account.
  /// Returns true on success, false on failure (email already exists).
  Future<bool> register({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String confirmPassword,
  }) async {
    _setLoading(true);
    _clearError();

    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));

    // ── Validation ──────────────────────────────────────────────
    if (name.trim().isEmpty) {
      _setError('Name is required');
      _setLoading(false);
      return false;
    }
    if (email.trim().isEmpty) {
      _setError('Email is required');
      _setLoading(false);
      return false;
    }
    if (!_isValidEmail(email.trim())) {
      _setError('Please enter a valid email address');
      _setLoading(false);
      return false;
    }
    if (phone.trim().isEmpty) {
      _setError('Phone number is required');
      _setLoading(false);
      return false;
    }
    if (password.isEmpty) {
      _setError('Password is required');
      _setLoading(false);
      return false;
    }
    if (password.length < 6) {
      _setError('Password must be at least 6 characters');
      _setLoading(false);
      return false;
    }
    if (password != confirmPassword) {
      _setError('Passwords do not match');
      _setLoading(false);
      return false;
    }

    // Check if email already registered
    final emailLower = email.trim().toLowerCase();
    if (_registeredUsers.any((u) => u.email.toLowerCase() == emailLower)) {
      _setError('An account with this email already exists');
      _setLoading(false);
      return false;
    }

    // Create the user
    final newUser = AuthUser(
      name: name.trim(),
      email: email.trim(),
      phone: phone.trim(),
      password: password, // In production, hash the password!
    );

    _registeredUsers.add(newUser);
    _currentUser = newUser;
    _setLoading(false);
    notifyListeners();
    return true;
  }

  // ── Login ─────────────────────────────────────────────────────
  /// Logs in a user with email and password.
  /// Returns true on success, false on failure.
  Future<bool> login({
    required String email,
    required String password,
  }) async {
    _setLoading(true);
    _clearError();

    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));

    // ── Validation ──────────────────────────────────────────────
    if (email.trim().isEmpty) {
      _setError('Email is required');
      _setLoading(false);
      return false;
    }
    if (password.isEmpty) {
      _setError('Password is required');
      _setLoading(false);
      return false;
    }

    // Find user by email
    final emailLower = email.trim().toLowerCase();
    final user = _registeredUsers.where(
      (u) => u.email.toLowerCase() == emailLower,
    );

    if (user.isEmpty) {
      _setError('No account found with this email');
      _setLoading(false);
      return false;
    }

    final matchedUser = user.first;
    if (matchedUser.password != password) {
      _setError('Incorrect password');
      _setLoading(false);
      return false;
    }

    _currentUser = matchedUser;
    _setLoading(false);
    notifyListeners();
    return true;
  }

  // ── Guest Login ───────────────────────────────────────────────
  /// Allows the user to skip registration and continue as guest.
  void loginAsGuest() {
    _clearError();
    // Guest user with empty fields
    _currentUser = AuthUser(
      name: 'Guest',
      email: '',
      password: '',
      phone: '',
    );
    notifyListeners();
  }

  // ── Logout ────────────────────────────────────────────────────
  /// Logs out the current user.
  void logout() {
    _currentUser = null;
    _clearError();
    notifyListeners();
  }

  // ── Helpers ───────────────────────────────────────────────────
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setError(String message) {
    _errorMessage = message;
    notifyListeners();
  }

  void _clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  /// Simple email format validation.
  bool _isValidEmail(String email) {
    final regex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return regex.hasMatch(email);
  }
}