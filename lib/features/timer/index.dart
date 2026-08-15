import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_app/features/timer/controller.dart';

import '../../core/style/repo.dart';



class TimerCard extends StatelessWidget {
  const TimerCard({super.key});

  @override
  Widget build(BuildContext context) {
    final pomodoro = Get.put(PomodoroController());

    return Material(
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 26,
        ),
        decoration: BoxDecoration(
          color: StyleRepo.white,
          borderRadius: BorderRadius.circular(28),
          border: Border.all(
            color: StyleRepo.lightBlue,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: StyleRepo.darkBlue.withOpacity(0.08),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Obx(
          () => Column(
            children: [
              // Timer icon
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: StyleRepo.lightBlue,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.timer_outlined,
                  size: 28,
                  color: StyleRepo.darkBlue,
                ),
              ),
      
              const SizedBox(height: 18),
      
              // Current state
              Text(
                pomodoro.stateLabel,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: StyleRepo.middleBlue,
                ),
              ),
      
              const SizedBox(height: 12),
      
              // Timer
              Text(
                pomodoro.formattedTime,
                style: const TextStyle(
                  fontSize: 56,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                  color: StyleRepo.darkBlue,
                ),
              ),
      
              const SizedBox(height: 20),
      
              // Play / Pause + Reset
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 58,
                    height: 58,
                    decoration: BoxDecoration(
                      color: StyleRepo.darkBlue,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: pomodoro.toggleTimer,
                      icon: Icon(
                        pomodoro.isRunning.value
                            ? Icons.pause_rounded
                            : Icons.play_arrow_rounded,
                        color: StyleRepo.white,
                        size: 30,
                      ),
                    ),
                  ),
      
                  const SizedBox(width: 18),
      
                  Container(
                    width: 58,
                    height: 58,
                    decoration: BoxDecoration(
                      color: StyleRepo.lightBlue,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: pomodoro.reset,
                      icon: const Icon(
                        Icons.refresh_rounded,
                        color: StyleRepo.darkBlue,
                        size: 28,
                      ),
                    ),
                  ),
                ],
              ),
      
              const SizedBox(height: 22),
      
              // Completed sessions
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: StyleRepo.lightBlue,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'Completed Sessions: ${pomodoro.sessionCount.value}',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: StyleRepo.darkBlue,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}