// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, must_be_immutable, unused_field, prefer_final_fields, avoid_unnecessary_containers, use_function_type_syntax_for_parameters, curly_braces_in_flow_control_structures, prefer_typing_uninitialized_variables, must_call_super

import 'dart:async';

import 'package:flutter/material.dart';
// ignore: implementation_imports
import 'package:webview_flutter/webview_flutter.dart';

class RecipyView extends StatefulWidget {
  String url;
  RecipyView(this.url);

  @override
  State<RecipyView> createState() => _RecipyViewState();
}

class _RecipyViewState extends State<RecipyView> {
  late final finalUrl;
  // bool isloader = true;
  final Completer<WebViewController> controler = Completer<WebViewController>();
  @override
  void initState() {
    if (widget.url.toString().contains("http")) {
      finalUrl = widget.url.toString().replaceAll("http://", "https://");
    } else {
      finalUrl = widget.url;
    }
  
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Food Recipy",style: TextStyle(color: Colors.white),),
          backgroundColor: Colors.purple[300],
        ),
        body:  WebView(
                initialUrl: finalUrl,
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (WebViewController webViewController) {
                  setState(() {
                    // isloader = false;
                    controler.complete(webViewController);
                  });
                },
              ));
  }
}
