/// Represents the user profile information for the Profile screen.
/// All fields default to empty strings — no fake sample data.
class UserProfile {
  final String name;
  final String email;
  final String phone;
  final String avatarUrl;
  final String address;

  const UserProfile({
    this.name = '',
    this.email = '',
    this.phone = '',
    this.avatarUrl = '',
    this.address = '',
  });

  /// Creates a copy with optional field overrides
  UserProfile copyWith({
    String? name,
    String? email,
    String? phone,
    String? avatarUrl,
    String? address,
  }) {
    return UserProfile(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      address: address ?? this.address,
    );
  }
}
