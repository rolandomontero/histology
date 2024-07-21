import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:histology/global/colores.dart';
import 'package:histology/global/widgetprofile.dart';
import 'package:histology/login_sign/Widget/input_text.dart';
import 'package:histology/login_sign/Widget/snackbar.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';

class SignScreen extends StatefulWidget {
  const SignScreen({super.key});

  @override
  State<SignScreen> createState() => _SignScreenState();
}

class _SignScreenState extends State<SignScreen> {
  bool isSign = false;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController =
      MaskedTextController(mask: '+56900000000', text: '+56');
  final TextEditingController schoolController = TextEditingController();

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
            child: Column(children: [
              const SizedBox(
                height: 18,
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
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        children: [
                          const SizedBox(height: 12.0),
                          const ShowProfile(editar: true),
                          InputText(
                              icon: Icons.person,
                              textEditingController: nameController,
                              hintText: 'Nombre(s) y apellido(s)',
                              textInputType: TextInputType.text),
                          InputText(
                              icon: Icons.email,
                              textEditingController: emailController,
                              hintText: 'Correo eléctronico',
                              textInputType: TextInputType.emailAddress),
                          if (isSign == false)
                            Column(children: [
                              InputText(
                                  icon: Icons.phone_android,
                                  textEditingController: phoneController,
                                  hintText: 'Teléfono',
                                  textInputType: TextInputType.phone),
                              InputText(
                                  icon: Icons.school,
                                  textEditingController: schoolController,
                                  hintText: 'Establecimiento educativo',
                                  textInputType: TextInputType.text),
                              const SizedBox(height: 8),
                              ElevatedButton(
                                onPressed: () {
                                  showSnackBar(context, "Mensaje",
                                      "Revise su email para validar la aplicación");
                                  setState(() {
                                    isSign = true;
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  textStyle: const TextStyle(
                                    fontSize: 18, //fontWeight: FontWeight.bold
                                  ),
                                  // Cambia el color del botón a verde
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        20), // Agrega bordes redondeados
                                  ),
                                  foregroundColor: Colors.white,
                                  backgroundColor: Tema.histologyBkcg,
                                ),
                                child: const Text('Registrarse'),
                              ),
                            ])
                          else if (isSign == true)
                            Column(
                              children: [
                                const TextField(
                                    textAlign: TextAlign.center,
                                    decoration: InputDecoration(
                                      // labelText: 'Tu Nombre',
                                      // prefixIcon: Icon(Icons.person),
                                      prefixIconColor: Tema.histologyBkcg,
                                    ),
                                    style: TextStyle(
                                        fontSize: 32,
                                        fontWeight: FontWeight.bold,
                                        color: Tema.histologyBkcg)),
                                const Text(
                                  'Código activación',
                                ),
                                const SizedBox(height: 32),
                                ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    textStyle: const TextStyle(
                                      fontSize:
                                          18, //fontWeight: FontWeight.bold
                                    ),
                                    // Cambia el color del botón a verde
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          20), // Agrega bordes redondeados
                                    ),
                                    foregroundColor: Colors.white,
                                    backgroundColor: Tema.histologyBkcg,
                                  ),
                                  child: const Text('Activar'),
                                ),
                              ],
                            ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    )),
              )
            ])),
      ),
    );
  }
}
