import 'package:collabry/core/utils/app_colors.dart';
import 'package:collabry/features/home_page/presentation/manager/publication/publication_cubit.dart';
import 'package:collabry/features/profile/presentation/manager/user_profile_cubit.dart';
import 'package:collabry/features/profile/presentation/widgets/edit_profile_dialog.dart';
import 'package:collabry/features/profile/presentation/widgets/profile_header.dart';
import 'package:collabry/features/profile/presentation/widgets/profile_tabs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserProfileView extends StatefulWidget {
  const UserProfileView({super.key});

  @override
  State<UserProfileView> createState() => _UserProfileViewState();
}

class _UserProfileViewState extends State<UserProfileView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    context.read<UserProfileCubit>().getUserProfile();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _showEditProfileDialog() {
    final cubit = context.read<UserProfileCubit>();
    if (cubit.user != null) {
      showDialog(
        context: context,
        builder: (context) => BlocProvider.value(
          value: cubit,
          child: const EditProfileDialog(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.homeBackground,
      appBar: AppBar(
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Icon(Icons.arrow_back, color: AppColors.primary, size: 30),
        ),
        backgroundColor: AppColors.white,
      ),
      body: RefreshIndicator(
        onRefresh: context.read<UserProfileCubit>().getUserProfile,
        child: BlocBuilder<PublicationCubit, PublicationState>(
          builder: (context, state) {
            return Stack(
              children: [
                Column(
                  children: [
                    ProfileHeader(onEditProfile: _showEditProfileDialog),
                    ProfileTabs(tabController: _tabController),
                  ],
                ),
                if (state is UserPublicationStateLoading ||
                    state is UserProfileEditLoadingState) ...[
                  Container(
                    height: MediaQuery.sizeOf(context).height,
                    width: MediaQuery.sizeOf(context).width,
                    color: AppColors.black.withValues(alpha: 0.6),
                  ),
                  const Center(child: CircularProgressIndicator()),
                ]
              ],
            );
          },
        ),
      ),
    );
  }
}
