import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:histology/Widget/input_text.dart';
import 'package:histology/Widget/navbar.dart';
import 'package:histology/Widget/snackbar.dart';
import 'package:histology/global/constantes.dart';
import 'package:histology/global/widgetprofile.dart';
import 'package:histology/login_sign/screen/sign_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String verificationCode = '';
  bool isSign = false;
  bool registrado = false;
  bool isLoading = false;
  String nombre = '';
  String email = '';
  String pass = '';
  String res = '';

  int currentPageIndex = 3;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController repasswordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController activaController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    activaController.dispose();
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      registrado = (prefs.getString('name') ?? '') != '' ? true : false;
    });
    // res = await AuthMethod()
    //     .signupUser(email: email, password: pass, name: nombre);
    // print("$res email $email, pass=$pass, nombre=$nombre" );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF3A9DE9),
        title: Text(
          "Ingresar",
          textAlign: TextAlign.center,
          style: GoogleFonts.acme(
              color: Colors.white, fontSize: 42.0, fontWeight: FontWeight.bold),
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
                      ]),
                  child: enterProfile(),
                ),
              )
            ])),
      ),
      bottomNavigationBar: const BotonNavegacionBarra(3),
    );
  }

  Widget enterProfile() {
    return Column(
      children: [
        const Text(
          "Ingresar",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Tema.histologyBkcg,
          ),
        ),
        const SizedBox(height: 8.0),
        const ShowProfile(editar: false),
        const SizedBox(height: 8.0),
        InputText(
            icon: Icons.email_rounded,
            textEditingController: emailController,
            hintText: 'Ingrese su email',
            textInputType: TextInputType.emailAddress),
        const SizedBox(height: 8.0),
        InputText(
            icon: Icons.key,
            textEditingController: passwordController,
            isPass: true,
            hintText: 'Ingrese su clave',
            textInputType: TextInputType.emailAddress),
        const SizedBox(height: 18.0),
        ElevatedButton(
          onPressed: () {
            showSnackBar(context, "Mensaje",
                "Revise su email para validar la aplicación \n el mail es app.");
            setState(() {
              isSign = true;
            });
          },
          style: ElevatedButton.styleFrom(
            textStyle: const TextStyle(
              fontSize: 18, //fontWeight: FontWeight.bold
            ),
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(20), // Agrega bordes redondeados
            ),
            foregroundColor: Colors.white,
            backgroundColor: Tema.histologyBkcg,
          ),
          child: const Text('Enviar Código'),
        ),
        const SizedBox(height: 8),
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
    );
  }
}
