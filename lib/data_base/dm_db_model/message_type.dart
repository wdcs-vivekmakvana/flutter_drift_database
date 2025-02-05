/// Enum for messages type
enum MessagesType {
  /// Image
  image,

  /// Audio
  audio
}

/// Enum for message type
extension MessagesTypeX on MessagesType {
  /// get message from message type
  String get messageFromType {
    return toString();
  }
}
