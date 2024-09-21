import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:histology/global/constantes.dart';

class MessageWdget extends StatelessWidget {
  const MessageWdget({
    super.key,
    required this.name,
    required this.text,
    required this.isFromUser,
    required this.backgroundImage,
  });

  final String text;
  final String name;
  final bool isFromUser;
  final ImageProvider? backgroundImage;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: Theme(
            data: ThemeData(
              textTheme: const TextTheme(
                bodyLarge: TextStyle(color: Color(0xFF000000)),
              ),
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 15,
                horizontal: 20,
              ),
              margin: const EdgeInsets.only(bottom: 8),
              constraints: const BoxConstraints(maxWidth: 520),
              decoration: BoxDecoration(
                color: isFromUser
                    ? const Color(
                        0xFFFFFFFF) //Theme.of(context).colorScheme.primary.withOpacity(0.8)
                    : const Color.fromARGB(242, 255, 187,
                        179), //Theme.of(context).colorScheme.secondary.withOpacity(0.8),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      !isFromUser
                          ? const CircleAvatar(
                              radius: 18,
                              backgroundImage:
                                  AssetImage('assets/images/logo.png'),
                            )
                          : CircleAvatar(
                              radius: 18,
                              backgroundImage: backgroundImage ??
                                  const AssetImage(
                                      'assets/images/icons/user.png'),
                            ),
                      !isFromUser
                          ? const Text(
                              ' Asistente IA',
                              style: TextStyle(
                                fontSize: 20.0,
                                color: Tema.histologyBkcg,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          : Text(
                              ' $name',
                              style: const TextStyle(
                                fontSize: 20.0,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ],
                  ),
                  MarkdownBody(
                      styleSheet: MarkdownStyleSheet(
                        p: const TextStyle(
                          fontSize: 18.0,
                          // color: isFromUser? Colors.black: Colors.white,
                        ), // Tamaño de fuente para párrafos
                        h1: const TextStyle(
                            fontSize:
                                24.0), // Tamaño de fuente para encabezados h1
                        // ... otros estilos para diferentes elementos Markdown
                      ),
                      data: text)
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
