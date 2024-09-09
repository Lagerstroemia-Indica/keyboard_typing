import 'package:flutter/material.dart';
import 'package:typing/keyboard_typing.dart';
import 'package:flutter_logcat/flutter_logcat.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Typing Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Typing Demo Page'),
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
  final KeyboardTypingController controller = KeyboardTypingController();
  late String state;

  @override
  void initState() {
    super.initState();
    state = controller.state.name.toUpperCase();

    controller.addStateEventListener((state) {
      Log.i("StateEventListener.. state:$state");
      setState(() {
        this.state = state.name.toUpperCase();
      });
    },);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            KeyboardTyping(
              text: Text(
                  'You have pushed the Start button and Typing action! '
                  'also pushed the Stop button and stop Typing action!',
                style: TextStyle(
                  color: Colors.green[900],
                  fontSize: 24.0
                ),
              ),
              controller: controller,
              duration: const Duration(milliseconds: 50),
            ),
            const SizedBox(height: 21.0,),
            Text(state,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            key: null,
            onPressed: () {
              setState(() {
                controller.play();
              });
            },
            child: const Text("Start"),
          ),
          const SizedBox(height: 16.0,),
          FloatingActionButton(
            key: null,
            onPressed: () {
              setState(() {
                controller.stop();
              });
            },
            child: const Text("Stop"),
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
