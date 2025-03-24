import 'package:collabry/core/utils/app_strings.dart';
import 'package:collabry/features/community/presentation/widgets/channel_tile.dart';
import 'package:collabry/features/community/presentation/widgets/community_tile.dart';
import 'package:collabry/features/community/presentation/widgets/pages_card.dart';
import 'package:collabry/features/home_page/presentation/widgets/category_section.dart';
import 'package:collabry/features/home_page/presentation/widgets/custom_search.dart';
import 'package:collabry/features/home_page/presentation/widgets/view_header.dart';
import 'package:flutter/material.dart';

class CommunityView extends StatelessWidget {
  const CommunityView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        //* search
        const CustomSearch(),

        //* category
        const ViewHeader(title: AppStrings.topics),
        const CategorySection(),

        //* Suggested for u
        const ViewHeader(title: AppStrings.suggestedForU),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 180,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => const PagesCard(),
              itemCount: 6,
            ),
          ),
        ),

        //* channel
        const ViewHeader(title: AppStrings.channel),
        SliverToBoxAdapter(
          child: Column(
            children: List.generate(3, (index) => const ChannelTile()),
          ),
        ),

        //* communities
        const ViewHeader(title: AppStrings.communities),
        const SliverToBoxAdapter(
          child: CommunityTile(
            name: 'Creative Thinker',
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 30)),
      ],
    );
  }
}
