
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:histology/Widget/navbar.dart';
import 'package:histology/global/widgetprofile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../model/profile_model.dart';
import '../services/authentication.dart';

class HomeScreenLogin extends StatefulWidget {
  const HomeScreenLogin({super.key});

  @override
  State<HomeScreenLogin> createState() => _HomeScreenLogin();
}

class _HomeScreenLogin extends State<HomeScreenLogin> {
  bool registrado = false;
  ProfileUser usuario = ProfileUser(name: '', email: '', school: '', pass: '');

  static const int currentPageIndex = 3;

  @override
  void initState() {
    super.initState();




    _cargarDatosUsuario();
  }

  Future<void> _cargarDatosUsuario() async {
    final prefs = await SharedPreferences.getInstance();
    registrado = (prefs.getString('name') ?? '') != '' ? true : false;
    if (registrado) {
      usuario = await AuthMethod().loadMemory();
      print('\n ${usuario.name}');
      print('\n ${usuario.email}');
      print('\n ${usuario.school}');

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF3A9DE9),
        title: Center(
          child: Text(
            "Perfil",
            textAlign: TextAlign.center,
            style: GoogleFonts.acme(
                color: Colors.white,
                fontSize: 42.0,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/wallpaper/w1.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
            padding: const EdgeInsets.all(22.0),
            child: Column(children: [
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(14.0),
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 5.0,
                          color: Colors.grey,
                        ),
                      ]),
                  child: userProfile(),
                ),
              )
            ])),
      ),
      bottomNavigationBar:
        const BotonNavegacionBarra(3),
    );
  }

  Widget userProfile() {
    final screenWidth = MediaQuery.of(context).size.width;
    return  Column(
        children: [
          const Text('User Profile'),
          SizedBox(height: 12.0, width:screenWidth),
          const ShowProfile(editar: false),
          const SizedBox(height: 42.0),
          Stack(
            children: [
              Text(usuario!.name,),
              Container(
                height: 2.0,
                color: const Color(0xCCCCCCCC), // Ancho de la línea
                width: screenWidth,
              ),

            ],
          ),
          Text(usuario!.school,

          ),
          const SizedBox(height: 42.0),
          Text(usuario!.school),
          const SizedBox(height: 42.0),
          const SizedBox(height: 40),
       
        ]
      );

  }
}
