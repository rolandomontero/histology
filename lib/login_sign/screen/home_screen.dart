import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:histology/Widget/navbar.dart';
import 'package:histology/global/constantes.dart';
import 'package:histology/global/widgetprofile.dart';

import '../../model/profile_model.dart';
import '../services/authentication.dart';

class HomeScreenLogin extends StatefulWidget {
  const HomeScreenLogin({super.key});

  @override
  State<HomeScreenLogin> createState() => _HomeScreenLoginState();
}

class _HomeScreenLoginState extends State<HomeScreenLogin> {
  late Future<ProfileUser> _userDataFuture;

  @override
  void initState() {
    super.initState();
    _userDataFuture = _cargarDatosUsuario();
  }

  Future<ProfileUser> _cargarDatosUsuario() async {
    return await AuthMethod().loadMemory();
  }

  Future<void> _cerrarSesion() async {
    await AuthMethod().signOut();
    // Puedes navegar a la pantalla de inicio de sesión o realizar alguna otra acción después de cerrar sesión.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Tema.histologyBkcg, // Usa la constante para el color
        title: Center(
          child: Text(
            "Perfil",
            textAlign: TextAlign.center,
            style: GoogleFonts.acme(
              color: Colors.white,
              fontSize: 42.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/wallpaper/w1.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        child: FutureBuilder<ProfileUser>(
          future: _userDataFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              final usuario = snapshot.data!;
              return _buildUserProfile(context, usuario);
            }
          },
        ),
      ),
      bottomNavigationBar: const BotonNavegacionBarra(3),
    );
  }

  Widget _buildUserProfile(BuildContext context, ProfileUser usuario) {
    final screenWidth = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(22.0),
      child: Column(
        children: [
          const SizedBox(height: 30),
          Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.9),
              borderRadius: BorderRadius.circular(14.0),
              boxShadow: const [
                BoxShadow(
                  blurRadius: 5.0,
                  color: Colors.grey,
                ),
              ],
            ),
            child: Column(
              children: [
                const SizedBox(height: 42.0),
                SizedBox(height: 12.0, width: screenWidth),
                ShowProfile(editar: true),
                const SizedBox(height: 42.0),
                Text(
                  usuario.name,
                  style: GoogleFonts.montserrat(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                _buildDivider(screenWidth),
                const Text("Usuario"),
                const SizedBox(height: 42.0),
                Text(
                  usuario.school, // Muestra la escuela del usuario
                  style: GoogleFonts.montserrat(
                    fontSize: 16.0,
                  ),
                  textAlign: TextAlign.center,
                ),
                _buildDivider(screenWidth),
                const Text("Institucion Educativa"),
                const SizedBox(height: 82.0),
                ElevatedButton(
                  onPressed: _cerrarSesion,
                  style: ElevatedButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    foregroundColor: Colors.white,
                    backgroundColor: Tema.histologyBkcg,
                  ),
                  child: const Text('Salir'),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider(double screenWidth) {
    return Stack(
      children: [
        Container(
          height: 2.0,
          color: const Color(0xCCCCCCCC),
          width: screenWidth * 0.7,
        ),
      ],
    );
  }
}
