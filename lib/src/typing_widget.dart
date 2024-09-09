import 'dart:async';

import 'package:flutter/material.dart';

class Typing extends StatefulWidget {
  const Typing({
    super.key,
    required this.text
  });

  final Text text;

  @override
  State<Typing> createState() => _TypingWidgetState();
}

class _TypingWidgetState extends State<Typing> with SingleTickerProviderStateMixin {
  late final Timer timer;
  String message = "";
  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(const Duration(milliseconds: 100), timerCallbackListener);
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      message,
      style: widget.text.style,
      maxLines: widget.text.maxLines,
      textAlign: widget.text.textAlign,
      textDirection: widget.text.textDirection,
      locale: widget.text.locale,
      overflow: widget.text.overflow,
      strutStyle: widget.text.strutStyle,
      softWrap: widget.text.softWrap,
      textHeightBehavior: widget.text.textHeightBehavior,
      textScaler: widget.text.textScaler,
      textWidthBasis: widget.text.textWidthBasis,
      selectionColor: widget.text.selectionColor,
      semanticsLabel: widget.text.semanticsLabel,
    );
  }

  void timerCallbackListener(Timer timer) {
    debugPrint("timerCallbackListener.. timer.tick:${timer.tick}");
    setState(() {
      message = (widget.text.data!.substring(0, timer.tick));
    });
    if (timer.tick >= widget.text.data!.length) {
      debugPrint("timerCallbackListener.. timer cancel!");
      timer.cancel();
    }
  }
}
