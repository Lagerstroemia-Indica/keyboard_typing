import 'package:flutter/material.dart';
import 'package:keyboard_typing/keyboard_typing.dart';
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
  final KeyboardTypingController controllerRepeat = KeyboardTypingController();
  late String state;
  late String stateRepeat;

  @override
  void initState() {
    super.initState();
    state = controller.state.name.toUpperCase();
    stateRepeat = controllerRepeat.state.name.toUpperCase();

    controller.addStateEventListener((state) {
      Log.i("StateEventListener.. state:$state");
      setState(() {
        this.state = state.name.toUpperCase();
      });
    },);

    controllerRepeat.addStateEventListener((state) {
      Log.x("StateEventListener.. stateRepeat:$state");
      setState(() {
        stateRepeat = state.name.toUpperCase();
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
              text: Text("Only TextWidget, Not define KeyboardTypingController :)"),
            ),
            const SizedBox(height: 18.0,),
            KeyboardTyping(
              text: Text(
                  'You have pressed the Start Button and Typing action! '
                  'also pressed the Stop Button and stop Typing action!',
                style: TextStyle(
                  color: Colors.green[900],
                  fontSize: 24.0
                ),
              ),
              controller: controller,
              duration: const Duration(milliseconds: 50),
            ),
            const SizedBox(height: 18.0,),
            Text(state,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 24.0,),
            KeyboardTyping(
              text: Text("You have pressed the Repeat Button and Typing action!",
                style: TextStyle(
                  fontSize: 21.0,
                  color: Colors.blue[900],
                ),
              ),
              controller: controllerRepeat,
              mode: KeyboardTypingMode.repeat,
            ),
            const SizedBox(height: 18.0,),
            Text(stateRepeat,
              style: Theme.of(context).textTheme.headlineMedium,
            )
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            key: null,
            onPressed: () {
              setState(() {
                controller.play();
                controllerRepeat.play();
              });
            },
            child: const Text("Play"),
          ),
          const SizedBox(height: 16.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                key: null,
                onPressed: () {
                  setState(() {
                    controller.stop();
                    controllerRepeat.stop();
                  });
                },
                child: const Text("Stop"),
              ),
              const SizedBox(width: 16.0,),
              FloatingActionButton(
                key: null,
                onPressed: () {
                  setState(() {
                    controller.stop(cancel: true);
                    controllerRepeat.stop(cancel: true);
                  });
                },
                child: const Text("Forced\nStop",
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
