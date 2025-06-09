import 'package:collabry/core/utils/app_text_styles.dart';
import 'package:collabry/core/widgets/profile_image.dart';
import 'package:collabry/features/home_page/presentation/widgets/create_publication/create_publication_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:collabry/core/utils/app_colors.dart';
import 'package:collabry/core/utils/flush_bar_utils.dart';
import 'package:collabry/features/profile/presentation/manager/user_profile_cubit.dart';
import 'dart:io';

class EditProfileDialog extends StatefulWidget {
  const EditProfileDialog({super.key});

  @override
  State<EditProfileDialog> createState() => _EditProfileDialogState();
}

class _EditProfileDialogState extends State<EditProfileDialog> {
  late TextEditingController _nameController;
  late TextEditingController _bioController;
  late TextEditingController _linkedInController;
  late TextEditingController _expertiseController;
  late TextEditingController _languagesController;

  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    final cubit = context.read<UserProfileCubit>();
    final user = cubit.user!;

    _nameController = TextEditingController(text: user.name);
    _bioController = TextEditingController(text: user.profile.bio);
    _linkedInController =
        TextEditingController(text: user.profile.linkedIn ?? '');
    _expertiseController =
        TextEditingController(text: user.profile.expertise.join(', '));
    _languagesController =
        TextEditingController(text: user.profile.languages.join(', '));
  }

  @override
  void dispose() {
    _nameController.dispose();
    _bioController.dispose();
    _linkedInController.dispose();
    _expertiseController.dispose();
    _languagesController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final ImageSource? source = await _showImageSourceDialog();
    if (source == null) return;

    try {
      final XFile? pickedFile = await _picker.pickImage(source: source);

      if (pickedFile != null) {
        setState(() {
          _selectedImage = File(pickedFile.path);
        });
      }
    } catch (e) {
      if (mounted) {
        FlushBarUtils.flushBarError(
          'Failed to pick image: ${e.toString()}',
          context,
        );
      }
    }
  }

  Future<ImageSource?> _showImageSourceDialog() async {
    return await showModalBottomSheet<ImageSource>(
      context: context,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: AppColors.ghostWhite,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Select Image Source',
              style: AppTextStyles.belanosimaSize16BlackBold,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _ImageSourceOption(
                  icon: Icons.camera_alt,
                  label: 'Camera',
                  onTap: () => Navigator.pop(context, ImageSource.camera),
                ),
                _ImageSourceOption(
                  icon: Icons.photo_library,
                  label: 'Gallery',
                  onTap: () => Navigator.pop(context, ImageSource.gallery),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _saveProfile() {
    final cubit = context.read<UserProfileCubit>();

    // Parse expertise and languages
    final expertise = _expertiseController.text
        .split(',')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();

    final languages = _languagesController.text
        .split(',')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();

    // Update profile
    cubit.updateUserProfile(
      name: _nameController.text.trim(),
      bio: _bioController.text.trim(),
      linkedIn: _linkedInController.text.trim(),
      expertise: expertise,
      languages: languages,
    );

    // Update avatar if image is selected
    if (_selectedImage != null) {
      cubit.updateUserProfileAvatar(avatar: _selectedImage!.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<UserProfileCubit>();
    final user = cubit.user!;

    return BlocListener<UserProfileCubit, UserProfileState>(
      listener: (context, state) {
        if (state is UserProfileEditLoadedState) {
          Navigator.pop(context);
          FlushBarUtils.flushBarSuccess(
              'Profile updated successfully!', context);
        } else if (state is UserProfileEditFailedState) {
          FlushBarUtils.flushBarError(state.errModel.message, context);
        }
      },
      child: Dialog(
        backgroundColor: AppColors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          constraints: BoxConstraints(
              maxHeight: MediaQuery.sizeOf(context).height * 0.5),
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Header
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Edit Profile',
                              style: AppTextStyles.belanosimaSize16BlackBold
                                  .copyWith(fontSize: 20),
                            ),
                            IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: const Icon(Icons.close),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),

                        // Profile Picture
                        GestureDetector(
                          onTap: _pickImage,
                          child: Stack(
                            children: [
                              _selectedImage != null
                                  ? CircleAvatar(
                                      backgroundColor: AppColors.secondary,
                                      radius: 50,
                                      child: ClipOval(
                                          child: Image.file(
                                        height: 100,
                                        _selectedImage!,
                                        fit: BoxFit.cover,
                                      )),
                                    )
                                  : ProfileImage(
                                      image: user.profile.profileImage,
                                      radius: 50,
                                    ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: AppColors.primary,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: Colors.white, width: 2),
                                  ),
                                  child: const Icon(
                                    Icons.camera_alt,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),

                        Column(
                          children: [
                            PTxtField(
                              controller: _nameController,
                              label: 'Name',
                              hint: 'Enter your name',
                            ),
                            const SizedBox(height: 16),
                            PTxtField(
                              controller: _bioController,
                              label: 'Bio',
                              hint: 'Tell us about yourself',
                              maxLines: 3,
                            ),
                            const SizedBox(height: 16),
                            PTxtField(
                              controller: _linkedInController,
                              label: 'LinkedIn',
                              hint: 'LinkedIn profile URL',
                            ),
                            const SizedBox(height: 16),
                            PTxtField(
                              controller: _expertiseController,
                              label: 'Expertise',
                              hint: 'Enter skills separated by commas',
                            ),
                            const SizedBox(height: 16),
                            PTxtField(
                              controller: _languagesController,
                              label: 'Languages',
                              hint: 'Enter languages separated by commas',
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        // Action Buttons
                      ],
                    ),
                  ),
                ),
              ),
              BlocBuilder<UserProfileCubit, UserProfileState>(
                builder: (context, state) {
                  final isLoading = state is UserProfileEditLoadingState;

                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed:
                                isLoading ? null : () => Navigator.pop(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.white,
                              foregroundColor: AppColors.primary,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text('Cancel'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: isLoading ? null : _saveProfile,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              foregroundColor: AppColors.white,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: isLoading
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.white,
                                    ),
                                  )
                                : const Text('Save'),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _ImageSourceOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ImageSourceOption({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, size: 32, color: AppColors.primary),
            const SizedBox(height: 8),
            Text(label,
                style:
                    AppTextStyles.belanosimaSize12Black.copyWith(fontSize: 14)),
          ],
        ),
      ),
    );
  }
}
