import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:histology/Libro/screen_indice.dart';
import 'package:histology/global/constantes.dart';
import 'package:histology/global/widgetprofile.dart';
import 'package:histology/login_sign/Widget/input_text.dart';
import 'package:histology/login_sign/Widget/snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'dart:math';

import 'package:histology/login_sign/services/authentication.dart';

class SignScreen extends StatefulWidget {
  const SignScreen({super.key});

  @override
  State<SignScreen> createState() => _SignScreenState();
}

class _SignScreenState extends State<SignScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isSign = false;

  final TextEditingController schoolController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  final String senderEmail = 'info@mclautaro.cl';
  final String senderPassword = 'Rmx21071972#';

  String verificationCode = '';
  bool registrado = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    schoolController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  /// Genera un código de verificación aleatorio con 3 letras y 4 dígitos.
  String generateRandomCode() {
    final random = Random();
    final letters = List.generate(3, (_) => String.fromCharCode(65 + random.nextInt(26))).join();
    final number = random.nextInt(9000) + 1000;
    return '$letters$number';
  }

  /// Envía un correo electrónico con el código de verificación.
  Future<void> sendEmail(String nombre, String email) async {
    final smtpServer = SmtpServer('mail.mclautaro.cl',
        port: 465, ssl: true, username: senderEmail, password: senderPassword);
    verificationCode = generateRandomCode();
    final message = Message()
      ..from = Address(senderEmail, 'App Histology Plus')
      ..recipients.add(email)
      ..subject = 'Código de Verificación: $verificationCode'
      ..html = '''
        <center>
          <img src="https://histologyplus.mclautaro.cl/img/eicon.png" width="64" height="64"/>
          <p>Hisology Plus</p>
        </center>
        <h1>Hola!, $nombre</h1>
        <p>Introduce el código manualmente en la aplicación. Aquí está el código:</p>
        <center><H2>$verificationCode</H2></center>
      ''';

    try {
      await send(message, smtpServer);
      debugPrint('Mensaje enviado');
    } on MailerException catch (e) {
      debugPrint('Error al enviar el mensaje: $e');
      for (var p in e.problems) {
        debugPrint('Problema: ${p.code}: ${p.msg}');
      }
    }
  }

  /// Carga datos guardados previamente usando SharedPreferences.
  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      nameController.text = prefs.getString('nombre') ?? '';
      emailController.text = prefs.getString('email') ?? '';
      schoolController.text = prefs.getString('colegio') ?? '';
    });
  }

  /// Guarda los datos ingresados y llama a la función de registro de usuario.
  Future<void> _saveData() async {
    await sendEmail(nameController.text, emailController.text);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('nombre', nameController.text);
    await prefs.setString('email', emailController.text);
    await prefs.setString('colegio', schoolController.text);

    String res = await AuthMethod().signupUser(
        email: emailController.text,
        password: passwordController.text,
        name: nameController.text,
        school: schoolController.text);
    debugPrint("$res ");
  }

  /// Valida si un correo electrónico es válido.
  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor ingrese un correo electrónico';
    }
    String pattern = r'^[^@]+@[^@]+\.[^@]+';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Ingrese un correo electrónico válido';
    }
    return null;
  }

  /// Valida si un campo de entrada no está vacío.
  String? inputValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Este campo es obligatorio';
    }
    return null;
  }

  /// Construye el formulario de registro.
  Widget _buildSignUpForm() {
    return Column(
      children: [
        InputText(
          icon: Icons.person,
          textEditingController: nameController,
          hintText: 'Nombre(s) y apellido(s)',
          textInputType: TextInputType.text,
          validator: inputValidator,
        ),
        InputText(
          icon: Icons.email,
          textEditingController: emailController,
          hintText: 'Correo electrónico',
          textInputType: TextInputType.emailAddress,
          validator: emailValidator,
        ),
        InputText(
          icon: Icons.school,
          textEditingController: schoolController,
          hintText: 'Establecimiento educativo',
          textInputType: TextInputType.text,
          validator: inputValidator,
        ),
        InputText(
          icon: Icons.key,
          textEditingController: passwordController,
          hintText: 'Contraseña',
          textInputType: TextInputType.text,
          validator: inputValidator,
          isPass: true,
        ),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState?.validate() == true) {
              setState(() {
                _saveData();
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const ScreenIndice(),
                ));
              });
            } else {
              showSnackBar(context, "Error",
                  "Se encontraron errores en el formulario. Todos los campos son obligatorios.");
            }
          },
          style: ElevatedButton.styleFrom(
            textStyle: const TextStyle(fontSize: 18),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            foregroundColor: Colors.white,
            backgroundColor: Tema.histologyBkcg,
          ),
          child: Text(registrado ? 'Actualizar' : 'Registrar'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Tema.histologyBkcg,
        title: Center(
          child: Text(
            "Registro de Usuario",
            textAlign: TextAlign.center,
            style: GoogleFonts.acme(
              color: Colors.white,
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/wallpaper/w2.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              const SizedBox(height: 18),
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
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          const SizedBox(height: 12.0),
                          const ShowProfile(editar: true),
                          _buildSignUpForm(),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
