import '/src/typing_state.dart';

abstract class TypingProtocol {
  // void play({bool begin, bool repeat});  next version
  void play();
  void stop();
  void addStateEventListener(Function(KeyboardTypingState state) eventListener);
  void removeStateEventListener(
      Function(KeyboardTypingState state) eventListener);
  KeyboardTypingState get state;
}
