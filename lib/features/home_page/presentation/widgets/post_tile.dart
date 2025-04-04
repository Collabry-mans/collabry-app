import 'package:collabry/core/utils/app_assets.dart';
import 'package:collabry/core/utils/app_colors.dart';
import 'package:collabry/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PostTile extends StatelessWidget {
  const PostTile(
      {super.key,
      required this.authorName,
      required this.description,
      required this.categoryName,
      required this.createDate,
      required this.title});
  final String authorName, description, categoryName, createDate, title;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _publicationDecoration(),
      margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
      padding: const EdgeInsets.fromLTRB(15, 0, 10, 10),
      child: _publicationBuilder(context),
    );
  }

  Widget _publicationBuilder(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _publicationHeader(),
        _publicationContributers(),
        _publicationContent(),
        const SizedBox(height: 10),
        _publicationReach(),
        SizedBox(
          width: MediaQuery.sizeOf(context).width,
          child: const Divider(height: 1, thickness: 1),
        ),
        const SizedBox(height: 5),
        _publicationOptions(),
      ],
    );
  }

  Widget _publicationHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: _publicationInfo(),
        ),
        const Icon(Icons.more_horiz_outlined)
      ],
    );
  }

  Widget _publicationInfo() {
    return ListTile(
      leading: Image.asset(Assets.imagesProfileAvatar),
      title: Text(authorName, style: AppTextStyles.belanosimaSize16Purple),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(categoryName, style: AppTextStyles.belanosimaSize14Grey),
          _publicationCreatedDate(),
        ],
      ),
    );
  }

  Widget _publicationCreatedDate() {
    return Row(
      children: [
        Text('$createDate . ', style: AppTextStyles.belanosimaSize14Grey),
        const Icon(
          Icons.public_outlined,
          size: 16,
          color: AppColors.txtColor,
        ),
      ],
    );
  }

  Widget _publicationContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style:
              AppTextStyles.belanosimaSize14Grey.copyWith(color: Colors.black),
        ),
        Wrap(
          children: [
            Text(
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              description,
              style: AppTextStyles.barlowSize14W600Grey,
            ),
            GestureDetector(
              child: const Text(
                'see more',
                style: AppTextStyles.belanosimaSize16Purple,
              ),
            )
          ],
        ),
      ],
    );
  }

  Widget _publicationContributers() {
    return Row(
      children: [
        Text(
          'Contributors: ',
          style: AppTextStyles.belanosimaSize14Grey
              .copyWith(color: AppColors.headerColor),
        ),
        _contributers(),
      ],
    );
  }

  Widget _contributers() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Image.asset(Assets.imagesProfileAvatar, height: 20),
        Positioned(
          left: 5,
          child: Image.asset(Assets.imagesProfileAvatar, height: 20),
        ),
        Positioned(
          left: 10,
          child: Image.asset(Assets.imagesProfileAvatar, height: 20),
        ),
        Positioned(
          left: 15,
          child: Image.asset(Assets.imagesProfileAvatar, height: 20),
        ),
      ],
    );
  }

  BoxDecoration _publicationDecoration() {
    return BoxDecoration(
      color: AppColors.whiteColor,
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          spreadRadius: 1,
          blurRadius: 5,
          offset: const Offset(0, 2),
        ),
      ],
    );
  }

  Widget _publicationReach() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '132 likes . 65 comments',
          style: AppTextStyles.belanosimaSize14Grey,
        ),
        Text(
          '35 Shares',
          style: AppTextStyles.belanosimaSize14Grey,
        )
      ],
    );
  }

  Widget _publicationOptions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _publicationOption(
            icon: const Icon(FontAwesomeIcons.heart), text: 'Like'),
        _publicationOption(
            icon: const Icon(FontAwesomeIcons.comment), text: 'Comment'),
        _publicationOption(
            icon: const Icon(FontAwesomeIcons.peopleGroup),
            text: 'Collaborators'),
        _publicationOption(
            icon: const Icon(FontAwesomeIcons.share), text: 'Send'),
      ],
    );
  }

  Widget _publicationOption({required Widget icon, required String text}) {
    return Column(
      children: [
        icon,
        Text(text,
            style: AppTextStyles.belanosimaSize14Grey.copyWith(fontSize: 10))
      ],
    );
  }
}
