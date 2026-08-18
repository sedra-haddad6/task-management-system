// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:task_management_app/features/timer/controller.dart';

// import '../../core/style/repo.dart';



// class TimerCard extends StatelessWidget {
//   const TimerCard({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final pomodoro = Get.put(PomodoroController());

//     return Material(
//       child: Container(
//         width: double.infinity,
//         margin: const EdgeInsets.symmetric(
//           horizontal: 20,
//           vertical: 16,
//         ),
//         padding: const EdgeInsets.symmetric(
//           horizontal: 24,
//           vertical: 26,
//         ),
//         decoration: BoxDecoration(
//           color: StyleRepo.white,
//           borderRadius: BorderRadius.circular(28),
//           border: Border.all(
//             color: StyleRepo.lightBlue,
//             width: 2,
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: StyleRepo.darkBlue.withOpacity(0.08),
//               blurRadius: 20,
//               offset: const Offset(0, 8),
//             ),
//           ],
//         ),
//         child: Obx(
//           () => Column(
//             children: [
//               // Timer icon
//               Container(
//                 width: 52,
//                 height: 52,
//                 decoration: BoxDecoration(
//                   color: StyleRepo.lightBlue,
//                   shape: BoxShape.circle,
//                 ),
//                 child: const Icon(
//                   Icons.timer_outlined,
//                   size: 28,
//                   color: StyleRepo.darkBlue,
//                 ),
//               ),
      
//               const SizedBox(height: 18),
      
//               // Current state
//               Text(
//                 pomodoro.stateLabel,
//                 style: const TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w600,
//                   color: StyleRepo.middleBlue,
//                 ),
//               ),
      
//               const SizedBox(height: 12),
      
//               // Timer
//               Text(
//                 pomodoro.formattedTime,
//                 style: const TextStyle(
//                   fontSize: 56,
//                   fontWeight: FontWeight.bold,
//                   letterSpacing: 2,
//                   color: StyleRepo.darkBlue,
//                 ),
//               ),
      
//               const SizedBox(height: 20),
      
//               // Play / Pause + Reset
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Container(
//                     width: 58,
//                     height: 58,
//                     decoration: BoxDecoration(
//                       color: StyleRepo.darkBlue,
//                       shape: BoxShape.circle,
//                     ),
//                     child: IconButton(
//                       onPressed: pomodoro.toggleTimer,
//                       icon: Icon(
//                         pomodoro.isRunning.value
//                             ? Icons.pause_rounded
//                             : Icons.play_arrow_rounded,
//                         color: StyleRepo.white,
//                         size: 30,
//                       ),
//                     ),
//                   ),
      
//                   const SizedBox(width: 18),
      
//                   Container(
//                     width: 58,
//                     height: 58,
//                     decoration: BoxDecoration(
//                       color: StyleRepo.lightBlue,
//                       shape: BoxShape.circle,
//                     ),
//                     child: IconButton(
//                       onPressed: pomodoro.reset,
//                       icon: const Icon(
//                         Icons.refresh_rounded,
//                         color: StyleRepo.darkBlue,
//                         size: 28,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
      
//               const SizedBox(height: 22),
      
//               // Completed sessions
//               Container(
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 18,
//                   vertical: 10,
//                 ),
//                 decoration: BoxDecoration(
//                   color: StyleRepo.lightBlue,
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: Text(
//                   'Completed Sessions: ${pomodoro.sessionCount.value}',
//                   style: const TextStyle(
//                     fontSize: 13,
//                     fontWeight: FontWeight.w500,
//                     color: StyleRepo.darkBlue,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:easy_localization/easy_localization.dart';
import 'package:task_management_app/core/widgets/buttons/elevated_button.dart';
import 'package:task_management_app/features/timer/controller.dart';

import '../../core/style/app_colors.dart';

class TimerPage extends StatelessWidget {
  final dynamic task;

  const TimerPage({
    super.key,
    required this.task,
  });

  @override
  Widget build(BuildContext context) {
    final PomodoroController controller =
        Get.put(PomodoroController());

    return Scaffold(
      backgroundColor: context.colors.white,

      appBar: AppBar(
        title:  Text(
          "Pomodoro",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: context.colors.darkBlue,
          ),
        ),
        centerTitle: true,
      ),

      body: Obx(
        () {
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 20,
            ),
            child: Column(
              children: [
                const SizedBox(height: 10),

                // Timer circle
                SizedBox(
                  width: 290,
                  height: 290,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 280,
                        height: 280,
                        child: CircularProgressIndicator(
                          value: controller.progress,
                          strokeWidth: 12,
                          backgroundColor: context.colors.lightBlue,
                          color: context.colors.middleBlue,
                        ),
                      ),

                      Container(
                        width: 235,
                        height: 235,
                        decoration:  BoxDecoration(
                          shape: BoxShape.circle,
                          color: context.colors.white,
                        ),
                        child: Column(
                          mainAxisAlignment:
                              MainAxisAlignment.center,
                          children: [
                            Text(
                               controller.stateLabel.tr(),
                              style:  TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: context.colors.middleBlue,
                              ),
                            ),

                            const SizedBox(height: 10),

                            Text(
                              controller.formattedTime,
                              style:  TextStyle(
                                fontSize: 48,
                                fontWeight: FontWeight.bold,
                                color: context.colors.darkBlue,
                              ),
                            ),

                            const SizedBox(height: 5),

                            Text(
  'timer.session'.tr(
    args: [
      '${controller.sessionCount.value + 1}',
    ],
  ),
                              style:  TextStyle(
                                fontSize: 13,
                                color: context.colors.fieldBorder,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Play / Pause
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 58,
                      height: 58,
                      decoration:  BoxDecoration(
                        shape: BoxShape.circle,
                        color: context.colors.darkBlue,
                      ),
                      child: IconButton(
                        onPressed: controller.toggleTimer,
                        icon: Icon(
                          controller.isRunning.value
                              ? Icons.pause_rounded
                              : Icons.play_arrow_rounded,
                          color: context.colors.white,
                          size: 30,
                        ),
                      ),
                    ),

                    const SizedBox(width: 18),

                    Container(
                      width: 58,
                      height: 58,
                      decoration:  BoxDecoration(
                        shape: BoxShape.circle,
                        color: context.colors.lightBlue,
                      ),
                      child: IconButton(
                        onPressed: controller.reset,
                        icon:  Icon(
                          Icons.refresh_rounded,
                          color: context.colors.darkBlue,
                          size: 27,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                // Task details
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Task Details",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: context.colors.darkBlue,
                        ),
                  ),
                ),

                const SizedBox(height: 12),

                Container(
                  width: double.infinity,
                  padding:  EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: context.colors.lightBlue,
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        task.name,
                        style:  TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: context.colors.darkBlue,
                        ),
                      ),

                      const SizedBox(height: 14),

                      _TaskInfoRow(
                        icon: Icons.groups_outlined,
                        text: task.teamName,
                      ),

                      const SizedBox(height: 8),

                      _TaskInfoRow(
                        icon: Icons.calendar_today_outlined,
                        text: task.deadline.toString(),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                SizedBox(
                  width: double.infinity,
                  child: AppElevatedButton(
                    onPressed: () async {
                      controller.stop();
                      Get.back();
                    },
                    child: const Text(
                      "Back to Task",
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _TaskInfoRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const _TaskInfoRow({
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 18,
          color: context.colors.middleBlue,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style:  TextStyle(
              fontSize: 14,
              color: context.colors.darkBlue,
            ),
          ),
        ),
      ],
    );
  }
}