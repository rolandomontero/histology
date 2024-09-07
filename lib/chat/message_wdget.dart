import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class MessageWdget extends StatelessWidget {
  const MessageWdget({
    super.key,
    required this.text,
    required this.isFromUser,
  });

  final String text;
  final bool isFromUser;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: Theme(
            data: ThemeData(
              textTheme: const TextTheme(
                bodyLarge: TextStyle(color: Colors.white),
              ),
              primaryColor: const Color(0xFFECC759),

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
                    ? Color(0xFFECC759)//Theme.of(context).colorScheme.primary.withOpacity(0.8)
                    : Color(0xFFD99992),//Theme.of(context).colorScheme.secondary.withOpacity(0.8),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                children: [
                  MarkdownBody(
                    data: text,
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }


}
