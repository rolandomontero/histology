import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/profile_model.dart';

class AuthMethod {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late final ProfileUser _user;

  // SignUp User
  Future<String> signupUser({
    required String email,
    required String password,
    required String name,
    required String school,  
    String imgProfile = '',
  }) async {
    String res = "Algo ocurrio";
    try {
      if (email.isNotEmpty || password.isNotEmpty || name.isNotEmpty) {
        // register user in auth with email and password
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        await _firestore.collection("users").doc(cred.user!.uid).set({
          'uid': cred.user!.uid,
          'name': name,
          'email': email,
          'school': school,
          'imgProfile': imgProfile
        });

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('uid', cred.user!.uid);
        await prefs.setString('name', name);
        await prefs.setString('email', email);
        await prefs.setString('school', school);
        await prefs.setString('pass', password);
        await prefs.setString('imgProfile', imgProfile);

        res = "success";
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }

  // logIn user
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error Occurred";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        // Inicia sesión con el correo y contraseña
        UserCredential cred = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );

        // Obtén el uid del usuario autenticado
        String uid = cred.user!.uid;

        // Referencia al documento del usuario usando el uid
        final userDocRef = _firestore.collection("users").doc(uid);
        final userSnapshot = await userDocRef.get();

        print('\n == == =!  CARGANDO DATOS => ===');
        if (userSnapshot.exists) {
          final userData = userSnapshot.data() as Map<String, dynamic>;
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('name', userData['name']);
          await prefs.setString('email', userData['email']);
          await prefs.setString('school', userData['school']);
          await prefs.setString('imgProfile', userData['imgProfile']);
          await prefs.setString('uid', uid);
          await prefs.setString('pass', password);
        }
        res = "success";
      } else {
        res = "Please enter all the fields";
      }

      print('\n == =>  res = $res ===');
    } catch (err) {
      return err.toString();
    }
    return res;
  }

  // for sighout
  Future<void> signOut() async {
    await _auth.signOut();
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove('name');
    await prefs.remove('email');
    await prefs.remove('school');
    await prefs.remove('pass');
    await prefs.remove('imgProfile');
    await prefs.remove('uid');
  }

  Future<ProfileUser> loadMemory() async {
    final prefs = await SharedPreferences.getInstance();
    _user = ProfileUser(
        name: prefs.getString('name') ?? '',
        email: prefs.getString('email') ?? '',
        school: prefs.getString('school') ?? '',
        pass: prefs.getString('pass') ?? '',
        imgProfile: prefs.getString('imgProfile') ?? '');
    return _user;
  }
}
