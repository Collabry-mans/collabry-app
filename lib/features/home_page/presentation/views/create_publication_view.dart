import 'package:collabry/core/functions/extensions/theme_extension.dart';
import 'package:collabry/core/services/navigation_service.dart';
import 'package:collabry/core/utils/app_constants.dart';
import 'package:collabry/core/utils/app_text_styles.dart';
import 'package:collabry/core/utils/flush_bar_utils.dart';
import 'package:collabry/core/widgets/profile_image.dart';
import 'package:collabry/features/home_page/presentation/manager/category/category_cubit.dart';
import 'package:collabry/features/home_page/presentation/manager/category/category_state.dart';
import 'package:collabry/features/home_page/presentation/manager/publication/publication_cubit.dart';
import 'package:collabry/features/home_page/presentation/widgets/create_publication/create_publication_appbar.dart';
import 'package:collabry/features/home_page/presentation/widgets/create_publication/create_publication_content.dart';
import 'package:collabry/features/home_page/presentation/widgets/create_publication/create_publication_sections.dart';
import 'package:collabry/features/home_page/presentation/widgets/create_publication/publication_settings.dart';
import 'package:collabry/features/profile/presentation/manager/user_profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreatePublicationView extends StatefulWidget {
  const CreatePublicationView({super.key});

  @override
  State<CreatePublicationView> createState() => _CreatePublicationViewState();
}

class _CreatePublicationViewState extends State<CreatePublicationView> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _abstractController = TextEditingController();
  String? _privacy;
  String? _selectedCategoryId;
  List<String> _keywords = [];
  List<Map<String, TextEditingController>> sections = [
    {
      kTitle: TextEditingController(),
      kContent: TextEditingController(),
    },
  ];
  String? _status;

  @override
  void initState() {
    context.read<CategoryCubit>().getAllCategories();
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _abstractController.dispose();
    super.dispose();
  }

  void _publish() {
    if (_titleController.text.isEmpty || _abstractController.text.isEmpty) {
      FlushBarUtils.flushBarMsg('Please fill in all required fields', context);
      return;
    }
    context.read<PublicationCubit>().createPublication(
          title: _titleController.text,
          description: _abstractController.text,
          keywords: _keywords,
          language: 'en',
          visibility: _privacy!.toUpperCase(),
          categoryId: _selectedCategoryId!,
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PublicationCubit, PublicationState>(
      listener: (context, state) {
        if (state is PublicationCreationLoadedState) {
          FlushBarUtils.flushBarSuccess(
              'Publication is created, successfully', context);
          Future.delayed(
              Duration(seconds: 5), () => NavigationService.goBack());
        } else if (state is PublicationCreationFailedState) {
          FlushBarUtils.flushBarError(
              'Publication Creation is Failed: ${state.errModel.message}',
              context);
        }
      },
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          appBar: CreatePublicationAppBar(onPublish: _publish),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              margin: const EdgeInsets.only(top: 10),
              color: context.customColors.bottomNavBarColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  UserInfo(),
                  const SizedBox(height: 32.0),
                  CreatePublicationContent(
                    titleController: _titleController,
                    abstractController: _abstractController,
                  ),
                  const SizedBox(height: 32.0),
                  BlocBuilder<CategoryCubit, CategoryState>(
                    builder: (context, state) {
                      if (state is CategoriesLoadedState) {
                        if (_selectedCategoryId == null &&
                            state.categoriesList.isNotEmpty) {
                          _selectedCategoryId = state.categoriesList[0].id;
                        }
                        return PublicationSettings(
                          categories: state.categoriesList,
                          onPrivacyChanged: (value) =>
                              setState(() => _privacy = value),
                          onStatusChanged: (value) {
                            setState(() => _status = value);
                          },
                          onCategoryChanged: (value) =>
                              setState(() => _selectedCategoryId = value),
                          onKeywordsChanged: (keywords) =>
                              setState(() => _keywords = keywords),
                        );
                      } else if (state is CategoriesFailedState) {
                        context.read<CategoryCubit>().getAllCategories();
                        setState(() {});
                      }
                      return Center(child: const CircularProgressIndicator());
                    },
                  ),
                  const SizedBox(height: 32.0),
                  CreatePublicationSections(sections: sections)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class UserInfo extends StatelessWidget {
  const UserInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserProfileCubit, UserProfileState>(
      builder: (_, state) {
        if (state is UserProfileLoadedState) {
          final user = state.user;
          return ListTile(
            leading: ProfileImage(image: user.profile.profileImage),
            title: Text(
              user.name,
              style: AppTextStyles.belanosimaSize14.copyWith(fontSize: 18),
            ),
            subtitle: Text(user.email, style: AppTextStyles.belanosimaSize14),
          );
        } else if (state is UserProfileFailedState) {
          return ListTile(
            leading: ProfileImage(image: ''),
            title: Text(
              state.errModel.message,
              style: AppTextStyles.belanosimaSize14.copyWith(fontSize: 18),
            ),
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
