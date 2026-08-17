import 'package:flutter/material.dart';
import '../../../core/style/app_colors.dart'; 


class ProfileHeader extends StatelessWidget {
  final String name;
  final String email;
  final String? imageUrl;

  const ProfileHeader({
    super.key,
    required this.name,
    required this.email,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 28,
        vertical: 32,
      ),
      child: Row(
        children: [
          _ProfileImage(
            imageUrl: imageUrl,
          ),

          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style:  TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: context.colors.darkBlue,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  email,
                  style:  TextStyle(
                    fontSize: 11,
                        color: context.colors.fieldBorder,

                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileImage extends StatelessWidget {
  final String? imageUrl;

  const _ProfileImage({
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 74,
      height: 74,
      decoration:  BoxDecoration(
        shape: BoxShape.circle,
         color: context.colors.lightBlue,
      ),
      
      clipBehavior: Clip.antiAlias,
      child: imageUrl == null || imageUrl!.isEmpty
          ?  Icon(
              Icons.person,
              size: 40,
               color: context.colors.darkBlue,
            )
          : Image.network(
              imageUrl!,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return  Icon(
                  Icons.person,
                  size: 40,
                   color: context.colors.darkBlue,
                );
              },
            ),
    );
  }
}