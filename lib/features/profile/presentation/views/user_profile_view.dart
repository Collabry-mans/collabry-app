import 'package:collabry/features/home_page/presentation/manager/publication/publication_cubit.dart';
import 'package:collabry/features/profile/presentation/manager/user_profile_cubit.dart';
import 'package:collabry/core/functions/functions.dart';
import 'package:collabry/core/utils/app_colors.dart';
import 'package:collabry/core/utils/app_text_styles.dart';
import 'package:collabry/core/utils/flush_bar_utils.dart';
import 'package:collabry/core/widgets/profile_image.dart';
import 'package:collabry/core/widgets/post_tile/post_tile.dart';
import 'package:collabry/features/profile/presentation/widgets/tags_section_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

class UserProfileView extends StatefulWidget {
  const UserProfileView({super.key});

  @override
  State<UserProfileView> createState() => _UserProfileViewState();
}

class _UserProfileViewState extends State<UserProfileView> {
  late final UserProfileCubit userCubit;
  late TextEditingController nameController;
  late TextEditingController bioController;
  late TextEditingController linkedInController;
  late TextEditingController expertiseController;
  late TextEditingController languagesController;
  List<String> expertise = [];
  List<String> languages = [];
  bool isEditing = false;
  String? newAvatarPath;

  @override
  void initState() {
    userCubit = context.read<UserProfileCubit>();

    _initializingControllers();
    _loadUserPublication();
    super.initState();
  }

  Future<void> _loadUserPublication() async {
    await context.read<PublicationCubit>().getAllUserPublications();
  }

  void _initializingControllers() {
    nameController = TextEditingController(text: userCubit.user!.name);
    bioController = TextEditingController(text: userCubit.user!.profile.bio);
    expertiseController = TextEditingController();
    languagesController = TextEditingController();
    linkedInController =
        TextEditingController(text: userCubit.user?.profile.linkedIn ?? '');
    expertise = List.from(userCubit.user!.profile.expertise);
    languages = List.from(userCubit.user!.profile.languages);
  }

  @override
  void dispose() {
    nameController.dispose();
    bioController.dispose();
    linkedInController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _loadUserPublication,
      child: Scaffold(
        backgroundColor: AppColors.homeBgColor,
        body: BlocConsumer<UserProfileCubit, UserProfileState>(
          listener: _handleListenerStates,
          builder: (context, state) {
            if (state is UserProfileLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }

            return Padding(
              padding: const EdgeInsets.all(10),
              child: CustomScrollView(
                slivers: [
                  _profileAppBar(context),
                  SliverToBoxAdapter(child: _userDataSection()),
                  BlocBuilder<PublicationCubit, PublicationState>(
                    builder: (context, state) {
                      return state is PublicationLoadedState
                          ? SliverList.builder(
                              itemBuilder: (context, index) {
                                final publication = state.publications[index];
                                return PostTile(
                                  publication: publication,
                                  type: PostTileType.userProfile,
                                );
                              },
                              itemCount: state.publications.length,
                            )
                          : const SliverToBoxAdapter(
                              child: Center(child: CircularProgressIndicator()),
                            );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        newAvatarPath = pickedFile.path;
      });
      // Upload the new avatar
      await userCubit.updateUserProfileAvatar(
          avatar: pickedFile.path.split('/').last);
      // Refresh user data
      await userCubit.getUserProfile();
    }
  }

  void _toggleEditing() {
    setState(() {
      isEditing = !isEditing;
      if (!isEditing) {
        nameController.text = userCubit.user!.name;
        bioController.text = userCubit.user!.profile.bio;
        linkedInController.text = userCubit.user!.profile.linkedIn ?? '';
        expertise = List.from(userCubit.user!.profile.expertise);
        languages = List.from(userCubit.user!.profile.languages);
      }
    });
  }

  void _saveChanges() async {
    if (userCubit.state is UserProfileLoadingState) {
      const Center(child: CircularProgressIndicator());
    }
    await userCubit.updateUserProfile(
      name: nameController.text,
      bio: bioController.text,
      linkedIn: linkedInController.text,
      expertise: expertise,
      languages: languages,
    );
    await userCubit.updateUserProfileAvatar(avatar: newAvatarPath ?? '');
    await userCubit.getUserProfile();
    setState(() {
      isEditing = false;
    });
  }

  void _addExpertise() {
    if (expertiseController.text.isNotEmpty &&
        !expertise.contains(expertiseController.text)) {
      setState(() {
        expertise.add(expertiseController.text);
        expertiseController.clear();
      });
    }
  }

  void _removeExpertise(String item) {
    setState(() {
      expertise.remove(item);
    });
  }

  void _addLanguage() {
    if (languagesController.text.isNotEmpty &&
        !languages.contains(languagesController.text)) {
      setState(() {
        languages.add(languagesController.text);
        languagesController.clear();
      });
    }
  }

  void _removeLanguage(String item) {
    setState(() {
      languages.remove(item);
    });
  }

  Widget _userDataSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Profile Image with edit option
        Center(child: _userProfileImage()),
        const SizedBox(height: 20),

        // Name Field
        _buildEditableField(
          label: 'Name',
          controller: nameController,
          isEditing: isEditing,
        ),
        const SizedBox(height: 16),

        // Bio Field
        _buildEditableField(
          label: 'Bio',
          controller: bioController,
          isEditing: isEditing,
          maxLines: 3,
        ),
        const SizedBox(height: 16),

        // LinkedIn Field
        _buildEditableField(
          label: 'LinkedIn',
          controller: linkedInController,
          isEditing: isEditing,
          prefixText: 'linkedin.com/in/',
        ),
        const SizedBox(height: 16),

        // Email (read-only)
        TextField(
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            hintText: userCubit.user!.email,
            enabled: false,
            hintStyle: AppTextStyles.belanosimaSize14Grey,
            border: outLineInputBorder(5),
          ),
          style: AppTextStyles.belanosimaSize14Grey,
        ),
        const SizedBox(height: 16),

        TagsSectionBuilder(
          controller: expertiseController,
          label: 'Expertise',
          tags: expertise,
          isEditing: isEditing,
          onAdd: _addExpertise,
          onRemove: _removeExpertise,
        ),
        const SizedBox(height: 16),

        TagsSectionBuilder(
          controller: languagesController,
          label: 'Languages',
          tags: languages,
          isEditing: isEditing,
          onAdd: _addLanguage,
          onRemove: _removeLanguage,
        ),
        const SizedBox(height: 16),

        Text(
          'Your publications',
          style: AppTextStyles.belanosimaSize14Grey
              .copyWith(color: AppColors.primaryColor),
        ),
      ],
    );
  }

  Stack _userProfileImage() {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomRight,
      children: [
        CircleAvatar(
          radius: 60,
          child: ProfileImage(
            image: newAvatarPath ?? userCubit.user!.profile.profileImage,
            width: 120,
            height: 120,
            radius: 60,
          ),
        ),
        if (isEditing)
          IconButton(
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(Icons.edit, color: Colors.white, size: 20),
            ),
            onPressed: _pickImage,
          ),
      ],
    );
  }

  void _handleListenerStates(context, state) {
    if (state is UserProfileEditLoadedState) {
      FlushBarUtils.flushBarSuccess(
          'user profile is updated successfully', context);
    } else if (state is UserProfileAvatarLoadedState) {
      FlushBarUtils.flushBarSuccess(
          'user profile pivture is updated successfully', context);
    }
  }

  Widget _profileAppBar(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(FontAwesomeIcons.arrowLeft),
      ),
      title: Text(
        'Profile',
        style: AppTextStyles.belanosimaSize24W600Purple
            .copyWith(color: AppColors.primaryColor),
      ),
      actions: [
        IconButton(
          icon: Icon(isEditing ? Icons.close : Icons.edit),
          onPressed: _toggleEditing,
        ),
        if (isEditing)
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveChanges,
          ),
      ],
    );
  }

  Widget _buildEditableField({
    required String label,
    required TextEditingController controller,
    required bool isEditing,
    int maxLines = 1,
    String? prefixText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.belanosimaSize14Grey
              .copyWith(color: AppColors.primaryColor),
        ),
        const SizedBox(height: 4),
        TextField(
          controller: controller,
          enabled: isEditing,
          maxLines: maxLines,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            hintText: 'Enter your $label',
            hintStyle: AppTextStyles.belanosimaSize14Grey,
            border: outLineInputBorder(5),
            prefixText: prefixText,
          ),
          style: AppTextStyles.belanosimaSize14Grey,
        ),
      ],
    );
  }
}
