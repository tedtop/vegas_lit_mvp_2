import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class UserData extends Equatable {
  const UserData({
    @required this.uid,
    @required this.name,
    @required this.email,
    @required this.googlePhoto,
    @required this.uploadPhoto,
    @required this.age,
    @required this.username,
    @required this.bio,
  })  : assert(uid != null),
        assert(name != null),
        assert(email != null),
        assert(uploadPhoto != null),
        assert(username != null);

  factory UserData.fromFirestore(DocumentSnapshot documentSnapshot) {
    final Map data = documentSnapshot.data();
    return UserData(
      uid: documentSnapshot.id,
      name: data['name'] as String,
      email: data['email'] as String,
      googlePhoto: data['googlePhoto'] as String,
      uploadPhoto: data['uploadPhoto'] as String,
      age: data['age'] as int,
      username: data['username'] as String,
      bio: data['bio'] as String,
    );
  }

  final String uid;
  final String name;
  final String email;
  final String googlePhoto;
  final String uploadPhoto;
  final int age;
  final String username;
  final String bio;

  @override
  List<Object> get props =>
      [uid, name, email, googlePhoto, uploadPhoto, age, username, bio];
}
