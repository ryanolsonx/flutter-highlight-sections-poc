import 'dart:html' as html;
import 'package:flutter/material.dart';

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
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

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
    html.window.addEventListener("message", handleMessage);
    html.window.parent?.postMessage("loaded", "*");
    super.initState();
  }

  void handleMessage(html.Event event) {
    var data = (event as html.MessageEvent).data;
    setState(() {
      current = data;
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
