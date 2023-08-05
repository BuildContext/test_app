import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../models/user_details_response.dart';

/// Клас [UserDetails] для відображення основних даних
/// про користувача та інформації підтримки
class UserDetails extends StatelessWidget {
  final UserDetailsResponse userDetailsModel;

  const UserDetails({Key? key, required this.userDetailsModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var user = userDetailsModel.user!;
    var supportInfo = userDetailsModel.support!;
    return Column(
      //crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        CachedNetworkImage(
          imageUrl: user.avatar,
          imageBuilder: (context, imageProvider) {
            return CircleAvatar(
              backgroundImage: imageProvider,
              radius: 50,
            );
          },
        ),
        const SizedBox(height: 16),
        Text(
          '${user.firstName} ${user.lastName}',
          style: const TextStyle(fontSize: 22),
        ),
        const SizedBox(height: 8),
        Text(user.email),
        const SizedBox(height: 8),
        Text('ID: ${user.id}'),
        const SizedBox(height: 8),
        Text('${supportInfo.text}'),
        const SizedBox(height: 8),
        Text('${supportInfo.url}'),
      ],
    );
  }
}
