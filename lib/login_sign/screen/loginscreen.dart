import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:histology/Libro/screen_indice.dart';
import 'package:histology/global/constantes.dart';
import 'package:histology/global/widgetprofile.dart';
import 'package:histology/login_sign/screen/signscreen.dart';
import 'package:histology/login_sign/Widget/input_text.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Widget/snackbar.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'dart:math';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final String senderEmail = 'app@histologyplus.mclautaro.cl';
  final String senderPassword = 'Rmx21071972#';
 
  String verificationCode = '';
  bool isSign = false;
  bool registrado = false;
  bool isLoading = false;
  String nombre = '';
  String email = '';

  static const int currentPageIndex = 3;
  TextEditingController emailController = TextEditingController();
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


  String generateRandomCode() {
  final random = Random();
  final letters = List.generate(3, (_) => String.fromCharCode(65 + random.nextInt(26))).join();
  final number = random.nextInt(9000) + 1000;
  return '$letters$number';
}

  Future<void> sendEmail() async {
    final smtpServer = SmtpServer('histologyplus.mclautaro.cl',
        username: senderEmail, password: senderPassword);
    verificationCode = generateRandomCode();


    final message = Message()
      ..from = Address(senderEmail, 'App')
      ..recipients.add(email)
      ..subject = 'Código de Verificación: $verificationCode ${DateTime.now()}'
      //..text = 'Su código de verificación es: $verificationCode'
       ..html = '<img src="cid:myimg@3.141"/><h2>Hola!, $nombre</h2>\n<p>Introduce el código manualmente en la aplicación. Aquí está el código:</p><H1>$verificationCode</H1>'
    ..attachments = [
      FileAttachment(File('assets/images/eicon.png'))
        ..location = Location.inline
        ..cid = '<myimg@3.141>'
    ];

    try {
      final sendReport = await send(message, smtpServer);
      if (kDebugMode) {
        print('Mensaje enviado: $sendReport');
      }
    } on MailerException catch (e) {
      if (kDebugMode) {
        print('Error al enviar el mensaje: $e');
      }
      for (var p in e.problems) {
        if (kDebugMode) {
          print('Problema: ${p.code}: ${p.msg}');
        }
      }
    }
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      nombre = prefs.getString('nombre') ?? '';
      emailController.text = prefs.getString('email') ?? '';
      isSign = ( prefs.getString('activado') ?? '')!=''?true:false;
      registrado = ( prefs.getString('registrado') ?? '')!=''?true:false;
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
                        true,
                  ),
                );
            }
          });
        },
        indicatorColor: Tema.histologyBkcg,
        selectedIndex: currentPageIndex,
        backgroundColor: Tema.histologySolid,
        animationDuration: const Duration(milliseconds: 1000),
        destinations: const <Widget>[
          NavigationDestination(
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
            icon: Icon(Icons.person,
            color: Colors.white,),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }

  Widget login() {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: isSign ?
      enterProfile():
      activaProfile(),

    );
  }


  Widget enterProfile(){
  return  Column(
      children: [
        const Text("Ingresar",
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

  Widget activaProfile() {
return
    Column(
      children: [
        const SizedBox(
          height: 48,
        ),
        InputText(
          textEditingController: activaController,
          hintText: 'Código de activación',
          textInputType: TextInputType.text,
          fontSize: 32.0,
          mayuscula: true,
          textAlign: TextAlign.center,
          colortext: Tema.histologyBkcg,
          fontWeight: FontWeight.bold,
          iconEdit: const Icon(Icons.clear),
        ),
        const SizedBox(height: 32),
        ElevatedButton(
          onPressed: () {
            setState(() {
              registrado = true;
              _saveDataActivacion();
            });
          },
          style: ElevatedButton.styleFrom(
            textStyle: const TextStyle(
              fontSize:
              18, //fontWeight: FontWeight.bold
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  20),
            ),
            foregroundColor: Colors.white,
            backgroundColor: Tema.histologyBkcg,
          ),
          child: const Text('Activar'),
        ),
      ],
    );

  }

  Widget userProfile() {
    return const Padding(
      padding: EdgeInsets.all(14.0),
      child: Column(
        children: [
          SizedBox(height: 12.0),
          ShowProfile(editar: false),
          SizedBox(height: 42.0),
          TextField(
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                prefixIconColor: Tema.histologyBkcg,
              ),
              style: TextStyle(
                fontSize: 22,
              )),
          Text(
            'email',
          ),
          SizedBox(height: 42.0),
         

          Text(
            'Contraseña',
          ),
          SizedBox(height: 40),


        ],
      ),
    );
  }
}
