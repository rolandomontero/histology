import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:histology/Libro/screen_indice.dart';
import 'package:histology/global/colores.dart';
import 'package:histology/global/widgetprofile.dart';
import 'package:histology/login_sign/screen/signscreen.dart';
import 'package:histology/login_sign/Widget/input_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  static const Color histologyBkcg = Color(0xFF895476);
  static const Color histologyColor = Color(0xFFF2F0E0);
  static const int currentPageIndex = 3;
  final TextEditingController emailController = TextEditingController();
  
  final TextEditingController activaController = TextEditingController(); 
  final bool registrado = false;
  String nombre = '';
  String email = '';

  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    activaController.dispose();
    _loadData();
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      nombre = prefs.getString('nombre') ?? '';
      email = prefs.getString('email') ?? '';
    });
  }

  Future<void> _saveDataActivacion() async {
    if (activaController.text.isNotEmpty) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('activado', activaController.text);
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
        actions: [
          IconButton(
            icon: Icon(
              registrado ? Icons.person : Icons.person_off,
              color: Colors.white,
              size: 32,
            ),
            onPressed: () {},
          ),
        ],
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
                      ]

                      // Opacidad del 20%
                      ),
                  child: registrado ? userProfile() : login(),
                ),
              )
            ])),
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            switch (index) {
              case 0:
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ScreenIndice(),
                    fullscreenDialog:
                        true, // Esto hace que sea un diálogo a pantalla completa
                  ),
                );
            }
          });
        },
        indicatorColor: histologyBkcg,
        selectedIndex: currentPageIndex,
        backgroundColor: histologyColor,
        animationDuration: const Duration(milliseconds: 1000),
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(
              Icons.bookmark,
              color: Colors.white,
            ),
            icon: Icon(Icons.bookmark),
            label: 'Lecciones',
          ),
          NavigationDestination(
            icon: Icon(Icons.chat_bubble),
            label: 'Mensajes',
          ),
          NavigationDestination(
            icon: Icon(Icons.emoji_events),
            label: 'Progreso',
          ),
          NavigationDestination(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }

  Widget login() {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Column(
        children: [
          const SizedBox(height: 12.0),
          const CircleAvatar(
            radius: 52,
            backgroundImage: AssetImage('assets/images/icons/user_hst.png'),
          ),
          const SizedBox(height: 12.0),
          InputText(
              icon: Icons.email_rounded,
              textEditingController: emailController,
              hintText: 'Ingrese su email',
              textInputType: TextInputType.text),
          const SizedBox(height: 18.0),
          InputText(
            textEditingController: activaController,
            hintText: 'Código de activación',
            textInputType: TextInputType.text,
            fontSize: 32.0,
            mayuscula: true,
            textAlign: TextAlign.center,
            colortext: Tema.histologyBkcg,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () {
              _saveDataActivacion();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              textStyle: const TextStyle(
                fontSize: 18, //fontWeight: FontWeight.bold
              ),
              // Cambia el color del botón a verde
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(20), // Agrega bordes redondeados
              ),
              foregroundColor: Colors.white,
              backgroundColor: Tema.histologyBkcg,
            ),
            child: const Text('Activar'),
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("¿No tienes cuenta? "),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const SignScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    "Regístrate",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Tema.histologyBkcg,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget userProfile() {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Column(
        children: [
          const SizedBox(height: 12.0),
          const ShowProfile(editar: false),
          const SizedBox(height: 42.0),
          const TextField(
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                // labelText: 'Tu Nombre',
                // prefixIcon: Icon(Icons.person),
                prefixIconColor: histologyBkcg,
              ),
              style: TextStyle(
                fontSize: 22,
              )),
          const Text(
            'email',
          ),
          const SizedBox(height: 42.0),
          const TextField(
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                // labelText: 'Tu Nombre',
                // prefixIcon: Icon(Icons.person),
                prefixIconColor: histologyBkcg,
              ),
              style: TextStyle(
                fontSize: 22,
              )),
          const Text(
            'Contraseña',
          ),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              textStyle: const TextStyle(
                fontSize: 18,
                //fontWeight: FontWeight.bold
              ),
              // Cambia el color del botón a verde
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(20), // Agrega bordes redondeados
              ),
              foregroundColor: Colors.white,
              backgroundColor: const Color(0xFF3A9DE9),
            ),
            child: const Text('Iniciar sesión'),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
