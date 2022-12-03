class UserModel {
  String id;
  String prod_id;
  String fname;
  String lname;
  String bio;
  String isWorker;
  String phone;
  String email;
  String imageUrl;
  String token;

  UserModel({
    required this.id,
    required this.prod_id,
    required this.fname,
    required this.lname,
    required this.bio,
    required this.isWorker,
    required this.phone,
    required this.email,
    required this.imageUrl,
    required this.token,
  });
}
