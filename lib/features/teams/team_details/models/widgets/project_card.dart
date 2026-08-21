import 'package:flutter/material.dart';

import '../../../../../core/style/app_colors.dart';
import '../../../models/project.dart';


class ProjectCard extends StatelessWidget {
  final Project project;
  final VoidCallback onTap;

  const ProjectCard({super.key, required this.project, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: context.colors.lightBlue,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: context.colors.black.withOpacity(0.08),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              project.title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: context.colors.darkBlue,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              project.status,
              style: TextStyle(
                color: context.colors.black.withOpacity(.5),
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}