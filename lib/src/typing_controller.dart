import '/src/typing_control_state.dart';
import '/src/typing_protocol.dart';
import '/src/typing_state.dart';
import '/src/typing_widget.dart';

class KeyboardTypingController extends TypingProtocol {
  TypingStateProvider? _state;
  late final Function({required TypingControlState state})
      _typingControlEventListener;
  Function(KeyboardTypingState state)? _typingStateEventListener;

  /// [_state] should not access in Private Typing Stateful Widget.
  ///
  /// It is only alternative FLAG
  ///
  /// Do not use this.
  void setTypingEventListener(TypingStateProvider state,
      Function({required TypingControlState state}) eventFunction) {
    _state = state..addEventListener(_typingStateEventListener);
    _typingControlEventListener = eventFunction;
  }

  /// Start Typing Animation. (like keyboard).
  ///
  @override
  void play() {
    assert(_state != null,
        "Put [TypingController] into [Typing] Widget's 'controller' parameter");

    if (_state != null) {
      _typingControlEventListener(
        state: TypingControlState.play,
      );
    }
  }

  @override
  void stop() {
    assert(_state != null,
        "Put [TypingController] into [Typing] Widget's 'controller' parameter");

    if (_state != null) {
      _typingControlEventListener(state: TypingControlState.stop);
    }
  }

  /// Know current [TypingState]'s state value.
  @override
  KeyboardTypingState get state =>
      _state != null ? _state!.state : KeyboardTypingState.idle;

  /// Event값을 전달해주는 역할
  @override
  void addStateEventListener(
      Function(KeyboardTypingState state) eventListener) {
    _typingStateEventListener = eventListener;
  }

  @override
  void removeStateEventListener(
      Function(KeyboardTypingState state) eventListener) {
    if (_typingStateEventListener == eventListener) {
      _typingStateEventListener = null;
    }
  }
}
