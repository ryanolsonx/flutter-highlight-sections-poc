import 'package:flutter/material.dart';
import 'dart:js_interop';

@JS()
@staticInterop
class JSWindow {}

extension JSWindowExtension on JSWindow {
  external void addEventListener(JSString type, JSFunction listener);
  external void postMessage(JSAny message, JSAny targetOrigin);
  external JSWindow? get parent;
}

@JS()
@staticInterop
class JSMessageEvent {}

extension JSMessageEventExtension on JSMessageEvent {
  external JSAny get data;
}

@JS('window')
external JSWindow get window;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const AI(),
    );
  }
}

class AI extends StatelessWidget {
  const AI({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [MessageListener()],
        ),
      ),
    );
  }
}

class MessageListener extends StatefulWidget {
  const MessageListener({super.key});

  @override
  State<MessageListener> createState() => _MessageListenerState();
}

class _MessageListenerState extends State<MessageListener> {
  String current = '';

  @override
  void initState() {
    super.initState();
    window.addEventListener("message".toJS, handleMessage.toJS);
    window.parent?.postMessage("loaded".toJS, "*".toJS);
  }

  void handleMessage(JSAny event) {
    final messageEvent = event as JSMessageEvent;
    setState(() {
      current = messageEvent.data.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      current,
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }
}
