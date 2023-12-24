// {phoneNumber: 01021570316, name: Ammar Ageeza,
// department: SC, email: ammarfathy516@gmail.com}
class UserModel {
  String name;
  String phoneNumber;
  String email;
  String department;
  String id;
  UserModel({
    required this.name,
    required this.phoneNumber,
    required this.email,
    required this.department,
    required this.id,
  });

  // UserModel(Map<String,dynamic> jsonData);
  factory UserModel.fromJson(Map<String, dynamic> jsonData,id) {
    return UserModel(
      name: jsonData['name'],
      department: jsonData['department'],
      email: jsonData['email'],
      phoneNumber: jsonData['phoneNumber'],
      id: id,
    );
  }
}
//sum(int x,y)
//sum(int x,y,z)