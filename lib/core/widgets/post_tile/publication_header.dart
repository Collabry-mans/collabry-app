import 'package:collabry/core/widgets/post_tile/publication_menu.dart';
import 'package:collabry/core/widgets/post_tile/post_tile.dart';
import 'package:flutter/material.dart';
import 'package:collabry/core/utils/app_text_styles.dart';
import 'package:collabry/core/widgets/profile_image.dart';
import 'package:collabry/features/home_page/data/models/publication_model.dart';
import 'publication_created_date.dart';

class PublicationHeader extends StatelessWidget {
  const PublicationHeader({
    super.key,
    required this.publication,
    required this.type,
  });

  final Publication publication;
  final PostTileType type;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ProfileImage(image: publication.authorAvatar ?? ''),
      title: Text(
        publication.authorName,
        style: AppTextStyles.belanosimaSize16Purple,
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _getSubtitleText(),
            style: AppTextStyles.belanosimaSize14Grey,
          ),
          PublicationCreatedDate(createdAt: publication.createdAt),
        ],
      ),
      trailing: PublicationMenu(
        publication: publication,
        type: type,
      ),
    );
  }

  String _getSubtitleText() {
    return type == PostTileType.detailedFromHomePage ||
            type == PostTileType.detailedFromUserProfile
        ? publication.authorEmail!
        : publication.categoryName;
  }
}
