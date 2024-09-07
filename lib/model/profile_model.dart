class ProfileUser {
  String name;
  String email;
  String school;
  String pass;

  ProfileUser({
    required this.name,
    required this.email,
    required this.school,
    required this.pass,
  });
  //==
  bool get isEmpty => name.isEmpty && email.isEmpty;
}
