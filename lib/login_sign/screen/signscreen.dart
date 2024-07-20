import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/foundation.dart';
import 'package:histology/global/colores.dart';
import 'package:histology/login_sign/Widget/input_text.dart';
import 'package:image_picker/image_picker.dart';

import 'package:flutter_masked_text2/flutter_masked_text2.dart';

class SignScreen extends StatefulWidget {
  const SignScreen({super.key});

  @override
  State<SignScreen> createState() => _SignScreenState();
}

class _SignScreenState extends State<SignScreen> {
  final bool isSign = false;
  Uint8List? _image;
  File? selectedIMage;
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
                          Stack(
                            children: [
                              _image != null
                                  ? CircleAvatar(
                                      radius: 64,
                                      backgroundImage: MemoryImage(_image!),
                                    )
                                  : const CircleAvatar(
                                      radius: 64,
                                      backgroundImage: AssetImage(
                                          'assets/images/icons/user_hst.png'),
                                    ),
                              Positioned(
                                  bottom: -10.0,
                                  right: -1.0,
                                  child: IconButton(
                                    onPressed: () {
                                      showImagePickerOption(context);
                                    },
                                    icon: const Icon(
                                      Icons.add_a_photo,
                                      color: Tema.histologyBkcg,
                                      size: 36,
                                    ),
                                  ))
                            ],
                          ),
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
                          InputText(
                              icon: Icons.phone_android,
                              textEditingController: phoneController,
                              hintText: 'Teléfono',
                              textInputType: TextInputType.phone),
                          if (isSign == false)
                            Column(children: [
                              InputText(
                                  icon: Icons.school,
                                  textEditingController: schoolController,
                                  hintText: 'Establecimiento educativo',
                                  textInputType: TextInputType.text),
                              const SizedBox(height: 8),
                              ElevatedButton(
                                onPressed: () {},
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

  void showImagePickerOption(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Padding(
            padding: const EdgeInsets.all(18.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 8,
              child: Row(children: [
                Expanded(
                    child: InkWell(
                  onTap: () {
                    _pickImageFromGallery();
                  },
                  child: const SizedBox(
                      child: Column(
                    children: [
                      Icon(
                        Icons.image,
                        color: Tema.histologyBkcg,
                        size: 48,
                      ),
                      Text("Galeria")
                    ],
                  )),
                )),
                Expanded(
                    child: InkWell(
                  onTap: () {
                    _pickImageFromCamera();
                  },
                  child: const SizedBox(
                      child: Column(
                    children: [
                      Icon(
                        Icons.camera_alt,
                        color: Tema.histologyBkcg,
                        size: 48,
                      ),
                      Text("Cámara")
                    ],
                  )),
                )),
              ]),
            ),
          );
        });
  }

  //Gallery
  Future _pickImageFromGallery() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnImage == null) return;
    setState(() {
      selectedIMage = File(returnImage.path);
      _image = File(returnImage.path).readAsBytesSync();
    });
    // Navigator.of(context).pop(); //close the model sheet
  }

//Camera
  Future _pickImageFromCamera() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnImage == null) return;
    setState(() {
      selectedIMage = File(returnImage.path);
      _image = File(returnImage.path).readAsBytesSync();
    });
    // Navigator.of(context).pop();
  }
}
