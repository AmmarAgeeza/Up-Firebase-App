import 'package:cloud_firestore/cloud_firestore.dart';

class DonatorModel {
  final String name;
  final String address;
  final String phone;
  final String type;
  final DateTime date;

  const DonatorModel({
    required this.name,
    required this.address,
    required this.phone,
    required this.type,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'address': address,
      'phone': phone,
      'type': type,
      'date': date,
    };
  }

  factory DonatorModel.fromMap(Map<String, dynamic> map) {
    return DonatorModel(
      name: map['name'] as String,
      address: map['address'] as String,
      phone: map['phone'] as String,
      type: map['type'] as String,
      date: (map['date'] as Timestamp).toDate(),
    );
  }
}
