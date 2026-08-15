import 'package:flutter/material.dart';

import 'package:task_management_app/core/style/repo.dart';

import '../models/task.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  final VoidCallback onTap;

  const TaskCard({super.key, required this.task, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: StyleRepo.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              task.name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17,
                color: StyleRepo.darkBlue,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "deadline ${task.deadline}",
              style: TextStyle(color: StyleRepo.black.withOpacity(.5), fontSize: 13),
            ),
            Text(
              task.teamName,
              style: TextStyle(color: StyleRepo.black.withOpacity(.5), fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}