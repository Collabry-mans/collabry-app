import 'package:cached_network_image/cached_network_image.dart';
import 'package:collabry/core/utils/app_assets.dart';
import 'package:collabry/core/utils/app_colors.dart';
import 'package:collabry/core/utils/app_strings.dart';
import 'package:collabry/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

class PublicationContributors extends StatelessWidget {
  const PublicationContributors({
    super.key,
    this.collaborators,
  });

  final List<dynamic>? collaborators;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          AppStrings.contributors,
          style: AppTextStyles.belanosimaSize14
              .copyWith(color: AppColors.appHeader),
        ),
        ContributorsList(collaborators: collaborators ?? []),
      ],
    );
  }
}

class ContributorsList extends StatelessWidget {
  const ContributorsList({
    super.key,
    required this.collaborators,
  });

  final List<dynamic> collaborators;

  @override
  Widget build(BuildContext context) {
    if (collaborators.isEmpty) {
      return const Text(
        ' No contributors yet ',
        style: AppTextStyles.belanosimaSize14,
      );
    }

    return Stack(
      clipBehavior: Clip.none,
      children: collaborators
          .asMap()
          .map(
            (index, collaborator) => MapEntry(
              index,
              Positioned(
                left: index * 5,
                child: CachedNetworkImage(
                  height: 20,
                  imageUrl: collaborator.user.profileImageUrl,
                  errorWidget: (_, __, ___) =>
                      Image.asset(Assets.imagesProfileAvatar),
                ),
              ),
            ),
          )
          .values
          .toList(),
    );
  }
}
