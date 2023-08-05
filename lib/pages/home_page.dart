import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/widgets/loading_indicator.dart';

import '../controllers/home_page_controller.dart';
import '../models/user.dart';
import '../widgets/user_card.dart';

/// Відображає список користувачів. Використовує HomePageController для завантаження даних.
///
/// [_scrollController] відстежує прокрутку для завантаження наступної сторінки.

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomePageController controller = Get.put(HomePageController());

  final _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      // подгружаем следующую страницу
      controller.fetchNextPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
      ),
      body: Obx(
        () => Stack(
          children: [
            ListView.builder(
              shrinkWrap: true,
              controller: _scrollController,
              itemCount: controller.users.length,
              itemBuilder: (context, index) {
                User user = controller.users[index];
                return UserCard(user: user);
              },
            ),
            if (controller.isLoading.value) const LoadingIndicator(),
          ],
        ),
      ),
    );
  }
}
