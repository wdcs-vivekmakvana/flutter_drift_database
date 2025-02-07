import 'package:flutter/material.dart';
import 'package:flutter_local_data_base_drift/animation/layout/layout_animations.dart';
import 'package:flutter_local_data_base_drift/animation/layout/models/layout_destinations.dart';
import 'package:flutter_local_data_base_drift/animation/layout/nav_rail_transition.dart';
import 'package:flutter_local_data_base_drift/animation/layout/widgets/animated_floating_action_button.dart';

/// Disappearing Navigation Rail
class DisappearingNavigationRail extends StatelessWidget {
  /// Default constructor
  const DisappearingNavigationRail({
    required this.backgroundColor,
    required this.selectedIndex,
    required this.railAnimation,
    required this.railFabAnimation,
    super.key,
    this.onDestinationSelected,
  });

  /// Background color
  final Color backgroundColor;

  /// Selected index
  final int selectedIndex;

  /// Destinations
  final ValueChanged<int>? onDestinationSelected;

  /// Rail animation
  final RailAnimation railAnimation;

  /// Fab animation
  final RailFabAnimation railFabAnimation;

  @override
  Widget build(BuildContext context) {
    return NavRailTransition(
      animation: railAnimation,
      backgroundColor: backgroundColor,
      child: NavigationRail(
        selectedIndex: selectedIndex,
        backgroundColor: backgroundColor,
        onDestinationSelected: onDestinationSelected,
        leading: Column(
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.menu),
            ),
            const SizedBox(height: 8),
            AnimatedFloatingActionButton(
              animation: railFabAnimation,
              elevation: 0,
              onPressed: () {},
              child: const Icon(Icons.add),
            ),
          ],
        ),
        groupAlignment: -0.85,
        destinations: layoutDestinations.map((d) {
          return NavigationRailDestination(
            icon: Icon(d.icon),
            label: Text(d.label),
          );
        }).toList(),
      ),
    );
  }
}
