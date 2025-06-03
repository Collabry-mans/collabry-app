import 'package:collabry/core/widgets/post_tile/see_more_button.dart';
import 'package:collabry/core/widgets/post_tile/post_tile.dart';
import 'package:flutter/material.dart';
import 'package:collabry/core/utils/app_colors.dart';
import 'package:collabry/core/utils/app_text_styles.dart';
import 'package:collabry/features/home_page/data/models/publication_model.dart';

class PublicationContent extends StatelessWidget {
  const PublicationContent({
    super.key,
    required this.publication,
    required this.type,
  });

  final Publication publication;
  final PostTileType type;

  @override
  Widget build(BuildContext context) {
    final isDetailed = type == PostTileType.detailedFromHomePage ||
        type == PostTileType.detailedFromUserProfile;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PublicationTitle(
          title: publication.title,
          isDetailed: isDetailed,
        ),
        PublicationDescription(
          description: publication.description,
          publicationId: publication.publicationId,
          isDetailed: isDetailed,
          type: type,
        ),
      ],
    );
  }
}

class PublicationTitle extends StatelessWidget {
  const PublicationTitle({
    super.key,
    required this.title,
    required this.isDetailed,
  });

  final String title;
  final bool isDetailed;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: isDetailed
          ? AppTextStyles.belanosimaSize24W600Purple
              .copyWith(color: AppColors.blackColor)
          : AppTextStyles.belanosimaSize14Grey
              .copyWith(color: AppColors.blackColor),
    );
  }
}

class PublicationDescription extends StatelessWidget {
  const PublicationDescription({
    super.key,
    required this.description,
    required this.publicationId,
    required this.type,
    required this.isDetailed,
  });

  final String description;
  final String publicationId;
  final PostTileType type;
  final bool isDetailed;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Text(
          description,
          maxLines: isDetailed ? null : 2,
          overflow: isDetailed ? null : TextOverflow.ellipsis,
          style: AppTextStyles.barlowSize14W600Grey,
        ),
        const SizedBox(width: 1),
        if (!isDetailed)
          SeeMoreButton(
            publicationId: publicationId,
            type: type,
          ),
      ],
    );
  }
}
