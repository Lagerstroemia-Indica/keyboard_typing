# KeyboardTyping Widget
[![Pub Version](https://img.shields.io/pub/v/keyboard_typing?color=blue)](https://pub.dev/packages/keyboard_typing)

<img src="https://github.com/user-attachments/assets/687af0c6-bf6c-4b6c-a63e-330f8c4d9a70" width="320">

<br/>
<br/>

## Getting Started

This project is a starting point for a Flutter
[plug-in package](https://flutter.dev/developing-packages/keyboard_typing),
a specialized package that includes platform-specific implementation code for all.

For help getting started with Flutter development, view the
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

#### Add
```text
flutter pub add keyboard_typing
```

#### Import
```dart
import 'package:keyboard_typing/keyboard_typing.dart';
```

<br/>
<br/>

## 🚀 Usage
- If you don't define a `KeyboardTypingController`, The `KeyboardTyping` Widget plays automatically.


#### Create KeyboardTyping Widget ⌨

| parameter       | required            | type                       | default                     |
|-----------------|---------------------|----------------------------|-----------------------------|
| text            | :heavy_check_mark:  | Text                       |                             |
| controller      | :x:                 | KeyboardTypingController?  |                             |
| duration        | :x:                 | Duration?                  | Duration(milliseconds: 150) |

```dart
  KeyboardTyping(
    text: Text("Something Text"),
  )
```
<br/>

#### Play Typing Animation 🚩

```dart
  KeyboardTypingController controller = KeyboardTypingController();
  
  controller.play();
```

<br/>

#### Stop Typing Animation 🚧

```dart
  KeyboardTypingController controller = KeyboardTypingController();
  
  controller.stop();
```

<br/>

#### Listen Typing event state  🎈

```dart
  controller.addStateEventListener((KeyboardTypingState state) {
    setState(() {
      switch (state) {
        case KeyboardTypingState.idle:
          // TODO: Handle this case.
        case KeyboardTypingState.active:
          // TODO: Handle this case.
        case KeyboardTypingState.pause:
          // TODO: Handle this case.
        case KeyboardTypingState.stop:
          // TODO: Handle this case.
        case KeyboardTypingState.complete:
          // TODO: Handle this case.
      }
    });
  },);

  // remove
  // controller.removeStateEventListener(...);
```

<br/>
