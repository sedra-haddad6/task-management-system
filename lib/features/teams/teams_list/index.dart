import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:easy_localization/easy_localization.dart';
import 'package:intl/intl.dart';

import 'package:task_management_app/core/routes/routes.dart';
import 'package:task_management_app/core/services/pagination/options/list_view.dart';

import '../../../core/style/app_colors.dart';
import '../models/team.dart';
import '../team_details/models/nav.dart';
import 'controller.dart';
import 'widgets/team_card.dart';

class TeamsListPage extends StatelessWidget {
  const TeamsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TeamsListPageController controller = Get.put(
      TeamsListPageController(),
    );

    final String today = DateFormat('EEE d/M/yyyy', context.locale.toString()).format(DateTime.now());

   
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 30, 24, 8),
          child: Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              "teams.my_projects".tr(),
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              today,
              style:  TextStyle(fontSize: 20, color: context.colors.fieldBorder),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Expanded(
          child: ListViewPagination<Team>.builder(
            tag: "teams_list",
            fetchApi: controller.fetchTeams,
            fromJson: Team.fromJson,
            itemBuilder: (context, index, team) => TeamCard(
              team: team,
              onTap: () => Get.toNamed(
                Pages.teamDetails.value,
                arguments: TeamDetailsPageNav(team.id),
              ),
            ),
          ),
        ),
      ],
    );
  }
}