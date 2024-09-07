import 'package:flutter/material.dart';
import 'package:histology/global/constantes.dart';

showSnackBar(BuildContext context, String titulo, arg) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Tema.histologyBkcg,
      content:
       Column(
        children: [
        //  const SizedBox(height: 8.0,),
       Text(
        titulo,
        textAlign: TextAlign.center,
        style:  const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16
        ),
      ),
       const SizedBox(height: 12.0,),
       Text(
        arg,
        textAlign: TextAlign.center,
        
      ),
        ],
        
      ),
       
      duration: const Duration(seconds: 5),
      //elevation: 10.0,
      closeIconColor: Tema.histologySolid,
    ),
  );
}
