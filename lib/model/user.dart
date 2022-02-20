class UserModel {
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? avatar;

  UserModel({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.avatar,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        avatar: json["avatar"],
      );
}
