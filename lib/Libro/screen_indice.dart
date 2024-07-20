import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:histology/Libro/class_indice.dart';

class ScreenIndice extends StatefulWidget {
  const ScreenIndice({super.key});

  @override
  State<ScreenIndice> createState() => _ScreenIndiceState();
}

class _ScreenIndiceState extends State<ScreenIndice> {
  static const Color histologyBkcg = Color(0xFF895476);
  static const Color histologyColor = Color(0xDCE8D9C7);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Histology +'),
        centerTitle: true,
        titleTextStyle: const TextStyle(
            color: Colors.white,
            fontFamily: 'Montserrat',
            fontSize: 22,
            fontWeight: FontWeight.bold),
        // toolbarHeight: 80,
        backgroundColor: histologyBkcg,
        elevation: 8.0,
        shadowColor: Colors.grey,
        //automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.notifications,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/wallpaper/w2.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(children: [
            content(),
            Expanded(
              child: listaContenidos(temas),
            ),
          ]),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'Lecciones',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble),
            label: 'Mensajes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.emoji_events),
            label: 'Progreso',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
        selectedItemColor: const Color(0xffffffff),
        unselectedItemColor: histologyColor,
        backgroundColor: histologyBkcg,
      ),
    );
  }

  Widget content() {
    return Center(
        child: ElevatedButton(
      onPressed: () {
        Navigator.of(context).pushNamed('/webViewContainer');
      },
      child: const Text("Introducción"),
    ));
  }

  Widget listaContenidos(tema) {
    return ListView.builder(
        itemCount: tema.length,
        itemBuilder: (BuildContext context, int index) {
          final miTema = tema[index];
          final int colorValue =
              (int.parse(miTema.color.toString(), radix: 16));
          Color micolor = Color(colorValue);

          return Column(
            children: [
              const SizedBox(
                height: 22,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 6.0),
                        decoration: BoxDecoration(
                          color: micolor,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0),
                          ),
                        ),
                        child: Row(
                          children: [
                            const SizedBox(width: 14.0),
                            CircleAvatar(
                              radius: 37,
                              backgroundImage: AssetImage(miTema.imagePath),
                            ),
                            Expanded(
                              child: Text(
                                miTema.tema,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.acme(
                                    color: Colors.white,
                                    fontSize: 32.0,
                                    fontWeight: FontWeight.bold,
                                    height: 0.8),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.timelapse_rounded,
                                ),
                                Text(miTema.minutos),
                                Text(miTema.gd)
                              ],
                            ),
                            const SizedBox(width: 12.0),
                          ],
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        'Descripción',
                        style: GoogleFonts.acme(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                        textAlign: TextAlign.right,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          miTema.descripcion,
                          textAlign: TextAlign.justify,
                          style: const TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8.0),
                    ],
                  ),
                ),
              )
            ],
          );
        });
  }
}
