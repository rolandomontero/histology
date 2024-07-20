import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewContainer extends StatefulWidget {
  const WebViewContainer({super.key});

  @override
  State<WebViewContainer> createState() => _WebViewContainerState();
}

class _WebViewContainerState extends State<WebViewContainer> {
  bool _isLoaded = false;

// Aquí iniciamos el navegador
  final controller = WebViewController();
  @override
  void initState() {
    super.initState();
    controller.setJavaScriptMode(JavaScriptMode.unrestricted);
    controller.setNavigationDelegate(NavigationDelegate(
      onPageFinished: (url) => setState(() {
        _isLoaded = true;
      }),
    ));
    controller.loadRequest(
        Uri.parse('https://histologyplus.mclautaro.cl/clases/CLASE01/'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contenedor clase"),
        backgroundColor:  const Color(0xFF895476),
        foregroundColor: const Color(0xffffffff),
      ),
      body: _isLoaded
          ? WebViewWidget(controller: controller) // Show WebView after loading
          : const Center(
              child:
                  CircularProgressIndicator()), // Show loading indicator initially
    );
  }
}
