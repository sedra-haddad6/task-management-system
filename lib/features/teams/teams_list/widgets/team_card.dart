import 'package:flutter/material.dart';

import 'package:task_management_app/core/style/repo.dart';

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
          color: StyleRepo.lightBlue,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
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
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: StyleRepo.darkBlue,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              "${team.pendingTasksCount} undone",
              style: TextStyle(
                color: StyleRepo.black.withOpacity(.5),
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}