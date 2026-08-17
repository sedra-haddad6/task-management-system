import 'package:flutter/material.dart';


import '../../../../core/style/app_colors.dart';
import '../../models/team.dart';

class TeamCard extends StatelessWidget {
  final Team team;
  final VoidCallback onTap;

  const TeamCard({super.key, required this.team, required this.onTap});

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
              color: context.colors.black.withOpacity(0.08)

,
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              team.name,
              style:  TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: context.colors.darkBlue,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              "${team.pendingTasksCount} undone",
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