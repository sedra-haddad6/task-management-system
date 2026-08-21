import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../core/style/app_colors.dart';
import '../models/task.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  final VoidCallback onTap;

  const TaskCard({
    super.key,
    required this.task,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius:
          BorderRadius.circular(14),

      child: Container(
        margin:
            const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 6,
        ),

        padding:
            const EdgeInsets.all(14),

        decoration: BoxDecoration(
          color: context.colors.white,
          borderRadius:
              BorderRadius.circular(14),

          boxShadow: [
            BoxShadow(
              color: context.colors.black
                  .withOpacity(0.08),
              blurRadius: 8,
              offset:
                  const Offset(0, 3),
            ),
          ],
        ),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [
            Text(
              task.name,

              style: TextStyle(
                fontWeight:
                    FontWeight.bold,
                fontSize: 17,
                color:
                    context.colors.darkBlue,
              ),
            ),

            const SizedBox(height: 4),

            Text(
              "${"task_details.deadline".tr()}: "
              "${task.deadline}",

              style: TextStyle(
                color: context.colors.black
                    .withOpacity(.5),
                fontSize: 13,
              ),
            ),

            if (task.teamName.isNotEmpty)
              Text(
                task.teamName,

                style: TextStyle(
                  color: context.colors.black
                      .withOpacity(.5),
                  fontSize: 13,
                ),
              ),
          ],
        ),
      ),
    );
  }
}