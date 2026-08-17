import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:easy_localization/easy_localization.dart';

import 'package:task_management_app/core/routes/routes.dart';
import 'package:task_management_app/core/services/pagination/options/list_view.dart';

import '../../../core/style/app_colors.dart';
import '../models/task.dart';
import '../models/task_card.dart';
import '../task_details/models/nav.dart';

import 'controller.dart';

class TasksListPage extends StatelessWidget {
  const TasksListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TasksListPageController controller = Get.put(
      TasksListPageController(),
    );

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 30, 24, 8),
          child: TextField(
            onChanged: controller.updateSearch,
            decoration: InputDecoration(
              hintText: "tasks.search_a_task".tr(),
              prefixIcon: const Icon(Icons.search),
            ),
          ),
        ),
        GetBuilder<TasksListPageController>(
          builder: (controller) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                _FilterChip(
                  label: "tasks.done_tasks".tr(),
                  isSelected: controller.currentFilter == TaskStatus.done,
                  onTap: () => controller.updateFilter(TaskStatus.done),
                ),
                const SizedBox(width: 8),
                _FilterChip(
                  label: "tasks.progress_tasks".tr(),
                  isSelected: controller.currentFilter == TaskStatus.inProgress,
                  onTap: () => controller.updateFilter(TaskStatus.inProgress),
                ),
                const SizedBox(width: 8),
                _FilterChip(
                  label: "tasks.pending_tasks".tr(),
                  isSelected: controller.currentFilter == TaskStatus.pending,
                  onTap: () => controller.updateFilter(TaskStatus.pending),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Expanded(
          child: ListViewPagination<Task>.builder(
            tag: "all_tasks",
            fetchApi: controller.fetchTasks,
            fromJson: Task.fromJson,
            onControllerInit: (paginationController) {
              controller.paginationController = paginationController;
            },
            itemBuilder: (context, index, task) => TaskCard(
              task: task,
              onTap: () => Get.toNamed(
                Pages.taskDetails.value,
                arguments: TaskDetailsPageNav(task.id),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? context.colors.middleBlue : context.colors.green,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            color: isSelected ? context.colors.white : context.colors.black,
          ),
        ),
      ),
    );
  }
}