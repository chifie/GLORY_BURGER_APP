import 'package:flutter/material.dart';
import '../models/user_profile.dart';

/// Provider that manages the user profile state.
/// Supports reading and editing profile information.
class ProfileProvider extends ChangeNotifier {
  // ── State ─────────────────────────────────────────────────────
  UserProfile _profile = const UserProfile();
  bool _isEditing = false;

  // ── Getters ───────────────────────────────────────────────────
  UserProfile get profile => _profile;
  bool get isEditing => _isEditing;

  /// Toggles the editing mode on/off.
  void toggleEditing() {
    _isEditing = !_isEditing;
    notifyListeners();
  }

  /// Updates the user profile with new values.
  void updateProfile({
    String? name,
    String? email,
    String? phone,
    String? address,
  }) {
    _profile = _profile.copyWith(
      name: name,
      email: email,
      phone: phone,
      address: address,
    );
    _isEditing = false;
    notifyListeners();
  }

  /// Resets the editing state without saving changes.
  void cancelEditing() {
    _isEditing = false;
    notifyListeners();
  }
}
