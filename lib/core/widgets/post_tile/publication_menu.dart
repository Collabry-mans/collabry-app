import 'package:collabry/core/utils/app_colors.dart';
import 'package:collabry/core/utils/flush_bar_utils.dart';
import 'package:collabry/core/widgets/post_tile/post_tile.dart';
import 'package:collabry/features/home_page/presentation/manager/publication/publication_cubit.dart';
import 'package:collabry/features/profile/data/model/publication_status.dart';
import 'package:flutter/material.dart';
import 'package:collabry/features/home_page/data/models/publication_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return BlocConsumer<PublicationCubit, PublicationState>(
      listener: (context, state) {
        if (state is UserPublicationStateSuccess) {
          FlushBarUtils.flushBarSuccess(
              'Publication is published, successfuly', context);
          context.read<PublicationCubit>().getAllUserPublications();
        } else if (state is UserPublicationStateFailed) {
          FlushBarUtils.flushBarError(
              'Failed to change publication status', context);
        } else if (state is UserPublicationStateLoading) {
          FlushBarUtils.flushBarMsg('Changing publication status...', context);
        }
      },
      builder: (context, state) {
        return PopupMenuButton<String>(
          color: AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          onSelected: (value) =>
              _handleMenuAction(context, value, publication: publication),
          itemBuilder: (context) => _buildMenuItems(),
          icon: const Icon(Icons.more_vert),
        );
      },
    );
  }

  List<PopupMenuEntry<String>> _buildMenuItems() {
    final items = <PopupMenuEntry<String>>[];

    if (_shouldShowUserOptions()) {
      items.addAll([
        if (type == PostTileType.draftedPost)
          {const PopupMenuItem(value: 'publish', child: Text('Publish'))}
              .single,
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
    return type == PostTileType.userProfile ||
        type == PostTileType.detailedFromUserProfile ||
        type == PostTileType.draftedPost;
  }

  void _handleMenuAction(BuildContext context, String action,
      {required Publication publication}) {
    switch (action) {
      case 'publish':
        _handlePublish(context, publicationId: publication.publicationId);
        break;
      case 'edit':
        _handleEdit(context);
        break;
      case 'delete':
        _handleDelete(context);
        break;
    }
  }

  void _handlePublish(BuildContext context, {required String publicationId}) {
    context.read<PublicationCubit>().changePublicationStatus(
        publicationId, PublicationStatus.published.value);
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
