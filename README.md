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

## 🌤 Update
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

## 🚀 Usage
- If you don't define a `KeyboardTypingController`, The `KeyboardTyping` Widget plays automatically.


#### Create KeyboardTyping Widget ⌨

| parameter         | required            | type                       | default                     |
|-------------------|---------------------|----------------------------|-----------------------------|
| text              | :heavy_check_mark:  | Text                       |                             |
| controller        | :x:                 | KeyboardTypingController?  |                             |
| previewTextColor  | :x:                 | Color?                     |                             |
| mode              | :x:                 | KeyboardTypingMode         | KeyboardTypingMode.normal   |
| duration          | :x:                 | Duration?                  | Duration(milliseconds: 150) |

```dart
  KeyboardTyping(
    text: Text("Something Text"),
  )
```

<hr/>

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
