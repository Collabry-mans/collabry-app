import 'package:collabry/core/routes/app_routes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const Collabry());
}

class Collabry extends StatelessWidget {
  const Collabry({super.key});
  @override
  Widget build(BuildContext context) {
    AppRoutes appRoutes = AppRoutes();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: appRoutes.getAppRoutes,
    );
  }
}
