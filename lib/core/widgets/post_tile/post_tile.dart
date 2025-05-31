import 'package:collabry/core/widgets/post_tile/publication_content.dart';
import 'package:collabry/core/widgets/post_tile/publication_contributers.dart';
import 'package:collabry/core/widgets/post_tile/publication_header.dart';
import 'package:collabry/core/widgets/post_tile/publication_reach.dart';
import 'package:collabry/core/widgets/post_tile/publication_react.dart';
import 'package:flutter/material.dart';
import 'package:collabry/features/home_page/data/model/publication_model.dart';
import 'package:collabry/core/utils/app_colors.dart';

enum PostTileType {
  homePage,
  userProfile,
  detailedFromHomePage,
  detailedFromUserProfile,
}

class PostTile extends StatefulWidget {
  const PostTile({
    super.key,
    required this.publication,
    required this.type,
  });

  final Publication publication;
  final PostTileType type;

  @override
  State<PostTile> createState() => _PostTileState();
}

class _PostTileState extends State<PostTile> {
  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _buildDecoration(),
      margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
      padding: const EdgeInsets.fromLTRB(15, 0, 10, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PublicationHeader(
            publication: widget.publication,
            type: widget.type,
          ),
          if (widget.publication.collaborators != null)
            PublicationContributors(
              collaborators: widget.publication.collaborators!,
            ),
          PublicationContent(
            publication: widget.publication,
            type: widget.type,
          ),
          const SizedBox(height: 10),
          const PublicationReach(),
          SizedBox(
            width: MediaQuery.sizeOf(context).width,
            child: const Divider(height: 1, thickness: 1),
          ),
          const SizedBox(height: 5),
          PublicationReact(
            publication: widget.publication,
            type: widget.type,
            isLiked: isLiked,
            onLikeToggle: () => setState(() => isLiked = !isLiked),
          ),
        ],
      ),
    );
  }

  BoxDecoration _buildDecoration() {
    return BoxDecoration(
      color: AppColors.whiteColor,
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.2),
          spreadRadius: 1,
          blurRadius: 5,
          offset: const Offset(0, 2),
        ),
      ],
    );
  }
}
