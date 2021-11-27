class UserModel {
  String? uid;
  String? email;
  String? firstName;
  String? lastName;

  //Creating a User Model
  UserModel({this.uid, this.email, this.firstName, this.lastName});

  //Data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      firstName: map['firstName'],
      lastName: map['lastName'],
    );
  }

  //Sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'firstName': firstName,
      'secondName': lastName,
    };
  }
}
