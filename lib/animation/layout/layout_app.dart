import 'package:flutter/material.dart';
import 'package:flutter_local_data_base_drift/animation/layout/email_list_view.dart';
import 'package:flutter_local_data_base_drift/animation/layout/layout_animations.dart';
import 'package:flutter_local_data_base_drift/animation/layout/models/models.dart';
import 'package:flutter_local_data_base_drift/animation/layout/transition/list_detail_transition.dart';
import 'package:flutter_local_data_base_drift/animation/layout/widgets/animated_floating_action_button.dart';
import 'package:flutter_local_data_base_drift/animation/layout/widgets/disappearing_bottom_navigation_bar.dart';
import 'package:flutter_local_data_base_drift/animation/layout/widgets/disappearing_navigation_rail.dart';
import 'package:flutter_local_data_base_drift/animation/layout/widgets/reply_list_view.dart';

/// Feed
class Feed extends StatefulWidget {
  /// Default constructor
  const Feed({
    required this.currentUser,
    super.key,
  });

  /// User associated with the feed
  final User currentUser;

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> with SingleTickerProviderStateMixin {
  late final _colorScheme = Theme.of(context).colorScheme;
  late final _backgroundColor = Color.alphaBlend(_colorScheme.primary.withValues(alpha: 0.14), _colorScheme.surface);
  int selectedIndex = 0;

  late final _controller = AnimationController(
    duration: const Duration(milliseconds: 1000),
    reverseDuration: const Duration(milliseconds: 1250),
    value: 0,
    vsync: this,
  );
  late final _railAnimation = RailAnimation(parent: _controller);
  late final _railFabAnimation = RailFabAnimation(parent: _controller);
  late final _barAnimation = BarAnimation(parent: _controller);
  bool controllerInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final width = MediaQuery.sizeOf(context).width;
    // Remove wideScreen reference
    // Add from here ...
    final status = _controller.status;
    if (width > 600) {
      if (status != AnimationStatus.forward && status != AnimationStatus.completed) {
        _controller.forward();
      }
    } else {
      if (status != AnimationStatus.reverse && status != AnimationStatus.dismissed) {
        _controller.reverse();
      }
    }
    if (!controllerInitialized) {
      controllerInitialized = true;
      _controller.value = width > 600 ? 1 : 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return Scaffold(
          body: Row(
            children: [
              DisappearingNavigationRail(
                railAnimation: _railAnimation,
                railFabAnimation: _railFabAnimation,
                selectedIndex: selectedIndex,
                backgroundColor: _backgroundColor,
                onDestinationSelected: (index) {
                  setState(() {
                    selectedIndex = index;
                  });
                },
              ),
              Expanded(
                child: ColoredBox(
                  color: _backgroundColor,
                  child: ListDetailTransition(
                    animation: _railAnimation,
                    one: EmailListView(
                      selectedIndex: selectedIndex,
                      onSelected: (index) {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      currentUser: widget.currentUser,
                    ),
                    two: const ReplyListView(),
                  ),
                ),
              ),
            ],
          ),
          floatingActionButton: AnimatedFloatingActionButton(
            animation: _barAnimation,
            onPressed: () {},
            child: const Icon(Icons.add),
          ),
          bottomNavigationBar: DisappearingBottomNavigationBar(
            barAnimation: _barAnimation,
            selectedIndex: selectedIndex,
            onDestinationSelected: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
          ),
        );
      },
    );
  }
}
