import 'package:collabry/core/widgets/post_tile/post_tile.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:collabry/core/utils/app_strings.dart';
import 'package:collabry/core/utils/app_text_styles.dart';
import 'package:collabry/features/home_page/data/model/publication_model.dart';

class PublicationReact extends StatelessWidget {
  const PublicationReact({
    super.key,
    required this.type,
    required this.isLiked,
    required this.onLikeToggle,
    required this.publication,
  });

  final PostTileType type;
  final bool isLiked;
  final VoidCallback onLikeToggle;
  final Publication publication;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        PublicationOption(
          icon: isLiked
              ? const Icon(Icons.favorite_outlined, color: Colors.red)
              : const Icon(Icons.favorite_outline, color: Colors.grey),
          text: AppStrings.like,
          onTap: onLikeToggle,
        ),
        PublicationOption(
          icon: const Icon(FontAwesomeIcons.comment),
          text: AppStrings.comment,
          onTap: () => _handleComment(context),
        ),
        PublicationOption(
          icon: const Icon(FontAwesomeIcons.peopleGroup),
          text: AppStrings.collaboration,
          onTap: () => _handleCollaboration(context),
        ),
        PublicationOption(
          icon: const Icon(FontAwesomeIcons.share),
          text: AppStrings.share,
          onTap: () => _handleShare(context),
        ),
      ],
    );
  }

  void _handleComment(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Comment functionality')),
    );
  }

  void _handleCollaboration(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Collaboration functionality')),
    );
  }

  void _handleShare(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Share functionality')),
    );
  }
}

class PublicationOption extends StatelessWidget {
  const PublicationOption({
    super.key,
    required this.icon,
    required this.text,
    this.onTap,
  });

  final Icon icon;
  final String text;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(onPressed: onTap, icon: icon),
        Text(
          text,
          style: AppTextStyles.belanosimaSize14Grey.copyWith(fontSize: 10),
        ),
      ],
    );
  }
}
