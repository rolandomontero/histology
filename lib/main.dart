import 'package:flutter/material.dart';
import 'package:histology/Libro/screen_indice.dart';
import 'package:histology/login_sign/screen/loginscreen.dart';
import 'package:histology/web_view_container.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: const Color(0xFF895476),
        brightness: Brightness.light,
        useMaterial3: true,
      ),
      routes: {
        '/': (context) => const HistologyClass(),
        '/webViewContainer': (context) => const WebViewContainer()
      },
    ));

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
