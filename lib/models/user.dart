// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class User {
  final String id;
  final String username;
  final String email;
  final String password;
  final String name;
  final int? age;
  final String? gender;
  final String? address;
  final String? phone;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isAdmin;
  User({
    required this.id,
    required this.username,
    required this.email,
    required this.password,
    required this.name,
    this.age,
    this.gender,
    this.address,
    this.phone,
    required this.createdAt,
    required this.updatedAt,
    required this.isAdmin,
  });

  User copyWith({
    String? id,
    String? username,
    String? email,
    String? password,
    String? name,
    int? age,
    String? gender,
    String? address,
    String? phone,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isAdmin,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
      name: name ?? this.name,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isAdmin: isAdmin ?? this.isAdmin,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'username': username,
      'email': email,
      'password': password,
      'name': name,
      'age': age,
      'gender': gender,
      'address': address,
      'phone': phone,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
      'isAdmin': isAdmin,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as String,
      username: map['username'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      name: map['name'] as String,
      age: map['age'] != null ? map['age'] as int : null,
      gender: map['gender'] != null ? map['gender'] as String : null,
      address: map['address'] != null ? map['address'] as String : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] as int),
      isAdmin: map['isAdmin'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User(id: $id, username: $username, email: $email, password: $password, name: $name, age: $age, gender: $gender, address: $address, phone: $phone, createdAt: $createdAt, updatedAt: $updatedAt, isAdmin: $isAdmin)';
  }

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.username == username &&
      other.email == email &&
      other.password == password &&
      other.name == name &&
      other.age == age &&
      other.gender == gender &&
      other.address == address &&
      other.phone == phone &&
      other.createdAt == createdAt &&
      other.updatedAt == updatedAt &&
      other.isAdmin == isAdmin;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      username.hashCode ^
      email.hashCode ^
      password.hashCode ^
      name.hashCode ^
      age.hashCode ^
      gender.hashCode ^
      address.hashCode ^
      phone.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode ^
      isAdmin.hashCode;
  }
}
