import 'package:flutter/material.dart';
import 'dart:io';

class ProfilePicture extends StatelessWidget {
  final File? profileImage;
  final bool isLoading;
  final VoidCallback onTap;

  const ProfilePicture({
    super.key,
    required this.profileImage,
    required this.isLoading,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: profileImage == null
                  ? LinearGradient(
                      colors: [Colors.deepPurple, Colors.deepPurple[100]!],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )
                  : null,
              image: profileImage != null
                  ? DecorationImage(
                      image: FileImage(profileImage!),
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
            child: profileImage == null
                ? Center(
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.brown[300],
                      ),
                      child: const Icon(
                        Icons.person,
                        color: Colors.white, // Replace with AppColors.white
                        size: 30,
                      ),
                    ),
                  )
                : null,
          ),
          if (isLoading)
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black.withOpacity(0.5),
              ),
              child: const Center(
                child: CircularProgressIndicator(
                  color: Colors.white, // Replace with AppColors.white
                  strokeWidth: 2,
                ),
              ),
            ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.deepPurple,
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white, // Replace with AppColors.white
                  width: 2,
                ),
              ),
              child: const Icon(
                Icons.camera_alt,
                color: Colors.white, // Replace with AppColors.white
                size: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
