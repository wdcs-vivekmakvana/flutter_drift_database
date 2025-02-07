import 'package:flutter/material.dart';
import 'package:flutter_local_data_base_drift/animation/layout/models/model_data.dart';
import 'package:flutter_local_data_base_drift/animation/layout/widgets/email_widget.dart';

/// Reply List View
class ReplyListView extends StatelessWidget {
  /// Default constructor
  const ReplyListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ListView(
        children: [
          const SizedBox(height: 8),
          ...List.generate(replies.length, (index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: EmailWidget(
                email: replies[index],
                isPreview: false,
                isThreaded: true,
                showHeadline: index == 0,
              ),
            );
          }),
        ],
      ),
    );
  }
}
