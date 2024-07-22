import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:histology/global/colores.dart';

class InputText extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool isPass;
  final String hintText;
  final IconData? icon;
  final TextInputType textInputType;
  final double? fontSize;
  final bool mayuscula;
  final Color colortext;
  final FontWeight? fontWeight;
  final TextAlign textAlign;
  final IconData? iconEdit;

  const InputText(
      {super.key,
      required this.textEditingController,
      required this.textInputType,
      required this.hintText,
      this.mayuscula = false,
      this.isPass = false,
      this.fontSize,
      this.icon,
      this.iconEdit,
      this.colortext = Colors.black,
      this.fontWeight = FontWeight.normal,
      this.textAlign = TextAlign.start});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 6),
        child: Column(
          children: [
            TextField(
                textAlign: textAlign,
                textCapitalization: mayuscula
                    ? TextCapitalization.characters
                    : TextCapitalization.none,
                inputFormatters: mayuscula
                    ? [FilteringTextInputFormatter.allow(RegExp('[A-Z0-9]'))]
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
                  color: colortext,
                  fontWeight: fontWeight,
                )),
            Text(
              hintText,
            ),
          ],
        ));
  }
}
