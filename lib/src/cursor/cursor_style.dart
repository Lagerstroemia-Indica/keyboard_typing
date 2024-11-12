import 'dart:ui';

import '/src/typing_cursor.dart';

class CursorStyle {
  /// [mode] was defined Cursor(Caret) shape.
  ///
  /// [color] was defined Cursor(Caret) color.
  ///
  /// [width] was defined Cursor(Caret) size(Thickness)
  CursorStyle({required this.mode, this.color, this.width = 1.0}) {
    assert(width >= 0.0,
        "KeyboardTyping package CursorStyle property Thickness(width) size min 0.0");
  }
  final KeyboardTypingCursorMode mode;
  final Color? color;
  final double width;
}
