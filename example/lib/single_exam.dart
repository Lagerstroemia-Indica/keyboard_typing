import 'package:flutter/material.dart';
import 'package:keyboard_typing/keyboard_typing.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      useMaterial3: true,
    ),
    home: SingleExam()
  ));
}

class SingleExam extends StatefulWidget {
  const SingleExam({super.key});

  @override
  State<SingleExam> createState() => _SingleExamState();
}

class _SingleExamState extends State<SingleExam> {
  final KeyboardTypingController controller = KeyboardTypingController();
  final KeyboardTypingController controllerPre = KeyboardTypingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            KeyboardTyping(
              text: Text("Single Typing Text",
                style: TextStyle(
                  fontSize: 24.0
                ),
              ),
              controller: controller,
              cursorStyle: CursorStyle(
                mode: KeyboardTypingCursorMode.vertical,
              ),
            ),
            KeyboardTyping(
              text: Text("Preview Typing Text",
                style: TextStyle(
                    fontSize: 24.0
                ),
              ),
              controller: controllerPre,
              previewTextColor: Colors.grey,
              cursorStyle: CursorStyle(
                mode: KeyboardTypingCursorMode.vertical,
                width: 10.0
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Table(
                border: TableBorder.all(color: Colors.black),

                children: [
                  TableRow(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          controller.play();
                          controllerPre.play();
                        },
                        child: Text("PLAY"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          controller.stop();
                          controllerPre.stop();
                        },
                        child: Text("STOP"),
                      ),
                    ]
                  ),
                  TableRow(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          controller.cursor(visible: false);
                          controllerPre.cursor(visible: false);
                        },
                        child: Text("CURSOR-HIDE", textAlign: TextAlign.center,),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          controller.cursor(visible: true);
                          controllerPre.cursor(visible: true);
                        },
                        child: Text("CURSOR-SHOW"),
                      ),
                    ]
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
