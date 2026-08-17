import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import '../../../../core/style/app_colors.dart'; 
import '../../../../core/config/app_builder.dart';
import '../../../../core/services/theme/controller.dart';
import '../../../profile/widgets/profile_header.dart';
import 'language_bottom_sheet.dart';


class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final AppBuilder appBuilder = Get.find<AppBuilder>();
    final ThemeController themeController = Get.find<ThemeController>();

    return Drawer(
      backgroundColor: context.colors.green,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
    
            ProfileHeader(
              name: appBuilder.userName ?? "User",
              email: appBuilder.userEmail ?? "",
              imageUrl: appBuilder.userImage,
            ),

             Divider(
  height: 1,
  thickness: 1,
  color: context.colors.grey,
),

            _DrawerItem(
              icon: Icons.settings_outlined,
              label: "drawer.settings".tr(),
              onTap: () {
                // TODO     Settings 
              
              },
            ),

            _DrawerItem(
              icon: Icons.menu_book_outlined,
              label: "drawer.language".tr(),
              onTap: () => showLanguageBottomSheet(context),
            ),

            Obx(
              () => _DrawerItem(
                icon: themeController.isDarkMode.value
                    ? Icons.dark_mode_outlined
                    : Icons.wb_sunny_outlined,
                label: "drawer.theme".tr(),
                onTap: themeController.toggleTheme,
              ),
            ),

            _DrawerItem(
              icon: Icons.logout_outlined,
              label: "drawer.logout".tr(),
              centered: true,
              onTap: appBuilder.logout,
            ),
          ],
        ),
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool centered;

  const _DrawerItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.centered = false,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      fontSize: 15,
      color: context.colors.black.withOpacity(.6),
    );

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
        decoration:  BoxDecoration(
          border: Border(
            bottom: BorderSide(color: context.colors.grey, width: 1),
          ),
        ),
        child: centered
            ? Center(child: Text(label, style: textStyle))
            : Row(
                children: [
                  Icon(icon, color: context.colors.black.withOpacity(.6)),
                  const SizedBox(width: 14),
                  Text(label, style: textStyle),
                ],
              ),
      ),
    );
  }
}