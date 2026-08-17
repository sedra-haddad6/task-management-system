import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart' hide Trans;

import '../../core/style/app_colors.dart';
import '../../core/widgets/buttons/elevated_button.dart';
import 'controllers/controller.dart';

class HomePage extends StatelessWidget {
  final String? label;
  const HomePage({super.key , this.label});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomePageController());

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),

      
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
         

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: context.colors.lightBlue,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
      BoxShadow(
        color: context.colors.black.withOpacity(0.12), 
        blurRadius: 4,                         
         spreadRadius: 2,                       
        offset: const Offset(0, 8),             
      ),
    ],
            ),



            child: Text(controller.quoteKey.tr(),
             maxLines: 4,
              overflow: TextOverflow.ellipsis
               ,style: TextStyle(
         fontSize: 16,
         height: 1.85,
            color: context.colors.black, 
  ), ),
          ),




          const SizedBox(height: 24),


          Text(controller.formattedDate,
          style: TextStyle( 
            fontSize: 17,
              color: context.colors.fieldBorder, ) ),


          const Spacer(),


          Center(child: Text("home.no_statistics".tr(),
          style: TextStyle(
         fontSize: 16,
            color: context.colors.black, 
  ),
           
          
          )),


          const SizedBox(height: 24),


          Center(
            child: SizedBox(
              width: 220,
              child: AppElevatedButton(
                onPressed: controller.goToJoinTeam,
                child: Text("home.join_team_button".tr()),
              ),
            ),
          ),


          const Spacer(flex: 2),
        ],
      ),
    );
  }
}