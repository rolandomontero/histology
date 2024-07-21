import 'package:flutter/material.dart';
import 'package:histology/global/colores.dart';

class InputText extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool isPass;
  final String hintText;
  final IconData? icon;
  final TextInputType textInputType;
  final double? fontSize;
  final bool mayuscula;

  const InputText({
    super.key,
    required this.textEditingController,
    required this.textInputType,
    required this.hintText,
    this.mayuscula = false,
    this.isPass = false,
    this.fontSize,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 6),
        child: Column(
          children: [
            TextField(
                textCapitalization: mayuscula
                    ? TextCapitalization.characters
                    : TextCapitalization.none,
                inputFormatters: mayuscula
                    ? [FilteringTextInputFormatter.allow(RegExp('[A-Z]'))]
                    : [],
                controller: textEditingController,
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
                style: TextStyle(
                  fontSize: fontSize,
                  color: Colors.black,
                  //fontWeight: FontWeight.bold,
                )),
            Text(
              hintText,
            ),
          ],
        ));
  }
}
