import 'package:flutter/material.dart';
import 'package:flutter_local_data_base_drift/animation/layout/models/model_data.dart';
import 'package:flutter_local_data_base_drift/animation/layout/models/models.dart';
import 'package:flutter_local_data_base_drift/animation/layout/widgets/search_bar.dart' as search_bar;
import 'package:flutter_local_data_base_drift/animation/layout/widgets/email_widget.dart';

/// Email List View
class EmailListView extends StatelessWidget {
  /// Default constructor
  const EmailListView({
    required this.currentUser,
    super.key,
    this.selectedIndex,
    this.onSelected,
  });

  /// Selected Index
  final int? selectedIndex;

  /// On Selected Callback
  final ValueChanged<int>? onSelected;

  /// Current User
  final User currentUser;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: ListView(
        children: [
          const SizedBox(height: 8),
          search_bar.SearchBar(currentUser: currentUser),
          const SizedBox(height: 8),
          ...List.generate(
            emails.length,
            (index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: EmailWidget(
                  email: emails[index],
                  onSelected: onSelected != null
                      ? () {
                          onSelected!(index);
                        }
                      : null,
                  isSelected: selectedIndex == index,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
