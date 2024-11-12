import 'dart:async';

import 'package:flutter/material.dart';
import '../typing_cursor.dart';

/// KeyboardCursor(or Caret) Widget
///
/// If you don't want see [Caret]
/// Use Controller's [cursor] function.
/// It has [visible] parameter. You can measure it.
class Caret extends StatefulWidget {
  const Caret(
      {super.key,
      this.isVisible = true,
      required this.textSize,
      this.cursorColor,
      required this.cursorMode,
      required this.thickness});

  final bool isVisible;
  final Size textSize;
  final Color? cursorColor;
  final KeyboardTypingCursorMode cursorMode;
  final double thickness;

  @override
  State<Caret> createState() => _CaretState();
}

class _CaretState extends State<Caret> {
  /// Setting Cursor Size
  double width = 0.0;
  double height = 0.0;

  /// Cursor Timer
  Timer? cursorTimer;

  /// Widget visibility
  bool isVisible = true;

  /// Cursor control visible
  bool isCursorVisible = true;

  // setState시
  // 계속해서 호출되는지 확인이 필요하다
  @override
  void initState() {
    super.initState();

    switch (widget.cursorMode) {
      case KeyboardTypingCursorMode.none:
        isVisible = false;
        break;
      case KeyboardTypingCursorMode.vertical:
        width = widget.thickness;
        height = widget.textSize.height;
        break;
      case KeyboardTypingCursorMode.horizontal:
        width = widget.textSize.height / 2;
        height = widget.thickness;
        break;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(Caret oldWidget) {
    super.didUpdateWidget(oldWidget);
    isVisible = widget.isVisible;
    isCursorVisible = true;

    if (cursorTimer != null) {
      cursorTimer?.cancel();
      cursorTimer = null;
    }
    if (isVisible) {
      cursorTimer = Timer.periodic(
        const Duration(milliseconds: 750),
        (timer) {
          setState(() {
            isCursorVisible = !isCursorVisible;
          });
        },
      );
    }
  }

  @override
  void dispose() {
    // timer cancel
    cursorTimer?.cancel();
    cursorTimer = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isVisible,
      child: Opacity(
        opacity: isCursorVisible ? 1.0 : 0.0,
        child: Container(
          width: width,
          height: height,
          color: widget.cursorColor,
        ),
      ),
    );
  }
}
