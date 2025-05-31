import 'package:collabry/core/widgets/post_tile/post_tile.dart';
import 'package:flutter/material.dart';
import 'package:collabry/features/home_page/data/model/publication_model.dart';

class PublicationMenu extends StatelessWidget {
  const PublicationMenu({
    super.key,
    required this.publication,
    required this.type,
  });

  final Publication publication;
  final PostTileType type;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (value) => _handleMenuAction(context, value),
      itemBuilder: (context) => _buildMenuItems(),
      icon: const Icon(Icons.more_vert),
    );
  }

  List<PopupMenuEntry<String>> _buildMenuItems() {
    final items = <PopupMenuEntry<String>>[];

    // Common options for all types
    items.addAll([
      const PopupMenuItem(value: 'share', child: Text('Share')),
      const PopupMenuItem(value: 'report', child: Text('Report')),
    ]);

    // User-specific options based on type
    if (_shouldShowUserOptions()) {
      items.addAll([
        const PopupMenuDivider(),
        const PopupMenuItem(value: 'publish', child: Text('Publish')),
        const PopupMenuItem(value: 'edit', child: Text('Edit')),
        const PopupMenuItem(
          value: 'delete',
          child: Text('Delete', style: TextStyle(color: Colors.red)),
        ),
      ]);
    }

    return items;
  }

  bool _shouldShowUserOptions() {
    // Show user options for userProfile and detailedFromUserProfile
    return type == PostTileType.userProfile ||
        type == PostTileType.detailedFromUserProfile;
  }

  void _handleMenuAction(BuildContext context, String action) {
    switch (action) {
      case 'share':
        _handleShare(context);
        break;
      case 'report':
        _handleReport(context);
        break;
      case 'publish':
        _handlePublish(context);
        break;
      case 'edit':
        _handleEdit(context);
        break;
      case 'delete':
        _handleDelete(context);
        break;
    }
  }

  // Action handlers remain the same...
  void _handleShare(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Share functionality')),
    );
  }

  void _handleReport(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Report functionality')),
    );
  }

  void _handlePublish(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Publish functionality')),
    );
  }

  void _handleEdit(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Edit functionality')),
    );
  }

  void _handleDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Publication'),
        content:
            const Text('Are you sure you want to delete this publication?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Publication deleted')),
              );
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
