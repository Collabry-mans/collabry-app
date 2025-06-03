import 'package:collabry/core/utils/app_colors.dart';
import 'package:collabry/core/utils/app_text_styles.dart';
import 'package:collabry/core/widgets/profile_image.dart';
import 'package:collabry/features/home_page/presentation/widgets/create_publication/create_publication_appbar.dart';
import 'package:collabry/features/home_page/presentation/widgets/create_publication/create_publication_content.dart';
import 'package:collabry/features/home_page/presentation/widgets/create_publication/create_publication_sections.dart';
import 'package:collabry/features/home_page/presentation/widgets/create_publication/publication_settings.dart';
import 'package:flutter/material.dart';

class CreatePublicationView extends StatefulWidget {
  const CreatePublicationView({super.key});

  @override
  State<CreatePublicationView> createState() => _CreatePublicationViewState();
}

class _CreatePublicationViewState extends State<CreatePublicationView> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.homeBgColor,
        appBar: CreatePublicationAppBar(),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16.0),
            margin: EdgeInsets.only(top: 10),
            color: AppColors.whiteColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UserInfo(image: '', userName: 'ZASH'),
                SizedBox(height: 32.0),
                CreatePublicationContent(),
                SizedBox(height: 32.0),
                PublicationSettings(),
                SizedBox(height: 32.0),
                CreatePublicationSections(),
                SizedBox(height: 32.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class UserInfo extends StatelessWidget {
  const UserInfo({super.key, required this.image, required this.userName});
  final String image, userName;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ProfileImage(image: image),
        SizedBox(width: 16),
        Text(
          userName,
          style: AppTextStyles.belanosimaSize12Black.copyWith(fontSize: 24),
        ),
      ],
    );
  }
}
