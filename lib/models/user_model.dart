class AppUser {
  final String uid;
  final String firstName;
  final String lastName;
  final String role;
  final DateTime createdAt;

  AppUser({
    required this.uid,
    required this.firstName,
    required this.lastName,
    required this.role,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() => {
        'uid': uid,
        'firstName': firstName,
        'lastName': lastName,
        'role': role,
        'createdAt': createdAt.toIso8601String(),
      };
}