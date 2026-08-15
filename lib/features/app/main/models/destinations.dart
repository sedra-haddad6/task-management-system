import 'package:flutter/material.dart';

enum HomeDestination {
  home,
  teams,
  tasks,
  notifications,
  profile
   ;

  IconData get icon => switch (this) {
    home => Icons.home_outlined,
    teams => Icons.groups_outlined,
    tasks => Icons.task_alt_outlined,
    notifications => Icons.notifications_outlined,
    profile => Icons.person_outline,
  };
}