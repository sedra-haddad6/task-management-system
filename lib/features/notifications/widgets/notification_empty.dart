import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';


import '../../../core/style/app_colors.dart';
class NotificationEmpty extends StatelessWidget {
  const NotificationEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                color: context.colors.lightBlue,
                shape: BoxShape.circle,
              ),
              child:  Icon(
                Icons.notifications_none,
                size: 45,
                color: context.colors.darkBlue,
              ),
            ),

            const SizedBox(height: 20),

             Text(
              'notifications.empty_title'.tr(),
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: context.colors.darkBlue,
              ),
            ),

            const SizedBox(height: 8),

             Text(
               'notifications.empty_subtitle'.tr(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                color: context.colors.fieldBorder,
              ),
            ),
          ],
        ),
      ),
    );
  }
}