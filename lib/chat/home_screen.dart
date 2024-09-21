import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:histology/Widget/navbar.dart';
import '../global/constantes.dart';
import 'message_wdget.dart';

class HomeScreenChat extends StatefulWidget {
  const HomeScreenChat({super.key});

  @override
  State<HomeScreenChat> createState() => _HomeScreenChat();
}

class _HomeScreenChat extends State<HomeScreenChat> {
  late final GenerativeModel _model;
  late final ChatSession _chatSession;
  final FocusNode _textFielFocus = FocusNode();
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _model = GenerativeModel(
      model: 'gemini-1.5-flash',
      //'gemini-1.5-flash-latest',
      apiKey: 'AIzaSyBOeTYiezy7jIFgLcY0qqB621fnNSLUzUY',
      //'AIzaSyCJcPJs3kOthfG92zTAXDs46MdpG-DO9t8', //'AIzaSyABRDrSCecr8byHGRDEex9OA5Uh-YAW4Ic',AIzaSyBOeTYiezy7jIFgLcY0qqB621fnNSLUzUY
      generationConfig: GenerationConfig(
        temperature: 1,
        topK: 64,
        topP: 0.95,
        maxOutputTokens: 8192,
        responseMimeType: 'text/plain',
      ),

      systemInstruction: Content.system(
          'Actúa como un experto en histología y un excelente docente en la materia. En este chat, solo discutiremos aspectos exclusivamente relacionados con la histología. Proporciona explicaciones detalladas, resuelve dudas, y ofrece ejemplos claros y concisos para facilitar la comprensión de los conceptos histológicos. Además, comparte consejos y recursos pedagógicos para mejorar el aprendizaje en esta disciplina.'),
    );
    
    _chatSession = _model.startChat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            "Chat",
            textAlign: TextAlign.center,
            style: GoogleFonts.acme(
                color: Colors.white,
                fontSize: 42.0,
                fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          titleTextStyle: const TextStyle(
              color: Colors.white,
              fontFamily: 'Montserrat',
              fontSize: 22,
              fontWeight: FontWeight.bold),
          // toolbarHeight: 80,
          backgroundColor: Tema.histologyBkcg,
          elevation: 8.0,
          shadowColor: Colors.grey,
        ),
        body: Container(
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/wallpaper/w2.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              //   mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: ListView.builder(
                        controller: _scrollController,
                        itemCount: _chatSession.history.length,
                        itemBuilder: (context, index) {
                          final Content content =
                              _chatSession.history.toList()[index];
                          final text = content.parts
                              .whereType<TextPart>()
                              .map<String>(
                                (e) => e.text,
                              )
                              .join('');
                          return MessageWdget(
                            text: text,
                            isFromUser: content.role == 'user',
                          );
                        })),
                                               
                Padding(
                  padding: const EdgeInsets.only(
                    top: 12,
                    bottom: 42,
                    left: 8,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          //autofocus: true,
                          maxLines: null,
                          focusNode: _textFielFocus,
                          decoration: textFieldDecoration(),
                          controller: _textController,
                          onSubmitted: _sendChatMessenge,
                        ),
                      ),
                      const SizedBox(width: 68), // Espacio de 32 a la derecha
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          tooltip: 'IA Asistente', // used by assistive technologies
          onPressed: () {
            setState(() {
              _sendChatMessenge(_textController.text);
            });
          },
          shape: const CircleBorder(),
          backgroundColor: Tema.histologyBkcg,
          child: const Icon(
            Icons.send,
            color: Colors.white,
          ),
        ));
    // bottomNavigationBar: const BotonNavegacionBarra(1));
  }

  InputDecoration textFieldDecoration() {
    return InputDecoration(
     
      contentPadding: const EdgeInsets.all(8),
      hintText:  _loading ? 'Procesando...' : 'Ingrese un pregunta...',
      filled: true,
      // Set filled to true for a filled background
      fillColor: Colors.white,
      // Set the fill color to white
      border: OutlineInputBorder(
        borderRadius: const BorderRadius.all(
          Radius.circular(14),
        ),
        borderSide: BorderSide(
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),

      focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(14),
          ),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.secondary,
          )),
     suffixIcon: _loading
       ? ClipRRect(
           borderRadius: BorderRadius.circular(4.0), // La mitad de 8.0 (height/width)
           child: Image.asset(
             'assets/images/monocito.gif',
             height: 8,
             width: 8,
             fit: BoxFit.cover, // Ajusta la imagen al círculo
           ),
         )
       : const Icon(Icons.keyboard),
     
    );
  }

  Future<void> _sendChatMessenge(String message) async {
    setState(() {
      _loading = true;
    });

    try {
      final response = await _chatSession.sendMessage(
        Content.text(message),
      );
      final text = response.text;
      if (text == null) {
        _showError('No responde el API.');
        return;
      } else {
        setState(() {
          _loading = false;
          _scrollDown();
        });
      }
    } catch (e) {
      _showError(e.toString());
      setState(() {
        _loading = false;
      });
    } finally {
      _textController.clear();
      setState(() {
        _loading = false;
      });
      //_textFielFocus.requestFocus();
      _textFielFocus.unfocus();
    }
  }

  void _scrollDown() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(
          microseconds: 50,
        ),
        curve: Curves.easeOutCirc,
      );
    });
  }

  void _showError(String message) {
    showDialog<void>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Algo paso'),
            content: SingleChildScrollView(
              child: SelectableText(message),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cerrar'),
              )
            ],
          );
        });
  }
}
