import 'package:get/get.dart';
import '../models/user_details_response.dart';
import '../services/api_service.dart';
import '../services/cache_service.dart';

/// Цей контролер відповідає за завантаження деталей обраного користувача.
///
/// Використовує [ApiService] та [CacheService].
/// user зберігає дані про користувача.
/// [fetchUserDetails] завантажує деталі користувача, кешує їх.

class UserDetailsController extends GetxController {
  final ApiService apiService = ApiService();
  final CacheService cacheService = CacheService();

  final _user = Rxn<UserDetailsResponse>();
  UserDetailsResponse? get user => _user.value;

  RxBool isLoading = false.obs;

  void fetchUserDetails(int userId) async {
    isLoading.value = true;
    _user.value = null;
    try {
      UserDetailsResponse apiUser = await apiService.fetchUserDetails(userId);
      _user.value = apiUser;

      cacheService.cacheUser(apiUser);
    } catch (_) {
      _user.value = cacheService.getCachedUser(userId);
    }
    isLoading.value = false;
  }
}
