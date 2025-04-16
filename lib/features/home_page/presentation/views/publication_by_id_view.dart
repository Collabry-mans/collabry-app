import 'package:collabry/core/cubit/publication/publication_cubit.dart';
import 'package:collabry/core/utils/app_colors.dart';
import 'package:collabry/features/home_page/presentation/widgets/custom_app_bar.dart';
import 'package:collabry/features/home_page/presentation/widgets/custom_drawer.dart';
import 'package:collabry/features/home_page/presentation/widgets/publication_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class PublicationViewFactory {
  Widget createPublicationView(String publicationId);
}

// regular publication view
class StandardPublicationViewFactory implements PublicationViewFactory {
  @override
  Widget createPublicationView(String publicationId) {
    return PublicationByIdView.standard(publicationId: publicationId);
  }
}

// user-specific publication view
class UserPublicationViewFactory implements PublicationViewFactory {
  @override
  Widget createPublicationView(String publicationId) {
    return PublicationByIdView.userSpecific(publicationId: publicationId);
  }
}

class PublicationByIdView extends StatefulWidget {
  final String publicationId;
  final bool isUserSpecific;

  const PublicationByIdView._({
    required this.publicationId,
    required this.isUserSpecific,
  });

  // Factory constructor for regular publication
  factory PublicationByIdView.standard({required String publicationId}) {
    return PublicationByIdView._(
      publicationId: publicationId,
      isUserSpecific: false,
    );
  }

  // Factory constructor for user-specific publication
  factory PublicationByIdView.userSpecific({required String publicationId}) {
    return PublicationByIdView._(
      publicationId: publicationId,
      isUserSpecific: true,
    );
  }

  @override
  State<PublicationByIdView> createState() => _PublicationByIdViewState();
}

class _PublicationByIdViewState extends State<PublicationByIdView> {
  @override
  void initState() {
    if (widget.isUserSpecific) {
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
        backgroundColor: AppColors.homeBgColor,
        appBar: const CustomAppBar(),
        drawer: const CustomDrawer(),
        body: BlocConsumer<PublicationCubit, PublicationState>(
          builder: (context, state) {
            return state is PublicationByIdLoadedState
                ? Center(
                    child: PublicationDetails(publication: state.publication))
                : const Center(child: CircularProgressIndicator());
          },
          listener: (BuildContext context, PublicationState state) {},
        ),
      ),
    );
  }
}
