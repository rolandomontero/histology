import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:histology/global/constantes.dart';
import 'package:histology/global/widgetprofile.dart';
import 'package:histology/login_sign/Widget/input_text.dart';
import 'package:histology/login_sign/Widget/snackbar.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:histology/login_sign/screen/loginscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'dart:math';

class SignScreen extends StatefulWidget {
  const SignScreen({super.key});

  @override
  State<SignScreen> createState() => _SignScreenState();
}

class _SignScreenState extends State<SignScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isSign = false;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController =
      MaskedTextController(mask: '+56900000000', text: '+56');
  final TextEditingController schoolController = TextEditingController();
  final TextEditingController activaController = TextEditingController();

  final String senderEmail = 'info@mclautaro.cl';
  final String senderPassword = 'Rmx21071972#';

  String verificationCode = '';
  late bool registrado = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    schoolController.dispose();
    activaController.dispose();
    super.dispose();
  }

  String generateRandomCode() {
    final random = Random();
    final letters =
        List.generate(3, (_) => String.fromCharCode(65 + random.nextInt(26)))
            .join();
    final number = random.nextInt(9000) + 1000;
    return '$letters$number';
  }

  Future<void> sendEmail(String nombre, String email) async {
    final smtpServer = SmtpServer('mail.mclautaro.cl',
        port: 465, ssl: true, username: senderEmail, password: senderPassword);
    verificationCode = generateRandomCode();
    final message = Message()
      ..from = Address(senderEmail, 'App Histology Plus')
      ..recipients.add(email)
      ..subject = 'Código de Verificación: $verificationCode'
      ..text = 'Su código de verificación es: $verificationCode'
      ..html =
          '<center><img src="https://histologyplus.mclautaro.cl/img/eicon.png" width="64" height="64"/><p>Hisology Plus</p></center><br> <h1>Hola!, $nombre</h1>\n<p>Introduce el código manualmente en la aplicación. Aquí está el código:</p><center><H2>$verificationCode</H2>';

    try {
      final sendReport = await send(message, smtpServer);
      debugPrint('Mensaje enviado: $sendReport');
    } on MailerException catch (e) {
      debugPrint('Error al enviar el mensaje: $e');
      for (var p in e.problems) {
        debugPrint('Problema: ${p.code}: ${p.msg}');
      }
    }
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      nameController.text = prefs.getString('nombre') ?? '';
      emailController.text = prefs.getString('email') ?? '';
      phoneController.text = prefs.getString('telefono') ?? '';
      schoolController.text = prefs.getString('colegio') ?? '';

      // isSign = (prefs.getString('activado') ?? '') != '' ? true : false;
      registrado = (prefs.getString('activado') ?? '') != '' ? true : false;
    });
  }

  Future<void> _saveData() async {
    await sendEmail(nameController.text, emailController.text);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('nombre', nameController.text);
    await prefs.setString('email', emailController.text);
    await prefs.setString('telefono', phoneController.text);
    await prefs.setString('colegio', schoolController.text);
  }

  Future<void> _saveDataActivacion() async {
    if (activaController.text.isNotEmpty) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('activado', activaController.text);
    }
  }

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

  String? inputValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Este campo es obligatorio';
    }
    return null;
  }

  bool textController(TextEditingController? controller, bool isEmail) {
    String value = controller!.text;
    String pattern = r'^[^@]+@[^@]+\.[^@]+';
    RegExp regex = RegExp(pattern);
    return (value.isNotEmpty) && isEmail ? regex.hasMatch(value) : true;
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
                fontWeight: FontWeight.bold),
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
                          if (!isSign)
                            _buildSignUpForm()
                          else
                            _buildActivationForm(),
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
          icon: Icons.phone_android,
          textEditingController: phoneController,
          hintText: 'Teléfono',
          textInputType: TextInputType.phone,
          validator: inputValidator,
        ),
        InputText(
          icon: Icons.school,
          textEditingController: schoolController,
          hintText: 'Establecimiento educativo',
          textInputType: TextInputType.text,
          validator: inputValidator,
        ),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: () {
            isSign = textController(nameController, false) &&
                textController(phoneController, false) &&
                textController(emailController, true) &&
                textController(schoolController, false);
            if (isSign) {
              showSnackBar(context, "Mensaje",
                  "Revise su email para validar la aplicación \n Si no lo encuentra busque en spam, como App Histology Plus");
              setState(() {
                _saveData();
              });
            } else {
              showSnackBar(context, "Error",
                  "Se encontraron errores en el formulario por favor revise. Todos los campos son obligatorios.");
            }
          },
          style: ElevatedButton.styleFrom(
            textStyle: const TextStyle(
              fontSize: 18,
            ),
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

  Widget _buildActivationForm() {
    return Column(
      children: [
        const SizedBox(height: 48),
        InputText(
          textEditingController: activaController,
          hintText: 'Código de activación',
          textInputType: TextInputType.text,
          fontSize: 32.0,
          mayuscula: true,
          colortext: Tema.histologyBkcg,
          fontWeight: FontWeight.bold,
        ),
        const SizedBox(height: 32),
        ElevatedButton(
          onPressed: () {
            if (activaController.text == verificationCode) {
              _saveDataActivacion();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
              );
            } else {
              showSnackBar(context, "Error",
                  "La clave no corresponde a la enviada.\n Intente de nuevo.");
            }
          },
          style: ElevatedButton.styleFrom(
            textStyle: const TextStyle(
              fontSize: 18,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            foregroundColor: Colors.white,
            backgroundColor: Tema.histologyBkcg,
          ),
          child: const Text('Activar'),
        ),
      ],
    );
  }
}
