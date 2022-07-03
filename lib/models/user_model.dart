class UserModel {
  String fname;
  String lname;
  String bio;
  String isWorker;
  String phone;
  String email;
  String imageUrl;

  UserModel({
    required this.fname,
    required this.lname,
    required this.bio,
    required this.isWorker,
    required this.phone,
    required this.email,
    required this.imageUrl
  });

  factory UserModel.fromMap(Map<String, dynamic> map){
    return UserModel(
      fname: map['fname'],
      lname: map['lname'],
      bio: map['bio'],
      isWorker: map['isWorker'],
      phone: map['phone'],
      email: map['email'],
      imageUrl: map['imageUrl'],
    );
  }
}