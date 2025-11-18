import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String email;
  final String firstName;
  final String lastName;
  final String role;
  final DateTime registrationDateTime;
  final String? dateOfBirth;
  final String? displayName;

  UserModel({
    required this.uid,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.role,
    required this.registrationDateTime,
    this.dateOfBirth,
    this.displayName,
  });

  // Computed property for full name
  String get fullName => '$firstName $lastName';

  // Computed property for display name (use displayName if set, otherwise full name)
  String get effectiveDisplayName => displayName ?? fullName;

  // Convert UserModel to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'role': role,
      'registrationDateTime': Timestamp.fromDate(registrationDateTime),
      'dateOfBirth': dateOfBirth,
      'displayName': displayName,
    };
  }

  // Create UserModel from Firestore document
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      email: map['email'] ?? '',
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      role: map['role'] ?? 'user',
      registrationDateTime: (map['registrationDateTime'] as Timestamp).toDate(),
      dateOfBirth: map['dateOfBirth'],
      displayName: map['displayName'],
    );
  }

  // Create UserModel from Firestore DocumentSnapshot
  factory UserModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserModel.fromMap(data);
  }

  // Create a copy of UserModel with updated fields
  UserModel copyWith({
    String? uid,
    String? email,
    String? firstName,
    String? lastName,
    String? role,
    DateTime? registrationDateTime,
    String? dateOfBirth,
    String? displayName,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      role: role ?? this.role,
      registrationDateTime: registrationDateTime ?? this.registrationDateTime,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      displayName: displayName ?? this.displayName,
    );
  }
}