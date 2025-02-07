import 'package:flutter/material.dart';
import 'package:flutter_local_data_base_drift/animation/layout/models/models.dart';

/// Search Bar
class SearchBar extends StatelessWidget {
  /// Default constructor
  const SearchBar({
    required this.currentUser,
    super.key,
  });

  /// Current User
  final User currentUser;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.white,
        ),
        padding: const EdgeInsets.fromLTRB(31, 12, 12, 12),
        child: Row(
          children: [
            const Icon(Icons.search),
            const SizedBox(width: 23.5),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  isDense: true,
                  border: InputBorder.none,
                  hintText: 'Search replies',
                  hintStyle: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ),
            CircleAvatar(
              backgroundImage: AssetImage(currentUser.avatarUrl),
            ),
          ],
        ),
      ),
    );
  }
}
