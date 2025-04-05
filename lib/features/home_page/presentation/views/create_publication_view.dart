import 'package:collabry/core/cubit/category/category_cubit.dart';
import 'package:collabry/core/cubit/category/category_state.dart';
import 'package:collabry/core/cubit/publication/publication_cubit.dart';
import 'package:collabry/core/utils/flush_bar_utils.dart';
import 'package:collabry/features/home_page/data/model/category_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreatePublicationView extends StatefulWidget {
  const CreatePublicationView({super.key});

  @override
  State<CreatePublicationView> createState() => _CreatePublicationViewState();
}

class _CreatePublicationViewState extends State<CreatePublicationView> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController keyWordsController;
  late final TextEditingController titleController;
  late final TextEditingController descriptionController;

  String? _selectedVisibility;
  String? _selectedLanguage;
  CategoryModel? _selectedCategory;
  final List<String> _keywords = [];
  final List<String> _visibilityOptions = ['PRIVATE', 'PUBLIC'];
  final List<String> _languageOptions = ['en', 'ar'];

  @override
  void initState() {
    super.initState();
    _fetchCategories();
    _initializeControllers();
  }

  void _fetchCategories() {
    context.read<CategoryCubit>().getAllCategories();
  }

  void _initializeControllers() {
    keyWordsController = TextEditingController();
    titleController = TextEditingController();
    descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _disposeControllers();
  }

  void _disposeControllers() {
    keyWordsController.dispose();
    titleController.dispose();
    descriptionController.dispose();
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
              title: titleController.text,
              description: descriptionController.text,
              keywords: _keywords,
              categoryId: _selectedCategory!.id,
              language: _selectedLanguage ?? 'en',
              visibility: _selectedVisibility ?? 'PUBLIC',
            );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _createPubBodyBuilder(),
    );
  }

  AppBar _buildAppBar() => AppBar(title: const Text('Create New Post'));

  Widget _createPubBodyBuilder() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
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
        // Visibility Dropdown
        _visibilityDropDownBuilder(),
        const SizedBox(height: 16),

        // Language Dropdown
        _languageDropDownBuilder(),
        const SizedBox(height: 16),

        // category Dropdown
        _categoryDropDownBuilder(categories),
        const SizedBox(height: 16),

        // Title TextField
        _textFormField('title', controller: titleController),
        const SizedBox(height: 16),

        // Description TextField
        _textFormField('description',
            controller: descriptionController, maxLines: 5),
        const SizedBox(height: 16),

        // Keywords Section
        _keyWordSection(),
        const SizedBox(height: 24),

        // Submit Button
        _handleCreationButtonState(),
      ],
    );
  }

  Widget _handleCreationButtonState() {
    return BlocConsumer<PublicationCubit, PublicationState>(
      listener: _handlePublicationState,
      builder: (context, state) {
        return state is PublicationCreationLoadingState
            ? const Center(child: CircularProgressIndicator())
            : _buildCreatePublicationButton();
      },
    );
  }

  Widget _keyWordSection() {
    return Column(
      children: [
        const Text(
          'Keywords (For post visibility)',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        _buildKeywordInputRow(),
        const SizedBox(height: 8),
        // Display added keywords
        _buildKeywordChips(),
      ],
    );
  }

  Widget _buildCreatePublicationButton() {
    return ElevatedButton(
      onPressed: _submitPost,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
      child: const Text('Create Post'),
    );
  }

  Widget _buildKeywordChips() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: List.generate(
          _keywords.length,
          (index) => Chip(
                label: Text(_keywords[index]),
                onDeleted: () => _removeKeyword(index),
              )),
    );
  }

  Widget _buildKeywordInputRow() {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: keyWordsController,
            decoration: const InputDecoration(
              hintText: 'Add a keyword',
              border: OutlineInputBorder(),
            ),
            onFieldSubmitted: (_) => _addKeyword(),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: _addKeyword,
        ),
      ],
    );
  }

  DropdownButtonFormField<String> _visibilityDropDownBuilder() {
    return DropdownButtonFormField<String>(
      decoration: _inputDecoration('visibility'),
      value: _selectedVisibility,
      items: _visibilityOptions
          .map((String value) => _buildDropdownMenuItem(value))
          .toList(),
      onChanged: (String? newValue) =>
          setState(() => _selectedVisibility = newValue),
      validator: (value) => _validateString(value, 'visibility'),
    );
  }

  DropdownButtonFormField<String> _languageDropDownBuilder() {
    return DropdownButtonFormField<String>(
      decoration: _inputDecoration('language'),
      value: _selectedLanguage,
      items: _languageOptions
          .map((String value) => _buildDropdownMenuItem(value))
          .toList(),
      onChanged: (String? newValue) =>
          setState(() => _selectedLanguage = newValue),
      validator: (value) => _validateString(value, 'language'),
    );
  }

  DropdownMenuItem<String> _buildDropdownMenuItem(String value) {
    return DropdownMenuItem<String>(
      value: value,
      child: Text(value),
    );
  }

  DropdownButtonFormField<CategoryModel> _categoryDropDownBuilder(
      List<CategoryModel> categories) {
    return DropdownButtonFormField<CategoryModel>(
      decoration: _inputDecoration('category'),
      value: _selectedCategory,
      items: categories
          .map((category) => _buildCategoryDropdownMenuItem(category))
          .toList(),
      onChanged: (newCategory) =>
          setState(() => _selectedCategory = newCategory),
      validator: _validateCategory,
    );
  }

  DropdownMenuItem<CategoryModel> _buildCategoryDropdownMenuItem(
      CategoryModel category) {
    return DropdownMenuItem<CategoryModel>(
        value: category, child: Text(category.name));
  }

  TextFormField _textFormField(String label,
      {required TextEditingController controller, int maxLines = 1}) {
    return TextFormField(
      controller: controller,
      decoration: _inputDecoration(label),
      maxLines: maxLines,
      validator: (value) => _validateString(value, label),
    );
  }

  String? _validateString(String? value, String fieldName) {
    return value?.isEmpty ?? true ? 'Please enter $fieldName' : null;
  }

  String? _validateCategory(CategoryModel? value) {
    return value == null ? 'Please select a category' : null;
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      border: const OutlineInputBorder(),
    );
  }

  void _handlePublicationState(
      BuildContext context, PublicationState state) async {
    if (state is PublicationCreationLoadedState) {
      FlushBarUtils.flushBarSuccess(
          'Ur post has been created, successfully', context);
      await Future.delayed(const Duration(seconds: 3));

      if (context.mounted) {
        Navigator.pop(context);
      }
    } else if (state is PublicationCreationFailedState) {
      FlushBarUtils.flushBarError(state.errMsg, context);
    }
  }
}
