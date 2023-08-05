import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/widgets/loading_indicator.dart';

import '../controllers/user_details_page_controller.dart';
import '../models/user.dart';
import '../widgets/user_details.dart';

/// Сторінка з деталями обраного користувача.
/// Використовує [UserDetailsController] для завантаження даних.
/// Відображає [UserDetails] віджет з даними користувача.

class UserDetailsPage extends StatefulWidget {
  final User user;

  const UserDetailsPage({super.key, required this.user});

  @override
  State<UserDetailsPage> createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  final UserDetailsController controller = Get.put(UserDetailsController());

  @override
  void initState() {
    controller.fetchUserDetails(widget.user.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.user.firstName),
      ),
      body: Obx(
        () {
          return controller.user == null
              ? controller.isLoading.value
                  ? const LoadingIndicator()
                  : const Center(
                      child: Text('no data'),
                    )
              : UserDetails(userDetailsModel: controller.user!);
        },
      ),
    );
  }
}
