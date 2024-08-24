import 'dart:io';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import '../../global/constantes.dart';

class VerifyEmail {
  final String senderEmail = Email.senderEmail;
  final String senderPassword = Email.senderPassword;

  /// Genera un código de verificación aleatorio con 3 letras y 4 dígitos.
  String generateRandomCode() {
    final random = Random();
    final letters = List.generate(3, (_) => String.fromCharCode(65 + random.nextInt(26))).join();
    final number = random.nextInt(9000) + 1000;
    return '$letters$number';
  }

  /// Envía un correo electrónico con el código de verificación al destinatario.
  ///
  /// [email] es la dirección de correo del destinatario.
  /// [nombre] es el nombre del destinatario.
  /// [name] es el nombre del remitente que aparecerá en el correo.
  Future<void> sendEmail({
    required String email,
    required String nombre,
    required String name,
  }) async {
    final smtpServer = SmtpServer('histologyplus.mclautaro.cl',
        username: senderEmail, password: senderPassword);

    final String verificationCode = generateRandomCode();

    final message = Message()
      ..from = Address(senderEmail, name)
      ..recipients.add(email)
      ..subject = 'Código de Verificación: $verificationCode ${DateTime.now()}'
      ..html = '''
        <img src="cid:myimg@3.141" alt="Icono"/>
        <h2>Hola, $nombre</h2>
        <p>Introduce el código manualmente en la aplicación. Aquí está el código:</p>
        <h1>$verificationCode</h1>
      '''
      ..attachments = [
        FileAttachment(File('assets/images/eicon.png'))
          ..location = Location.inline
          ..cid = 'myimg@3.141',
      ];

    try {
      final sendReport = await send(message, smtpServer);
      if (kDebugMode) {
        print('Mensaje enviado: $sendReport');
      }
    } on MailerException catch (e) {
      if (kDebugMode) {
        print('Error al enviar el mensaje: $e');
        for (var p in e.problems) {
          print('Problema: ${p.code}: ${p.msg}');
        }
      }
    }
  }
}
