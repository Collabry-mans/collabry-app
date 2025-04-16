import 'package:collabry/features/home_page/data/model/publication_model.dart';
import 'package:collabry/features/home_page/presentation/widgets/post_tile.dart';
import 'package:flutter/material.dart';

class PublicationDetails extends StatefulWidget {
  const PublicationDetails({super.key, required this.publication});
  final Publication publication;

  @override
  State<PublicationDetails> createState() => _PublicationDetailsState();
}

class _PublicationDetailsState extends State<PublicationDetails> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: [
      SliverToBoxAdapter(
          child: PostTile(publication: widget.publication, isDetailed: true)),
      const SliverToBoxAdapter(child: SizedBox(height: 20))
    ]);
  }
}
