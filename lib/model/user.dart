class UserModel {
  final int userId;
  final String username;
  final String email;
  List<UserModel> connection;

  UserModel({
    required this.userId,
    required this.username,
    required this.email,
    required this.connection,
  });
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['id'],
      username: json['username'],
      email: json['email'] as String,
      connection: (json['connections'] as List)
          .map((e) => UserModel.fromJson(e))
          .toList(),
    );
  }
}
