/// Attachment Model
class Attachment {
  /// Default constructor
  const Attachment({
    required this.url,
  });

  /// URL of the attachment
  final String url;
}

/// Email Model
class Email {
  /// Default constructor
  const Email({
    required this.sender,
    required this.recipients,
    required this.subject,
    required this.content,
    this.replies = 0,
    this.attachments = const [],
  });

  /// Sender
  final User sender;

  /// Recipients
  final List<User> recipients;

  /// Subject
  final String subject;

  /// Content of the email
  final String content;

  /// Attachments
  final List<Attachment> attachments;

  /// Number of replies
  final double replies;
}

/// Name Model
class Name {
  /// Default constructor
  const Name({
    required this.first,
    required this.last,
  });

  /// First name
  final String first;

  /// Last name
  final String last;

  /// Full name of the user
  String get fullName => '$first $last';
}

/// User Model
class User {
  /// Default constructor
  const User({
    required this.name,
    required this.avatarUrl,
    required this.lastActive,
  });

  /// User's name
  final Name name;

  /// User's avatar URL'
  final String avatarUrl;

  /// User's last active date
  final DateTime lastActive;
}
