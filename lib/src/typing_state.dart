import '/src/typing_widget.dart';

/// You can know Current TypingWidget state.
///
/// To [TypingStateProvider]
enum KeyboardTypingState {
  idle,
  active,
  pause,
  stop,
  complete,
}
