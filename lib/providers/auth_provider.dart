import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../core/services/auth_service.dart';
import '../core/api/api_client.dart';

/// Represents a logged-in user.
class AuthUser {
  final String id;
  final String email;
  final String name;
  final String phone;

  AuthUser({
    required this.id,
    required this.email,
    required this.name,
    required this.phone,
  });

  factory AuthUser.fromJson(Map<String, dynamic> json) {
    return AuthUser(
      id: json['id']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      phone: json['phone']?.toString() ?? '',
    );
  }
}

/// Manages authentication state — registration, login, logout.
/// Persists the JWT token across app restarts via shared_preferences.
class AuthProvider extends ChangeNotifier {
  AuthUser? _currentUser;
  String? _token;
  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoggedIn => _currentUser != null && _token != null;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  AuthUser? get currentUser => _currentUser;
  String? get token => _token;

  AuthProvider() {
    _restoreSession();
  }

  /// Restores JWT token and user info from local storage on app start.
  Future<void> _restoreSession() async {
    final prefs = await SharedPreferences.getInstance();
    final savedToken = prefs.getString('auth_token');
    final savedId = prefs.getString('user_id');
    final savedEmail = prefs.getString('user_email');
    final savedName = prefs.getString('user_name');
    final savedPhone = prefs.getString('user_phone');
    if (savedToken != null && savedId != null) {
      _token = savedToken;
      _currentUser = AuthUser(
        id: savedId,
        email: savedEmail ?? '',
        name: savedName ?? '',
        phone: savedPhone ?? '',
      );
      notifyListeners();
    }
  }

  Future<void> _saveSession(String token, AuthUser user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
    await prefs.setString('user_id', user.id);
    await prefs.setString('user_email', user.email);
    await prefs.setString('user_name', user.name);
    await prefs.setString('user_phone', user.phone);
  }

  Future<void> _clearSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
    await prefs.remove('user_id');
    await prefs.remove('user_email');
    await prefs.remove('user_name');
    await prefs.remove('user_phone');
  }

  /// Registers a new user account and logs them in on success.
  Future<bool> register({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String confirmPassword,
  }) async {
    _setLoading(true);
    _clearError();

    if (name.trim().isEmpty) return _fail('Name is required');
    if (email.trim().isEmpty) return _fail('Email is required');
    if (!_isValidEmail(email.trim())) return _fail('Please enter a valid email address');
    if (phone.trim().isEmpty) return _fail('Phone number is required');
    if (password.isEmpty) return _fail('Password is required');
    if (password.length < 6) return _fail('Password must be at least 6 characters');
    if (password != confirmPassword) return _fail('Passwords do not match');

    try {
      final res = await AuthService.register(name.trim(), email.trim(), password, phone.trim());
      if (res['success'] == true) {
        final data = res['data'] as Map<String, dynamic>;
        final token = data['token'] as String;
        final user = AuthUser.fromJson(data['user'] as Map<String, dynamic>);
        _token = token;
        _currentUser = user;
        await _saveSession(token, user);
        _setLoading(false);
        notifyListeners();
        return true;
      }
      return _fail(res['message']?.toString() ?? 'Registration failed');
    } on ApiException catch (e) {
      return _fail(e.message);
    } catch (e) {
      return _fail('Could not connect to server. Check your connection.');
    }
  }

  /// Logs in with email and password.
  Future<bool> login({
    required String email,
    required String password,
  }) async {
    _setLoading(true);
    _clearError();

    if (email.trim().isEmpty) return _fail('Email is required');
    if (password.isEmpty) return _fail('Password is required');

    try {
      final res = await AuthService.login(email.trim(), password);
      if (res['success'] == true) {
        final data = res['data'] as Map<String, dynamic>;
        final token = data['token'] as String;
        final user = AuthUser.fromJson(data['user'] as Map<String, dynamic>);
        _token = token;
        _currentUser = user;
        await _saveSession(token, user);
        _setLoading(false);
        notifyListeners();
        return true;
      }
      return _fail(res['message']?.toString() ?? 'Login failed');
    } on ApiException catch (e) {
      return _fail(e.message);
    } catch (e) {
      return _fail('Could not connect to server. Check your connection.');
    }
  }

  /// Allows the user to browse without logging in.
  void loginAsGuest() {
    _clearError();
    _currentUser = AuthUser(id: 'guest', name: 'Guest', email: '', phone: '');
    _token = null;
    notifyListeners();
  }

  /// Logs out and clears stored session.
  Future<void> logout() async {
    _currentUser = null;
    _token = null;
    _clearError();
    await _clearSession();
    notifyListeners();
  }

  bool _isValidEmail(String email) =>
      RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);

  bool _fail(String message) {
    _setError(message);
    _setLoading(false);
    return false;
  }

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
  }

  void clearError() => _clearError();
}
