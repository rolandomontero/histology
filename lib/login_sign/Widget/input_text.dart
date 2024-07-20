import 'package:flutter/material.dart';
import 'package:histology/global/colores.dart';

class InputText extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool isPass;
  final String hintText;
  final IconData? icon;
  final TextInputType textInputType;

  const InputText({
    super.key,
    required this.textEditingController,
    this.isPass = false,
    required this.hintText,
    this.icon,
    required this.textInputType,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 6),
        child: Column(
          children: [
            TextField(
                keyboardType: textInputType,
                obscureText: isPass,
                decoration: InputDecoration(
                  icon: Icon(
                    icon,
                    color: Tema.histologyBkcg,
                    size: 28,
                  ),
                  prefixIconColor: Tema.histologyBkcg,
                ),
                style: const TextStyle(
                  //fontSize: 14,
                  color:Colors.black,
                  //fontWeight: FontWeight.bold,
                )),
            Text(
              hintText,
            ),
          ],
        ));
  }
}
