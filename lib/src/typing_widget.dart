import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import '/src/typing_cursor.dart';
import '/src/cursor/cursor_style.dart';
import '/src/cursor/cursor_widget.dart';
import '/src/typing_const.dart';
import '/src/typing_mode.dart';
import '/src/typing_control_state.dart';
import '/src/typing_controller.dart';
import '/src/typing_state.dart';

class KeyboardTyping extends StatefulWidget {
  KeyboardTyping(
      {super.key,
      required this.text,
      this.controller,
      this.previewTextColor,
      this.mode = KeyboardTypingMode.normal,
      this.intervalDuration,
      CursorStyle? cursorStyle})
      : cursorStyle =
            cursorStyle ?? CursorStyle(mode: KeyboardTypingCursorMode.none);

  /// TextWidget.
  ///
  /// Define free !
  final Text text;

  /// If you want to control 'play', 'stop' so use this.
  ///
  /// and know state addStateEventListener [KeyboardTypingState].
  final KeyboardTypingController? controller;

  /// If you define [previewTextColor], you can see preview TextWidget.
  /// This will be help you to distinguish sentence more better.
  final Color? previewTextColor;

  /// KeyboardTypingMode default value [KeyboardTypingMode.normal]
  ///
  /// One shot played.
  ///
  /// -
  ///
  /// [KeyboardTypingMode.repeat] is re-write begin it.
  ///
  final KeyboardTypingMode mode;

  /// Default duration milliseconds: 150
  ///
  /// 0.0.6 ver Replace property name [duration] to [intervalDuration]
  final Duration? intervalDuration;

  /// Default [KeyboardTypingCursor.none]
  ///
  /// If you want cursor type horizontal shape [KeyboardTypingCursor.horizontal],
  /// If you want cursor type vertical shape [KeyboardTypingCursor.vertical]
  ///
  /// CursorColor.
  ///
  /// If you don't define color, you can see TextColor or DefaultTextColor
  final CursorStyle cursorStyle;

  @override
  State<KeyboardTyping> createState() => _TypingWidgetState();
}

class _TypingWidgetState extends State<KeyboardTyping>
    with SingleTickerProviderStateMixin {
  /// Manage KeyboardTypingState's state
  final TypingStateProvider provider = TypingStateProvider._();
  final Queue<String> messageQueue = Queue<String>();
  final StringBuffer message = StringBuffer();

  /// Recycle Timer instance
  Timer? messageTimer;
  KeyboardTypingController? typingController;
  late final Duration duration;

  /// Caclulate Text Layout size
  late final TextPainter painter;

  /// Cursor(Caret or Text Cursor) manage widget visibility
  bool isCursorVisible = true;

  @override
  void initState() {
    super.initState();
    if (widget.intervalDuration == null) {
      duration = const Duration(milliseconds: 150);
    } else {
      duration = widget.intervalDuration!;
    }

    if (widget.controller != null) {
      typingController = widget.controller;
      typingController!.setTypingEventListener(provider, typingEventListener);
    } else {
      messageQueue.addAll(widget.text.data!.split(""));
      messageTimer = Timer.periodic(duration, timerCallbackListener);
      // typingController = TypingController();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    painter = TextPainter(
      text: TextSpan(text: widget.text.data!, style: widget.text.style),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    );
    painter.layout();
  }

  @override
  void dispose() {
    message.clear();
    messageQueue.clear();

    messageTimer?.cancel();
    messageTimer = null;

    typingController?.stop();
    typingController = null;

    super.dispose();
  }

  /// Preserve user's Text Widget's data.
  @override
  Widget build(BuildContext context) {
    final DefaultTextStyle defaultTextStyle = DefaultTextStyle.of(context);

    return Stack(
      textDirection: widget.text.textDirection,
      children: [
        Opacity(
          opacity: widget.previewTextColor != null ? 1.0 : 0.0,
          // visible: widget.previewTextColor != null,
          child: Text(
            widget.text.data!,
            style: widget.text.style
                    ?.copyWith(color: widget.previewTextColor) ??
                defaultTextStyle.style.copyWith(color: widget.previewTextColor),
            maxLines: widget.text.maxLines,
            textAlign: widget.text.textAlign,
            textDirection: widget.text.textDirection,
            locale: widget.text.locale,
            overflow: widget.text.overflow ?? TextOverflow.clip,
            strutStyle: widget.text.strutStyle,
            softWrap: widget.text.softWrap ?? true,
            textHeightBehavior: widget.text.textHeightBehavior,
            textScaler: widget.text.textScaler ?? TextScaler.noScaling,
            textWidthBasis: widget.text.textWidthBasis ?? TextWidthBasis.parent,
            selectionColor: widget.text.selectionColor,
            semanticsLabel: widget.text.semanticsLabel,
          ),
        ),
        Text.rich(
          TextSpan(
              text: message.toString(),
              style: widget.text.style ?? defaultTextStyle.style,
              semanticsLabel: widget.text.semanticsLabel,
              children: [
                WidgetSpan(
                    child: Caret(
                  isVisible: isCursorVisible,
                  textSize: painter.size,
                  cursorColor: widget.cursorStyle.color ??
                      widget.text.style?.color ??
                      defaultTextStyle.style.color,
                  cursorMode: widget.cursorStyle.mode,
                  thickness: widget.cursorStyle.width,
                ))
              ]),
          maxLines: widget.text.maxLines ?? defaultTextStyle.maxLines,
          textAlign: widget.text.textAlign ?? TextAlign.start,
          textDirection: widget.text.textDirection,
          locale: widget.text.locale,
          overflow: widget.text.overflow ?? TextOverflow.clip,
          strutStyle: widget.text.strutStyle,
          softWrap: widget.text.softWrap ?? true,
          textHeightBehavior: widget.text.textHeightBehavior ??
              defaultTextStyle.textHeightBehavior,
          textScaler: widget.text.textScaler ?? TextScaler.noScaling,
          textWidthBasis:
              widget.text.textWidthBasis ?? defaultTextStyle.textWidthBasis,
          selectionColor: widget.text.selectionColor,
        ),
      ],
    );
  }

  /// Typing Animation's Flower.
  void timerCallbackListener(Timer timer) {
    // debugPrint("timerCallbackListener.. timer.tick:${timer.tick}");
    if (messageQueue.isNotEmpty) {
      setState(() {
        message.write(messageQueue.removeFirst());
      });
    } else {
      provider.state = KeyboardTypingState.complete;
      // Check rest about messageQueue
      // typingEventListener(state: TypingControlState.stop);
      timer.cancel();
      messageTimer = null;

      if (widget.mode == KeyboardTypingMode.repeat) {
        typingEventListener(
            bundle: {TypingConstant.controlState: TypingControlState.play});
      }
    }
  }

  /// Receive [KeyboardTypingState] value from [TypingController]
  void typingEventListener({
    required Map<String, dynamic> bundle,
  }) {
    // debugPrint("typingEventListener.. state:$state");
    TypingControlState state = bundle[TypingConstant.controlState];

    switch (state) {
      case TypingControlState.play:
        if (messageTimer == null) {
          if (provider.state == KeyboardTypingState.idle ||
              provider.state == KeyboardTypingState.stop ||
              provider.state == KeyboardTypingState.complete) {
            message.clear();
            messageQueue.clear();
            messageQueue.addAll(widget.text.data!.split(""));
          }
          messageTimer = Timer.periodic(duration, timerCallbackListener);
          provider.state = KeyboardTypingState.active;
        }
      case TypingControlState.stop:
        if (messageTimer != null) {
          messageTimer?.cancel();
          messageTimer = null;

          bool isForceStop = bundle[TypingConstant.stopForced] ?? false;

          if (isForceStop) {
            messageQueue.clear();
          }
          provider.state = messageQueue.isNotEmpty
              ? KeyboardTypingState.pause
              : KeyboardTypingState.stop;
        }
        break;
      case TypingControlState.cursor:
        setState(() {
          isCursorVisible = bundle[TypingConstant.cursorVisible];
        });
    }
  }
}

/// Do not use this.
///
/// This exist reason for [Typing] state.
class TypingStateProvider {
  TypingStateProvider._() : _state = KeyboardTypingState.idle;

  KeyboardTypingState _state;
  Function(KeyboardTypingState state)? _eventListener;

  KeyboardTypingState get state => _state;
  set state(KeyboardTypingState state) {
    _state = state;

    if (_eventListener != null) {
      _eventListener!(state);
    }
  }

  void addEventListener(Function(KeyboardTypingState state)? listener) {
    // debugPrint("addEventListener.. ");
    _eventListener = listener;
  }
}
