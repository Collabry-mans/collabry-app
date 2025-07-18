import 'package:collabry/core/widgets/error_display.dart';
import 'package:collabry/features/home_page/presentation/manager/publication/publication_cubit.dart';
import 'package:collabry/core/utils/app_colors.dart';
import 'package:collabry/features/home_page/presentation/widgets/custom_app_bar.dart';
import 'package:collabry/features/home_page/presentation/widgets/custom_drawer.dart';
import 'package:collabry/core/widgets/post_tile/post_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PublicationByIdView extends StatefulWidget {
  final String publicationId;
  final PostTileType type;

  const PublicationByIdView({
    super.key,
    required this.publicationId,
    required this.type,
  });

  @override
  State<PublicationByIdView> createState() => _PublicationByIdViewState();
}

class _PublicationByIdViewState extends State<PublicationByIdView> {
  @override
  void initState() {
    if (widget.type == PostTileType.detailedFromUserProfile) {
      BlocProvider.of<PublicationCubit>(context)
          .getUserPublicationById(widget.publicationId);
    } else {
      BlocProvider.of<PublicationCubit>(context)
          .getPublicationById(widget.publicationId);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const CustomAppBar(),
        drawer: const CustomDrawer(),
        body: BlocConsumer<PublicationCubit, PublicationState>(
          builder: (context, state) {
            if (state is PublicationByIdLoadedState) {
              return SingleChildScrollView(
                child: PostTile(
                  publication: state.publication,
                  type: widget.type,
                ),
              );
            } else if (state is PublicationByIdFailedState) {
              return Center(
                child: ErrorDisplay(
                  message: state.errModel.message,
                  icon: state.errModel.icon,
                  onRetry: () {
                    BlocProvider.of<PublicationCubit>(context)
                        .getPublicationById(widget.publicationId);
                  },
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(
                  color: AppColors.secondary,
                ),
              );
            }
          },
          listener: (BuildContext context, PublicationState state) {},
        ),
      ),
    );
  }
}
