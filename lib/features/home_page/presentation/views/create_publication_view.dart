import 'package:collabry/core/cubit/category/category_cubit.dart';
import 'package:collabry/core/cubit/category/category_state.dart';
import 'package:collabry/core/cubit/publication/publication_cubit.dart';
import 'package:collabry/core/utils/app_colors.dart';
import 'package:collabry/features/home_page/data/model/category_model.dart';
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

  String? _selectedVisibility;
  String? _selectedLanguage;
  CategoryModel? _selectedCategory;
  final List<String> _keywords = [];
  final List<String> _visibilityOptions = ['PRIVATE', 'PUBLIC'];
  final List<String> _languageOptions = ['en', 'ar'];

  // Focus node to detect keyboard visibility
  final FocusNode _contentFocusNode = FocusNode();
  bool _isKeyboardVisible = false;

  @override
  void initState() {
    super.initState();
    _fetchCategories();
    _initializeControllers();
    _selectedVisibility = _visibilityOptions[1]; // Default to PUBLIC
    _selectedLanguage = _languageOptions[0]; // Default to en

    // Add listener to detect keyboard visibility
    _contentFocusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    setState(() {
      _isKeyboardVisible = _contentFocusNode.hasFocus;
    });
  }

  void _fetchCategories() {
    context.read<CategoryCubit>().getAllCategories();
  }

  void _initializeControllers() {
    contentController = TextEditingController();
    keyWordsController = TextEditingController();
  }

  @override
  void dispose() {
    _contentFocusNode.removeListener(_onFocusChange);
    _contentFocusNode.dispose();
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
      if (mounted) {
        context.read<PublicationCubit>().createPublication(
              title: '', // No separate title in new design
              description: contentController.text,
              keywords: _keywords,
              categoryId: _selectedCategory!.id,
              language: _selectedLanguage ?? 'en',
              visibility: _selectedVisibility ?? 'PUBLIC',
            );
      }
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
    showModalBottomSheet(
      context: context,
      builder: (context) => BlocBuilder<CategoryCubit, CategoryState>(
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _createPubBodyBuilder(),
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
        SpeedDialChild(
          child: const Icon(Icons.note_alt_outlined),
          backgroundColor: Colors.blue,
          onTap: () {/* Handle document attachment */},
          label: 'Document',
          labelStyle: const TextStyle(fontWeight: FontWeight.w500),
          labelBackgroundColor: Colors.white,
        ),
        SpeedDialChild(
          child: const Icon(Icons.photo_outlined),
          backgroundColor: Colors.green,
          onTap: () {/* Handle photo attachment */},
          label: 'Photo',
          labelStyle: const TextStyle(fontWeight: FontWeight.w500),
          labelBackgroundColor: Colors.white,
        ),
        SpeedDialChild(
          child: const Icon(Icons.videocam_outlined),
          backgroundColor: Colors.red,
          onTap: () {/* Handle video attachment */},
          label: 'Video',
          labelStyle: const TextStyle(fontWeight: FontWeight.w500),
          labelBackgroundColor: Colors.white,
        ),
        SpeedDialChild(
          child: const Icon(Icons.tag),
          backgroundColor: Colors.orange,
          onTap: () {
            showModalBottomSheet(
              context: context,
              builder: (context) => _buildKeywordInputSheet(),
            );
          },
          label: 'Add Keywords',
          labelStyle: const TextStyle(fontWeight: FontWeight.w500),
          labelBackgroundColor: Colors.white,
        ),
      ],
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
              borderRadius: BorderRadius.circular(20),
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
      child: Form(
        key: _formKey,
        child: BlocBuilder<CategoryCubit, CategoryState>(
          builder: (context, state) {
            return state is CategoriesLoadedState
                ? _buildFormFields(state, state.categoriesList)
                : const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  Widget _buildFormFields(CategoryState state, List<CategoryModel> categories) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // User Profile Section with Metadata
        _buildUserProfileSection(),
        const SizedBox(height: 8),

        // Content TextField
        _buildContentField(),
      ],
    );
  }

  Widget _buildUserProfileSection() {
    return Row(
      children: [
        // User Avatar
        CircleAvatar(
          backgroundColor: Colors.purple[300],
          child: const Text(
            'OA',
            style: TextStyle(color: Colors.white),
          ),
        ),
        const SizedBox(width: 12),

        // User Info and Metadata
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Omar Ahmed',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 2),
              Row(
                children: [
                  // Visibility Chip (Drawable)
                  GestureDetector(
                    onTap: _showVisibilityDialog,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            _selectedVisibility?.toLowerCase() ?? 'public',
                            style: TextStyle(
                                fontSize: 12, color: Colors.grey[600]),
                          ),
                          const Icon(Icons.arrow_drop_down, size: 16),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 4),

                  // Language Chip (Drawable)
                  GestureDetector(
                    onTap: _showLanguageDialog,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            _selectedLanguage ?? 'en',
                            style: TextStyle(
                                fontSize: 12, color: Colors.grey[600]),
                          ),
                          const Icon(Icons.arrow_drop_down, size: 16),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 4),

                  // Category Chip (Drawable)
                  GestureDetector(
                    onTap: _showCategorySelector,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            _selectedCategory?.name ?? 'Select Category',
                            style: TextStyle(
                                fontSize: 12, color: Colors.grey[600]),
                          ),
                          const Icon(Icons.arrow_drop_down, size: 16),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildContentField() {
    return TextFormField(
      controller: contentController,
      focusNode: _contentFocusNode,
      decoration: const InputDecoration(
        hintText: "What's on your mind?",
        border: InputBorder.none,
        contentPadding: EdgeInsets.symmetric(vertical: 16),
      ),
      maxLines: 10,
      validator: (value) =>
          value?.isEmpty ?? true ? 'Please enter content' : null,
    );
  }

  Widget _buildBottomBar() {
    // Only show bottom bar if keyboard is not visible
    if (!_isKeyboardVisible && _keywords.isEmpty) {
      return const SizedBox(height: 0);
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: _keywords.isEmpty ? 0 : 50,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
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

  String? _validateString(String? value, String fieldName) {
    return value?.isEmpty ?? true ? 'Please enter $fieldName' : null;
  }

  String? _validateCategory(CategoryModel? value) {
    return value == null ? 'Please select a category' : null;
  }
}
