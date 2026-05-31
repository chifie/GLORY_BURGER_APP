/// Represents the user profile information for the Profile screen.
class UserProfile {
  final String name;
  final String email;
  final String phone;
  final String avatarUrl;
  final String address;

  const UserProfile({
    this.name = 'John Doe',
    this.email = 'john.doe@gloryburger.com',
    this.phone = '+255 712 345 678',
    this.avatarUrl = '',
    this.address = '123 Food Street, Dar es Salaam',
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
