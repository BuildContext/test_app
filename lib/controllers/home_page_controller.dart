import 'package:get/get.dart';

import '../models/user.dart';
import '../models/user_page_response.dart';
import '../services/api_service.dart';
import '../services/cache_service.dart';

/// Цей контролер відповідає за завантаження та відображення списку користувачів на головній сторінці.
///
/// [ApiService] та [CacheService] використовуються для отримання даних користувачів з API та кешу відповідно.
/// [_page] зберігає поточну сторінку користувачів.
/// [_totalPages] зберігає загальну кількість сторінок.
/// [users] - список користувачів, що відображається.
/// [isLoading] вказує, чи триває завантаження.
/// [fetchPage] завантажує поточну сторінку користувачів, кешує їх та оновлює _totalPages.
/// [fetchNextPage] завантажує наступну сторінку.

class HomePageController extends GetxController {
  final ApiService apiService = ApiService();
  final CacheService cacheService = CacheService();

  int _page = 1;
  int get page => _page;

  int _totalPages = 0;
  int get totalPages => _totalPages;

  RxList<User> users = <User>[].obs;

  RxBool isLoading = false.obs;

  @override
  void onInit() async {
    await fetchPage();
    super.onInit();
  }

  Future<void> fetchPage() async {
    isLoading.value = true;
    try {
      UsersPageResponse res = await apiService.fetchUsersPage(page: _page);
      users.addAll(res.data);
      cacheService.cacheUsers(users.value);
      _totalPages = res.totalPages;
    } catch (_) {
      users.addAll(cacheService.getCachedUsers());
    }
    isLoading.value = false;
  }

  Future<void> fetchNextPage() async {
    if (_page < _totalPages) {
      _page++;
      await fetchPage();
    }
  }
}
