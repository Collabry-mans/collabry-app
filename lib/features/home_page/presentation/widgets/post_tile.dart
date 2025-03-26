import 'package:collabry/core/utils/app_assets.dart';
import 'package:collabry/core/utils/app_colors.dart';
import 'package:collabry/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PostTile extends StatelessWidget {
  const PostTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
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
      ),
      margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
      padding: const EdgeInsets.fromLTRB(15, 0, 10, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ListTile(
                  leading: Image.asset(Assets.imagesProfileAvatar),
                  title: const Text('Zash',
                      style: AppTextStyles.belanosimaSize16Purple),
                  subtitle: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('FCIS || FLutter',
                          style: AppTextStyles.belanosimaSize14Grey),
                      Row(
                        children: [
                          Text('2w . ',
                              style: AppTextStyles.belanosimaSize14Grey),
                          Icon(
                            Icons.public_outlined,
                            size: 16,
                            color: AppColors.txtColor,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const Icon(Icons.more_horiz_outlined)
            ],
          ),
          Row(
            children: [
              Text(
                'Contributors: ',
                style: AppTextStyles.belanosimaSize14Grey
                    .copyWith(color: AppColors.headerColor),
              ),
              Stack(
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
              ),
            ],
          ),
          Text(
            'Node.js: The Future of Modern Back-End Development',
            style: AppTextStyles.belanosimaSize14Grey
                .copyWith(color: Colors.black),
          ),
          Wrap(
            children: [
              const Text(
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
                'Node.js is one of the most popular technologies in back-end development, offering high performance and asynchronous request handling. This article explores the features of Node.js, best practices for using it, and the latest trends in modern application development',
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
          const SizedBox(height: 10),
          const Row(
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
          ),
          SizedBox(
            width: MediaQuery.sizeOf(context).width,
            child: const Divider(
              height: 1,
              thickness: 1,
            ),
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  const Icon(FontAwesomeIcons.heart),
                  Text(
                    'Like',
                    style: AppTextStyles.belanosimaSize14Grey
                        .copyWith(fontSize: 10),
                  )
                ],
              ),
              Column(
                children: [
                  const Icon(FontAwesomeIcons.comment),
                  Text(
                    'Comment',
                    style: AppTextStyles.belanosimaSize14Grey
                        .copyWith(fontSize: 10),
                  )
                ],
              ),
              Column(
                children: [
                  const Icon(FontAwesomeIcons.peopleGroup),
                  Text(
                    'Collaboration',
                    style: AppTextStyles.belanosimaSize14Grey
                        .copyWith(fontSize: 10),
                  )
                ],
              ),
              Column(
                children: [
                  const Icon(FontAwesomeIcons.share),
                  Text(
                    'Send',
                    style: AppTextStyles.belanosimaSize14Grey
                        .copyWith(fontSize: 10),
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
