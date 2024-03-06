class UserModel {
  final String name;
  final String phone;
  final String email;
  final String uid;

  const UserModel({
    required this.name,
    required this.phone,
    required this.email,
    required this.uid,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      phone: json['phone'],
      email: json['email'],
      uid: json['uid'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone': phone,
      'email': email,
      'uid': uid,
    };
  }
}
