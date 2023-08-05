import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../models/user.dart';
import '../pages/user_details_page.dart';

/// Клас [UserCard] для побудови картки користувача
/// з аватаркою, ім'ям, email та навігацією на сторінку деталей
class UserCard extends StatelessWidget {
  final User user;

  const UserCard({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UserDetailsPage(
              user: user,
            ),
          ),
        );
      },
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 10,
          // api віддає 2 сторінки по 6 корисувачів, 
          // тому зроблено щоб була можливість скролити на будь-якій діагоналі єкрану 
          // після скролу до низу списку підгружаєтся наступна сторінка 
          vertical: MediaQuery.of(context).size.height / 24,
        ),
        child: Card(
          child: ListTile(
            leading: CachedNetworkImage(
              width: 100,
              height: 100,
              imageUrl: user.avatar,
              imageBuilder: (context, imageProvider) {
                return CircleAvatar(
                  backgroundImage: imageProvider,
                );
              },
            ),
            title: Text(
              user.firstName,
              style: const TextStyle(fontSize: 30),
            ),
            subtitle: Text(
              user.email,
              style: const TextStyle(fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }
}
