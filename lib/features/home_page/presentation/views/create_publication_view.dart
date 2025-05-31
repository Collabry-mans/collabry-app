import 'package:collabry/core/services/navigation_service.dart';
import 'package:collabry/features/home_page/presentation/manager/category/category_cubit.dart';
import 'package:collabry/features/home_page/presentation/manager/category/category_state.dart';
import 'package:collabry/features/home_page/presentation/manager/publication/publication_cubit.dart';
import 'package:collabry/core/utils/app_colors.dart';
import 'package:collabry/core/utils/app_constants.dart';
import 'package:collabry/core/utils/app_text_styles.dart';
import 'package:collabry/core/utils/flush_bar_utils.dart';
import 'package:collabry/core/widgets/profile_image.dart';
import 'package:collabry/features/home_page/data/model/category_model.dart';
import 'package:collabry/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_speed_dial/flutter_speed_dial.dart'; // Make sure to add this package to pubspec.yaml

class CreatePublicationView extends StatefulWidget {
  const CreatePublicationView({super.key});

  @override
  State<CreatePublicationView> createState() => _CreatePublicationViewState();
}

class _CreatePublicationViewState extends State<CreatePublicationView> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController contentController;
  late final TextEditingController keyWordsController;
  late final TextEditingController titleController;

  String? _selectedVisibility;
  String? _selectedLanguage;
  CategoryModel? _selectedCategory;
  final List<String> _keywords = [];
  final List<String> _visibilityOptions = ['PRIVATE', 'PUBLIC'];
  final List<String> _languageOptions = ['en', 'ar'];

  @override
  void initState() {
    super.initState();
    context.read<CategoryCubit>().getAllCategories();
    _initializeControllers();
    _selectedVisibility = _visibilityOptions[1];
    _selectedLanguage = _languageOptions[0];
  }

  void _initializeControllers() {
    contentController = TextEditingController();
    keyWordsController = TextEditingController();
    titleController = TextEditingController();
  }

  @override
  void dispose() {
    _disposeControllers();
    super.dispose();
  }

  void _disposeControllers() {
    contentController.dispose();
    keyWordsController.dispose();
  }

  void _addKeyword() {
    if (keyWordsController.text.isNotEmpty) {
      setState(() {
        _keywords.add(keyWordsController.text);
        keyWordsController.clear();
      });
    }
  }

  void _removeKeyword(int index) {
    setState(() {
      _keywords.removeAt(index);
    });
  }

  void _submitPost() async {
    if (_formKey.currentState!.validate()) {
      final publicationCubit = context.read<PublicationCubit>();
      publicationCubit.createPublication(
        title: titleController.text,
        description: contentController.text,
        keywords: _keywords,
        categoryId: _selectedCategory!.id,
        language: _selectedLanguage ?? 'en',
        visibility: _selectedVisibility ?? 'PUBLIC',
      );
    }
  }

  void _showVisibilityDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Visibility'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: _visibilityOptions
              .map((option) => RadioListTile<String>(
                    title: Text(option),
                    value: option,
                    groupValue: _selectedVisibility,
                    onChanged: (value) {
                      setState(() {
                        _selectedVisibility = value;
                      });
                      Navigator.pop(context);
                    },
                  ))
              .toList(),
        ),
      ),
    );
  }

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Language'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: _languageOptions
              .map((option) => RadioListTile<String>(
                    title: Text(option),
                    value: option,
                    groupValue: _selectedLanguage,
                    onChanged: (value) {
                      setState(() {
                        _selectedLanguage = value;
                      });
                      Navigator.pop(context);
                    },
                  ))
              .toList(),
        ),
      ),
    );
  }

  void _showCategorySelector() {
    final categoryCubit = context.read<CategoryCubit>();
    showModalBottomSheet(
      context: context,
      builder: (context) => BlocProvider.value(
        value: categoryCubit,
        child: BlocBuilder<CategoryCubit, CategoryState>(
          builder: (context, state) {
            if (state is CategoriesLoadedState) {
              return ListView.builder(
                itemCount: state.categoriesList.length,
                itemBuilder: (context, index) {
                  final category = state.categoriesList[index];
                  return ListTile(
                    title: Text(category.name),
                    leading: Radio<CategoryModel>(
                      value: category,
                      groupValue: _selectedCategory,
                      onChanged: (value) {
                        setState(() {
                          _selectedCategory = value;
                        });
                        Navigator.pop(context);
                      },
                    ),
                  );
                },
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      resizeToAvoidBottomInset: false,
      appBar: _buildAppBar(),
      body: BlocConsumer<PublicationCubit, PublicationState>(
        listener: (context, state) {
          if (state is PublicationCreationLoadedState) {
            FlushBarUtils.flushBarSuccess(
                'Publication is created successfully', context);
            Future.delayed(const Duration(seconds: 3), () {
              NavigationService.goBack();
            });
          } else if (state is PublicationCreationFailedState) {
            FlushBarUtils.flushBarError(state.errMsg, context);
          }
        },
        builder: (context, state) => _createPubBodyBuilder(),
      ),
      bottomNavigationBar: _buildBottomBar(),
      floatingActionButton: _buildSpeedDial(),
    );
  }

  Widget _buildSpeedDial() {
    return SpeedDial(
      animatedIcon: AnimatedIcons.menu_close,
      animatedIconTheme: const IconThemeData(size: 22.0),
      backgroundColor: AppColors.homeBgColor,
      visible: true,
      curve: Curves.bounceIn,
      children: [
        _speedDialChild(icon: Icons.note_alt_outlined, label: 'Document'),
        _speedDialChild(icon: Icons.photo_outlined, label: 'Photo'),
        _speedDialChild(icon: Icons.videocam_outlined, label: 'Video'),
        _speedDialChild(
          icon: Icons.tag,
          label: 'Add Keywords',
          onTap: () => showModalBottomSheet(
            context: context,
            builder: (context) => _buildKeywordInputSheet(),
          ),
        ),
      ],
    );
  }

  SpeedDialChild _speedDialChild(
      {required IconData icon, void Function()? onTap, required String label}) {
    return SpeedDialChild(
      child: Icon(icon),
      backgroundColor: AppColors.oAuthBorderColor,
      onTap: onTap,
      label: label,
      labelStyle: const TextStyle(fontWeight: FontWeight.w500),
      labelBackgroundColor: Colors.white,
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => Navigator.pop(context),
      ),
      actions: [
        TextButton(
          onPressed: _submitPost,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.selectedColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              'Post',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        const SizedBox(width: 8),
      ],
      elevation: 0,
      backgroundColor: Colors.transparent,
    );
  }

  Widget _createPubBodyBuilder() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Form(key: _formKey, child: _buildFormFields()),
    );
  }

  Widget _buildFormFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // User Profile Section with Metadata
        _buildUserProfileSection(),
        const SizedBox(height: 8),

        // Content TextField
        AbsorbPointer(
          absorbing: context.read<PublicationCubit>().state
              is PublicationCreationLoadingState,
          child: _buildContentField(),
        ),
      ],
    );
  }

  Widget _buildUserProfileSection() {
    return Row(
      children: [
        // User Avatar
        ProfileImage(image: userBox!.get(kUserAvatar)),
        const SizedBox(width: 12),

        // User Info and Metadata
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userBox?.get(kUserName) ?? 'user',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 2),
              Row(
                children: [
                  // Visibility Chip
                  _publicationInfoSelector(
                      onTap: _showVisibilityDialog,
                      text: _selectedVisibility?.toLowerCase() ?? 'public'),
                  const SizedBox(width: 4),

                  // Language Chip
                  _publicationInfoSelector(
                      onTap: _showLanguageDialog,
                      text: _selectedLanguage ?? 'en'),
                  const SizedBox(width: 4),

                  // Category Chip (Drawable)
                  _publicationInfoSelector(
                      onTap: _showCategorySelector,
                      text: _selectedCategory?.name ?? 'Select Category'),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _publicationInfoSelector(
      {void Function()? onTap, required String text}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              text,
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
            const Icon(Icons.arrow_drop_down, size: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildContentField() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        TextFormField(
          controller: titleController,
          decoration: const InputDecoration(
            hintText: "Title",
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(vertical: 16),
          ),
          validator: (value) =>
              value?.isEmpty ?? true ? 'Please enter title' : null,
        ),
        TextFormField(
          controller: contentController,
          decoration: const InputDecoration(
            hintText: "What's on your mind?",
            hintStyle: AppTextStyles.barlowSize14W600Grey,
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(vertical: 16),
          ),
          style: AppTextStyles.barlowSize14W600Grey,
          maxLines: 40,
          validator: (value) =>
              value?.isEmpty ?? true ? 'Please enter content' : null,
        )
      ],
    );
  }

  Widget _buildBottomBar() {
    // Only show bottom bar if keyboard is not visible
    if (_keywords.isEmpty) {
      return const SizedBox(height: 0);
    }

    return AnimatedContainer(
      margin: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      duration: const Duration(milliseconds: 300),
      height: _keywords.isEmpty ? 0 : 50,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.2),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, -1),
          ),
        ],
      ),
      child: _keywords.isEmpty
          ? const SizedBox()
          : ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _keywords.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Chip(
                    label: Text(_keywords[index]),
                    onDeleted: () => _removeKeyword(index),
                    visualDensity: VisualDensity.compact,
                    padding: EdgeInsets.zero,
                  ),
                );
              },
            ),
    );
  }

  Widget _buildKeywordInputSheet() {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16,
        right: 16,
        top: 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Add Keywords',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: keyWordsController,
                  decoration: const InputDecoration(
                    hintText: 'Add a keyword',
                    border: OutlineInputBorder(),
                  ),
                  onFieldSubmitted: (_) {
                    _addKeyword();
                    Navigator.pop(context);
                  },
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  _addKeyword();
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
