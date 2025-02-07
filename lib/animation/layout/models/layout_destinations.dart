import 'package:flutter/material.dart';

/// Layout destination
class LayoutDestination {
  /// Default constructor
  const LayoutDestination(this.icon, this.label);

  /// Icon
  final IconData icon;

  /// Label
  final String label;
}

/// Layout destinations
const List<LayoutDestination> layoutDestinations = <LayoutDestination>[
  LayoutDestination(Icons.inbox_rounded, 'Inbox'),
  LayoutDestination(Icons.article_outlined, 'Articles'),
  LayoutDestination(Icons.messenger_outline_rounded, 'Messages'),
  LayoutDestination(Icons.group_outlined, 'Groups'),
];
