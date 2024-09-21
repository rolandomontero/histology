// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:histology/Libro/screen_indice.dart';
// import 'package:histology/web_view_container.dart';
//import 'firebase_options.dart';

class HistologyClass extends StatefulWidget {
  const HistologyClass({super.key});
  @override
  State<HistologyClass> createState() => _HistologyClassState();
}

class _HistologyClassState extends State<HistologyClass> {
  @override
  Widget build(BuildContext context) {
    return const ScreenIndice();
  }
}
