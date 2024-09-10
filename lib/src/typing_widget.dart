import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:keyboard_typing/src/typing_const.dart';
import '/src/typing_mode.dart';
import '/src/typing_control_state.dart';
import '/src/typing_controller.dart';
import '/src/typing_state.dart';

class KeyboardTyping extends StatefulWidget {
  const KeyboardTyping({
    super.key,
    required this.text,
    this.controller,
    this.mode = KeyboardTypingMode.normal,
    this.duration,
  });

  /// TextWidget.
  ///
  /// Define free !
  final Text text;

  /// If you want to control 'play', 'stop' so use this.
  ///
  /// and know state addStateEventListener [KeyboardTypingState].
  final KeyboardTypingController? controller;

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
  final Duration? duration;

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

  @override
  void initState() {
    super.initState();
    if (widget.duration == null) {
      duration = const Duration(milliseconds: 150);
    } else {
      duration = widget.duration!;
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
    return Text(
      message.toString(),
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
