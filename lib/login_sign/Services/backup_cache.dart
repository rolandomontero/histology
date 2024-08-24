import 'package:shared_preferences/shared_preferences.dart';

class BackupCache {
  /// Carga los datos de `ProfileUser` desde las preferencias compartidas.
  Future<ProfileUser> loadData() async {
    final prefs = await SharedPreferences.getInstance();
    return ProfileUser(
      name: prefs.getString('name') ?? '',
      email: prefs.getString('email') ?? '',
      school: prefs.getString('school') ?? '',
      pass: prefs.getString('pass') ?? '',
    );
  }

  /// Guarda los datos de `ProfileUser` en las preferencias compartidas.
  Future<void> saveDataActivacion(ProfileUser usuario) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', usuario.name);
    await prefs.setString('email', usuario.email);
    await prefs.setString('school', usuario.school);
    await prefs.setString('pass', usuario.pass);
  }
}

class ProfileUser {
  final String name;
  final String email;
  final String school;
  final String pass;

  const ProfileUser({
    required this.name,
    required this.email,
    required this.school,
    required this.pass,
  });

  /// Verifica si el objeto `ProfileUser` está vacío,
  bool get isEmpty => name.isEmpty && email.isEmpty;
}
