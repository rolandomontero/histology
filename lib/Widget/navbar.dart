import 'package:flutter/material.dart';
import 'package:histology/Libro/screen_indice.dart';
import 'package:histology/chat/home_screen.dart';
import 'package:histology/login_sign/screen/home_screen.dart';

class BotonNavegacionBarra extends StatefulWidget {
  final int index;

  const BotonNavegacionBarra(this.index, {super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BotonNavegacionBarraState createState() => _BotonNavegacionBarraState();
}

class _BotonNavegacionBarraState extends State<BotonNavegacionBarra> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.index;
  }

  void _onDestinationSelected(int index) {
    setState(() {
      _currentIndex = index;
      switch (_currentIndex) {
        case 0:
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const ScreenIndice(),
              fullscreenDialog: true,
            ),
          );
          break;
        case 1:
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const HomeScreenChat(),
              fullscreenDialog: true,
            ),
          );
          break;
        case 2:
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const ScreenIndice(), 
              //const ScreenProgress(),
              fullscreenDialog: true,
            ),
          );
          break;
        case 3:
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const HomeScreenLogin(),
              fullscreenDialog: true,
            ),
          );
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      onDestinationSelected: _onDestinationSelected,
      indicatorColor: const Color(0xFFE6E4C0),
      selectedIndex: _currentIndex,
      backgroundColor: const Color(0xFFF2F0E0),
      animationDuration: const Duration(milliseconds: 1000),
      destinations: const <Widget>[
        NavigationDestination(
          icon: Icon(Icons.bookmark),
          label: 'Lecciones',
        ),
        NavigationDestination(
          icon: Icon(Icons.chat_bubble),
          label: 'Chat',
        ),
        NavigationDestination(
          icon: Icon(Icons.emoji_events),
          label: 'Progreso',
        ),
        NavigationDestination(
          icon: Icon(Icons.person),
          label: 'Perfil',
        ),
      ],
    );
  }
}
