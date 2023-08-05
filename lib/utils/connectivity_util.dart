import 'package:connectivity/connectivity.dart';


/// Клас [ConnectivityUtil] з статичним методом [isConnected]
/// для перевірки наявності інтернет з'єднання
class ConnectivityUtil {
  static Future<bool> isConnected() async {
    var result = await Connectivity().checkConnectivity();
    return result != ConnectivityResult.none;
  }
}
