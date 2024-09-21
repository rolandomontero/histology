class ProfileUser {
  String name;
  String email;
  String school;
  String pass;
  String imgProfile;

  ProfileUser({
    required this.name,
    required this.email,
    required this.school,
    required this.pass,
    required this.imgProfile,


  });
  //==
  bool get isEmpty => name.isEmpty && email.isEmpty;
}
