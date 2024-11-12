# KeyboardTyping Widget
[![Pub Version](https://img.shields.io/pub/v/keyboard_typing?color=blue)](https://pub.dev/packages/keyboard_typing)

<img src="https://github.com/user-attachments/assets/175be5ab-5877-4192-b5eb-ba1d91cdd56d" alt="GIF" width="320">

<br/>
<br/>

## 🌱 Getting Started

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

## 🌅 Update
- 0.0.7 version
- If you define `cursorStyle` parameter, you can see cursor(caret) beside TextWidget.

#### CursorStyle 📍
|  parameter    |  required           |  type                      |  default          |
|---------------|---------------------|----------------------------|-------------------|    
| mode          | :heavy_check_mark:  |  KeyboardTypingCursorMode  |  none             |
| color         | :x:                 |  Color?                    |                   |
| width         | :x:                 |  double                    |  1.0              |

```dart
KeyboardTyping(
  text: Text("KeyboardTyping Test Sentence"),
  controller: controller,
  cursorStyle: CursorStyle(
    mode: KeyboardTypingCursorMode.vertical
  )
)
```
<img src="https://github.com/user-attachments/assets/cbe45c22-0cbf-4cb1-9e69-ba57d86fad21" alt="GIF" width="380">


<br/>
<br/>


## 🚀 Usage
- If you don't define a `KeyboardTypingController`, The `KeyboardTyping` Widget plays automatically.


#### Create KeyboardTyping Widget ⌨

| parameter        | required            | type                       | default                                          |
|------------------|---------------------|----------------------------|--------------------------------------------------|
| text             | :heavy_check_mark:  | Text                       |                                                  |
| controller       | :x:                 | KeyboardTypingController?  |                                                  |
| previewTextColor | :x:                 | Color?                     |                                                  |
| mode             | :x:                 | KeyboardTypingMode         | KeyboardTypingMode.normal                        |
| intervalDuration | :x:                 | Duration?                  | Duration(milliseconds: 150)                      |
| cursorStyle      | :x:                 | CursorStyle?               | CursorStyle(mode: KeyboardTypingCursorMode.none) |

```dart
  KeyboardTyping(
    text: Text("Something Text"),
  )
```

<hr/>

#### Play Typing Animation 🚩

```dart
// AutoPlay
KeyboardTypingController controller = KeyboardTypingController();

@override
void initState() {
  controller
    ..addStateEventListener(keyboardStateEventListener)
    ..play();
}
```
```dart
// User control
@override
Widget build(BuildContext context) {
  ...
  ElevatedButton(
    onPressed: () {
      controller.play();
    }
  )
}
```

<br/>

#### Stop Typing Animation 🚧

- If you want clear text to define 'true' into cancel parameter in stop function.

```dart
KeyboardTypingController controller = KeyboardTypingController();

@override
Widget build(BuildContext context) {
  ...
  ElevatedButton(
    onPressed: () {
      // Normal stop
      controller.stop();

      // Forced stop
      controller.stop(cancel: true);    // Effect clear text and start at first.
    }
  )
}

```

<br/>

#### Repeat Typing Animation 🌀

<img src="https://github.com/user-attachments/assets/9d226eb0-f850-4590-9133-f1c6b7f2722b" alt="GIF" width="320">

```dart
  KeyboardTyping(
    text: Text("Something Text"),
    mode: KeyboardTypingMode.repeat,
  )
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

#### Preview Text 👥
- 0.0.6 version
- If you define `previewTextColor` paremeter, you can see preview TextWidget's data.
<!--![previewTextColor](https://github.com/user-attachments/assets/f1370304-1587-44ed-a166-fac7922879dc)-->
<img src="https://github.com/user-attachments/assets/f1370304-1587-44ed-a166-fac7922879dc" alt="GIF" width="420">

```dart
  KeyboardTyping(
    text: Text("If you define 'previewTextColor' parameter,\nThen you can see a preview TextWidget :)"),
    previewTextColor: Colors.grey.withOpacity(0.5),
  )
```

<br/>
