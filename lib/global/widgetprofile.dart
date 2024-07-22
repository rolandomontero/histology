import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:histology/global/colores.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShowProfile extends StatefulWidget {
  final bool editar;

  const ShowProfile({
    Key? key,
    required this.editar,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ShowProfileState createState() => _ShowProfileState();
}

class _ShowProfileState extends State<ShowProfile> {
  Uint8List? imagen;
  File? selectedImage;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    final imgString = prefs.getString('imgProfile');
    if (imgString != null) {
      setState(() {
        imagen = base64Decode(imgString);
      });
    }
  }

  Future<void> _saveData() async {
    if (imagen != null) {
      final prefs = await SharedPreferences.getInstance();
      final imgString = base64Encode(imagen!);
      await prefs.setString('imgProfile', imgString);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        imagen != null
            ? CircleAvatar(
                radius: 64,
                backgroundImage: MemoryImage(imagen!),
              )
            : const CircleAvatar(
                radius: 64,
                backgroundImage: AssetImage('assets/images/icons/user.png'),
              ),
        if (widget.editar)
          Positioned(
            bottom: -.0,
            right: -1.0,
            child: IconButton(
              onPressed: () {
                showImagePickerOption(context);
              },
              icon: const Icon(
                Icons.add_a_photo,
                color: Tema.histologyBkcg,
                size: 32,
              ),
            ),
          )
      ],
    );
  }

  void showImagePickerOption(BuildContext context) {
    showModalBottomSheet(
      barrierLabel: "Seleccione medio",
      backgroundColor: Tema.histologySolid,
      context: context,
      builder: (builder) {
        return Padding(
          padding: const EdgeInsets.all(18.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 8,
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      pickImagenFromGallery();
                      Navigator.of(context).pop(); // Close the modal sheet
                    },
                    child: const SizedBox(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 12,
                          ),
                          Icon(
                            Icons.image,
                            color: Tema.histologyBkcg,
                            size: 48,
                          ),
                          Text("Galería")
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      pickImagenFromCamera();
                      Navigator.of(context).pop(); // Close the modal sheet
                    },
                    child: const SizedBox(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 12,
                          ),
                          Icon(
                            Icons.camera_alt,
                            color: Tema.histologyBkcg,
                            size: 48,
                          ),
                          Text("Cámara")
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> pickImagenFromGallery() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnImage == null) return;
    setState(() {
      selectedImage = File(returnImage.path);
      imagen = File(returnImage.path).readAsBytesSync();
      _saveData();
    });
  }

  Future<void> pickImagenFromCamera() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnImage == null) return;
    setState(() {
      selectedImage = File(returnImage.path);
      imagen = File(returnImage.path).readAsBytesSync();
      _saveData();
    });
  }
}
