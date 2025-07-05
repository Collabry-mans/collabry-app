// widgets/profile_tabs.dart
import 'package:collabry/core/functions/extensions/theme_extension.dart';
import 'package:collabry/core/widgets/error_display.dart';
import 'package:collabry/core/widgets/post_tile/post_tile.dart';
import 'package:collabry/features/home_page/presentation/manager/publication/publication_cubit.dart';
import 'package:collabry/features/profile/data/model/publication_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileTabs extends StatelessWidget {
  final TabController tabController;

  const ProfileTabs({
    super.key,
    required this.tabController,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Container(
            color: context.customColors.bottomNavBarColor,
            child: TabBar(
              controller: tabController,
              labelColor: context.customColors.purpleTextColor,
              unselectedLabelColor: Colors.grey[500],
              indicatorColor: context.customColors.purpleTextColor,
              indicatorWeight: 5,
              tabs: const [
                Tab(text: 'Posts'),
                Tab(text: 'Replies'),
                Tab(text: 'Saved'),
                Tab(text: 'Drafts'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [
                FilteredPublicationTab(status: PublicationStatus.published),
                const EmptyTab(tabName: 'Replies'),
                const EmptyTab(tabName: 'Saved'),
                FilteredPublicationTab(status: PublicationStatus.draft),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FilteredPublicationTab extends StatefulWidget {
  final PublicationStatus status;

  const FilteredPublicationTab({
    super.key,
    required this.status,
  });

  @override
  State<FilteredPublicationTab> createState() => _FilteredPublicationTabState();
}

class _FilteredPublicationTabState extends State<FilteredPublicationTab> {
  @override
  void initState() {
    _loadUserPublication();
    super.initState();
  }

  Future<void> _loadUserPublication() async {
    await context.read<PublicationCubit>().getAllUserPublications();
  }

  @override
  Widget build(BuildContext context) {
    final String status = widget.status.value;
    final String tabName = widget.status.name;

    return RefreshIndicator(
      onRefresh: _loadUserPublication,
      child: BlocBuilder<PublicationCubit, PublicationState>(
        buildWhen: (_, curr) =>
            curr is PublicationLoadingState ||
            curr is PublicationLoadedState ||
            curr is PublicationFailedState,
        builder: (context, state) {
          if (state is PublicationLoadedState) {
            final filtered = state.publications
                .where((pub) => pub.status == status)
                .toList();

            if (filtered.isEmpty) {
              return EmptyTab(tabName: tabName);
            }

            return ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 15),
              itemCount: filtered.length,
              itemBuilder: (context, index) {
                return PostTile(
                  publication: filtered[index],
                  type: widget.status == PublicationStatus.draft
                      ? PostTileType.draftedPost
                      : PostTileType.userProfile,
                );
              },
            );
          } else if (state is PublicationFailedState) {
            return Center(
              child: ErrorDisplay(
                message: state.errModel.message,
                icon: state.errModel.icon,
                onRetry: _loadUserPublication,
              ),
            );
          } else if (state is PublicationLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}

class EmptyTab extends StatelessWidget {
  final String tabName;

  const EmptyTab({
    super.key,
    required this.tabName,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.inbox_outlined,
            size: 64,
            color: Colors.grey[300],
          ),
          const SizedBox(height: 16),
          Text(
            'No $tabName yet',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }
}
