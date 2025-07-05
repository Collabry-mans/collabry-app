import 'package:collabry/core/utils/app_text_styles.dart';
import 'package:collabry/core/widgets/post_tile/see_more_button.dart';
import 'package:collabry/core/widgets/post_tile/post_tile.dart';
import 'package:flutter/material.dart';
import 'package:collabry/core/utils/app_colors.dart';
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
    final isAbstracted = !isDetailed && type != PostTileType.draftedPost;
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
          isAbstracted: isAbstracted,
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
              .copyWith(color: AppColors.black)
          : AppTextStyles.belanosimaSize16BlackBold,
    );
  }
}

class PublicationDescription extends StatelessWidget {
  const PublicationDescription({
    super.key,
    required this.description,
    required this.publicationId,
    required this.type,
    required this.isAbstracted,
  });

  final String description;
  final String publicationId;
  final PostTileType type;
  final bool isAbstracted;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Text(
            description,
            maxLines: isAbstracted ? 2 : null,
            overflow: isAbstracted ? TextOverflow.ellipsis : null,
            style: AppTextStyles.barlowSize14W600Grey,
          ),
        ),
        if (isAbstracted) ...[
          SeeMoreButton(
            publicationId: publicationId,
            type: type,
          )
        ]
      ],
    );
  }
}
