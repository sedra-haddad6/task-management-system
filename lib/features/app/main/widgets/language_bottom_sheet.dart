import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;

import '../../../../core/style/app_colors.dart';


void showLanguageBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: context.colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (sheetContext) {
      return SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12),

            _LanguageOption(
              label: "English",
              isSelected: sheetContext.locale.languageCode == 'en',
              onTap: () async {
  await sheetContext.setLocale(const Locale('en'));
  Get.updateLocale(const Locale('en'));
  Get.forceAppUpdate();
  if (sheetContext.mounted) {
    Navigator.pop(sheetContext);
  }
},
            ),

            _LanguageOption(
              label: "العربية",
              isSelected: sheetContext.locale.languageCode == 'ar',
              onTap: () async {
                await sheetContext.setLocale(
                  const Locale('ar'),
                );
                Get.updateLocale(
                  const Locale('ar'),
                );
                Get.forceAppUpdate();
                if (sheetContext.mounted) {
                  Navigator.pop(sheetContext);
                }
              },
            ),

            const SizedBox(height: 12),
          ],
        ),
      );
    },
  );
}

class _LanguageOption extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _LanguageOption({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        label,
        style:  TextStyle(fontSize: 16, color: context.colors.darkBlue),
      ),
      trailing: isSelected
          ?  Icon(Icons.check, color: context.colors.middleBlue)
          : null,
      onTap: onTap,
    );
  }
}