/// Current Typing State.
///
/// Distinguish Enum class.
///
/// [play] is [Typing] state do typing text.
///
/// [stop] is [Typing] state do not typing text
enum TypingControlState {
  /// [play] is [Typing] state do typing text.
  ///
  /// Maybe If text typing completed and call this.
  /// re-write Typing text.
  ///
  /// But, If text typing is not completed and can not call this.
  play,

  /// Anywhere, call [stop] state.
  /// Immediately stop Typing text.
  stop
}
