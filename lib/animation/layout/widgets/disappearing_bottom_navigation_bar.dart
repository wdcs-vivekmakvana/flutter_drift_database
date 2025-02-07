import 'package:flutter/material.dart';
import 'package:flutter_local_data_base_drift/animation/layout/bottom_bar_transition.dart';
import 'package:flutter_local_data_base_drift/animation/layout/layout_animations.dart';
import 'package:flutter_local_data_base_drift/animation/layout/models/layout_destinations.dart';

/// Disappearing Bottom Navigation Bar
class DisappearingBottomNavigationBar extends StatelessWidget {
  /// Default constructor
  const DisappearingBottomNavigationBar({
    required this.selectedIndex,
    required this.barAnimation,
    super.key,
    this.onDestinationSelected,
  });

  /// Selected Index
  final int selectedIndex;

  /// onDestinationSelected
  final ValueChanged<int>? onDestinationSelected;

  /// Bottom Navigation Bar Animation
  final BarAnimation barAnimation;

  @override
  Widget build(BuildContext context) {
    return BottomBarTransition(
      animation: barAnimation,
      backgroundColor: Colors.white,
      child: NavigationBar(
        elevation: 0,
        backgroundColor: Colors.white,
        destinations: layoutDestinations.map<NavigationDestination>((d) {
          return NavigationDestination(
            icon: Icon(d.icon),
            label: d.label,
          );
        }).toList(),
        selectedIndex: selectedIndex,
        onDestinationSelected: onDestinationSelected,
      ),
    );
  }
}
