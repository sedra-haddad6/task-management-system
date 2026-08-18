import 'package:flutter/material.dart';
import 'package:task_management_app/features/profile/models/profile_state.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../core/style/app_colors.dart';


class StatisticsSection extends StatelessWidget {
  final ProfileStats stats;

  const StatisticsSection({
    super.key,
    required this.stats,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28),
      child: Column(
        children: [
           Text(
             'profile.statistics_title'.tr(),
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w500,
              color: context.colors.darkBlue,
            ),
          ),

          const SizedBox(height: 22),

          _StatisticsBlock(
            icon: Icons.school_outlined,
            title: 'profile.tasks_title'.tr(),
            children: [
              // Using args to inject the number into the {} placeholder from the json file
              'profile.tasks_done'.tr(args: [stats.completedTasks.toString()]),
              'profile.tasks_in_progress'.tr(args: [stats.inProgressTasks.toString()]),
              'profile.tasks_pending'.tr(args: [stats.pendingTasks.toString()]),
            ],
          ),

          const SizedBox(height: 25),

          _StatisticsBlock(
            icon: Icons.school_outlined,
            title: 'profile.scores_title'.tr(),
            children: [
              'profile.current_score'.tr(args: [stats.currentScore.toString()]),
              'profile.lost_score'.tr(args: [stats.lostScore.toString()]),
              'profile.reward_hint'.tr(),
            ],
          ),

          const SizedBox(height: 8),

          Align(
            alignment: Alignment.center,
            child: Text(
              'profile.learn_more_scores'.tr(),
              style: TextStyle(
                fontSize: 9,
                color: context.colors.fieldBorder,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatisticsBlock extends StatelessWidget {
  final IconData icon;
  final String title;
  final List<String> children;

  const _StatisticsBlock({
    required this.icon,
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            border: Border.all(
              color: context.colors.darkBlue,
              width: 3,
            ),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Icon(
            icon,
            color: context.colors.darkBlue,
            size: 23,
          ),
        ),

        const SizedBox(width: 14),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style:  TextStyle(
                  fontSize: 16,
                  color: context.colors.darkBlue,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 7),

              ...children.map(
                (text) => Padding(
                  padding: const EdgeInsets.only(bottom: 7),
                  child: Text(
                    text,
                    style:  TextStyle(
                      fontSize: 10,
                      color: context.colors.fieldBorder,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}