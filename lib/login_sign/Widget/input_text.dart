import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:histology/global/constantes.dart';

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
  final Widget? iconEdit;
  final String? Function(String?)? validator;
  final bool readOnly;

  const InputText({
    super.key,
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
    this.textAlign = TextAlign.start,
    this.validator,
    this.readOnly=false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            readOnly: readOnly,
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
              errorText: validator?.call(textEditingController.text),

             suffixIcon: iconEdit,),
           
            style: TextStyle(
              fontSize: fontSize,
              color: colortext,
              fontWeight: fontWeight,
            ),
          ),
          Center(
            child: Text(
              hintText,
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
