import 'package:collabry/core/api/end_points.dart';
import 'package:collabry/features/home_page/data/models/user.dart';

class Collaborator {
  String collaboratorId;
  User user;
  Collaborator({required this.collaboratorId, required this.user});
  factory Collaborator.fromJson(Map<String, dynamic> json) {
    return Collaborator(
        collaboratorId: json[ApiKeys.id], user: json[ApiKeys.user]);
  }
}
