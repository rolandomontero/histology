import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:histology/Widget/navbar.dart';
import 'package:histology/login_sign/screen/login_screen.dart';
import 'package:histology/model/class_indice.dart';
import 'package:histology/global/constantes.dart';
import 'package:histology/web_view_container.dart';

class ScreenIndice extends StatefulWidget {
  const ScreenIndice({super.key});

  @override
  State<ScreenIndice> createState() => _ScreenIndiceState();
}

class _ScreenIndiceState extends State<ScreenIndice> {
  bool _firebaseInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeFirebase();
  }

  Future<void> _initializeFirebase() async {
    await Firebase.initializeApp();
    setState(() {
      _firebaseInitialized = true;
      // Escucha los cambios en el estado de autenticación
      FirebaseAuth.instance.authStateChanges().listen((User? user) {
        if (user == null) {
          // El usuario no ha iniciado sesión
          if (kDebugMode) {
            print('Usuario no ha iniciado sesión');
          }
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const LoginScreen(),
              fullscreenDialog: true,
            ),
          );
          // Navega a la pantalla de inicio de sesión o realiza alguna otra acción
        } else {
          // El usuario ha iniciado sesión
          print('Usuario ha iniciado sesión: ${user.uid}');
          // Navega a la pantalla principal o realiza alguna otra acción
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(
          child: Text(
            "Lecciones",
            textAlign: TextAlign.center,
            style: GoogleFonts.acme(
                color: Colors.white,
                fontSize: 42.0,
                fontWeight: FontWeight.bold),
          ),
        ),
        centerTitle: true,
        titleTextStyle: const TextStyle(
            color: Colors.white,
            fontFamily: 'Montserrat',
            fontSize: 22,
            fontWeight: FontWeight.bold),
        // toolbarHeight: 80,
        backgroundColor: Tema.histologyBkcg,
        elevation: 8.0,
        shadowColor: Colors.grey,
        //automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.notifications,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/wallpaper/w2.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(children: [
            const SizedBox(
              height: 22,
            ),
            content(),
            Expanded(
              child: listaContenidos(temas),
            ),
          ]),
        ),
      ),
      bottomNavigationBar: const BotonNavegacionBarra(0),
    );
  }

  Widget content() {
    return Center(
        child: ElevatedButton(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const WebViewContainer(),
            fullscreenDialog: true,
          ),
        );
      },
      child: const Text("Introducción"),
    ));
  }

  Widget listaContenidos(tema) {
    return ListView.builder(
        itemCount: tema.length,
        itemBuilder: (BuildContext context, int index) {
          final miTema = tema[index];
          final int colorValue =
              (int.parse(miTema.color.toString(), radix: 16));
          Color micolor = Color(colorValue);

          return Column(
            children: [
              const SizedBox(
                height: 22,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 6.0),
                        decoration: BoxDecoration(
                          color: micolor,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0),
                          ),
                        ),
                        child: Row(
                          children: [
                            const SizedBox(width: 14.0),
                            CircleAvatar(
                              radius: 37,
                              backgroundImage: AssetImage(miTema.imagePath),
                            ),
                            Expanded(
                              child: Text(
                                miTema.tema,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.acme(
                                    color: Colors.white,
                                    fontSize: 32.0,
                                    fontWeight: FontWeight.bold,
                                    height: 0.8),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.timelapse_rounded,
                                ),
                                Text(miTema.minutos),
                                Text(miTema.gd)
                              ],
                            ),
                            const SizedBox(width: 12.0),
                          ],
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        'Descripción',
                        style: GoogleFonts.acme(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                        textAlign: TextAlign.right,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          miTema.descripcion,
                          textAlign: TextAlign.justify,
                          style: const TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8.0),
                    ],
                  ),
                ),
              ),
            ],
          );
        });
  }
}
