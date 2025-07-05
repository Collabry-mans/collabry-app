import 'package:collabry/core/functions/extensions/theme_extension.dart';
import 'package:collabry/core/utils/app_strings.dart';
import 'package:collabry/core/widgets/post_tile/post_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:collabry/core/utils/app_constants.dart';
import 'package:collabry/core/utils/app_text_styles.dart';
import 'package:collabry/features/home_page/presentation/manager/publication/publication_cubit.dart';

class SeeMoreButton extends StatelessWidget {
  const SeeMoreButton({
    super.key,
    required this.publicationId,
    required this.type,
  });

  final String publicationId;
  final PostTileType type;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _navigateToDetailed(context),
      child: Text(
        AppStrings.seeMore,
        style: AppTextStyles.barlowSize14W600Grey.copyWith(
          color: context.customColors.purpleTextColor,
        ),
      ),
    );
  }

  void _navigateToDetailed(BuildContext context) {
    PostTileType detailedType;
    switch (type) {
      case PostTileType.homePage:
        detailedType = PostTileType.detailedFromHomePage;
        break;
      case PostTileType.userProfile:
        detailedType = PostTileType.detailedFromUserProfile;
        break;
      default:
        detailedType = PostTileType.detailedFromHomePage;
    }

    Navigator.pushNamed(
      context,
      Routes.publicationByIdScreen,
      arguments: {
        'cubit': context.read<PublicationCubit>(),
        'publicationId': publicationId,
        'type': detailedType,
      },
    );
  }
}
