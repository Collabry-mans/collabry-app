import 'package:cached_network_image/cached_network_image.dart';
import 'package:collabry/core/cubit/publication/publication_cubit.dart';
import 'package:collabry/core/utils/app_assets.dart';
import 'package:collabry/core/utils/app_colors.dart';
import 'package:collabry/core/utils/app_constants.dart';
import 'package:collabry/core/utils/app_strings.dart';
import 'package:collabry/core/utils/app_text_styles.dart';
import 'package:collabry/core/widgets/profile_image.dart';
import 'package:collabry/features/home_page/data/model/publication_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PostTile extends StatefulWidget {
  const PostTile(
      {super.key, required this.publication, this.isDetailed = false});
  final Publication publication;
  final bool isDetailed;

  @override
  State<PostTile> createState() => _PostTileState();
}

class _PostTileState extends State<PostTile> {
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
        _publicationHeader(context),
        _publicationContributers(),
        _publicationContent(context),
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

  Widget _publicationHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: _publicationInfo(context)),
        const Icon(Icons.more_horiz_outlined)
      ],
    );
  }

//* publicationInfo
  Widget _publicationInfo(BuildContext context) {
    return ListTile(
      leading: ProfileImage(image: widget.publication.authorAvatar ?? ''),
      title: Text(widget.publication.authorName,
          style: AppTextStyles.belanosimaSize16Purple),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              widget.isDetailed
                  ? widget.publication.authorEmail!
                  : widget.publication.categoryName,
              style: AppTextStyles.belanosimaSize14Grey),
          _publicationCreatedDate(),
        ],
      ),
    );
  }

  Widget _publicationCreatedDate() {
    return Row(
      children: [
        Text('${widget.publication.createdAt.split('T').first} . ',
            style: AppTextStyles.belanosimaSize14Grey),
        const Icon(
          Icons.public_outlined,
          size: 16,
          color: AppColors.txtColor,
        )
      ],
    );
  }

  Widget _publicationContributers() {
    return Row(
      children: [
        Text(
          AppStrings.contributors,
          style: AppTextStyles.belanosimaSize14Grey
              .copyWith(color: AppColors.headerColor),
        ),
        _contributers(),
      ],
    );
  }

  Widget _contributers() {
    return widget.publication.collaborators.isEmpty
        ? const Text(
            ' No contributors yet ',
            style: AppTextStyles.belanosimaSize14Grey,
          )
        : Stack(
            clipBehavior: Clip.none,
            children: (widget.publication.collaborators
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
                .toList()),
          );
  }

  //* content
  Widget _publicationContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.publication.title,
          style: widget.isDetailed
              ? AppTextStyles.belanosimaSize24W600Purple
                  .copyWith(color: AppColors.blackColor)
              : AppTextStyles.belanosimaSize14Grey
                  .copyWith(color: AppColors.blackColor),
        ),
        Wrap(
          children: [
            Text(
              maxLines: widget.isDetailed ? null : 2,
              overflow: widget.isDetailed ? null : TextOverflow.ellipsis,
              widget.publication.description,
              style: AppTextStyles.barlowSize14W600Grey,
            ),
            const SizedBox(width: 5),
            widget.isDetailed
                ? Container()
                : GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        Routes.publicationByIdScreen,
                        arguments: {
                          'cubit': context.read<PublicationCubit>(),
                          'publicationId': widget.publication.publicationId,
                        },
                      );
                    },
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

//*
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
            icon: Icon(FontAwesomeIcons.heart,
                color: widget.publication.isLiked ? Colors.red : Colors.grey),
            text: AppStrings.like,
            onTap: () => setState(() =>
                widget.publication.isLiked = !widget.publication.isLiked)),
        _publicationOption(
            icon: const Icon(FontAwesomeIcons.comment),
            text: AppStrings.comment),
        _publicationOption(
            icon: const Icon(FontAwesomeIcons.peopleGroup),
            text: AppStrings.collaboration),
        _publicationOption(
            icon: const Icon(FontAwesomeIcons.share), text: AppStrings.search),
      ],
    );
  }

  Widget _publicationOption(
      {required Icon icon, required String text, void Function()? onTap}) {
    return Column(
      children: [
        IconButton(onPressed: onTap, icon: icon),
        Text(text,
            style: AppTextStyles.belanosimaSize14Grey.copyWith(fontSize: 10))
      ],
    );
  }
}
