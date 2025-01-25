import 'package:flutter_workshop/theme.dart';
import 'package:get/get.dart';

class GlobalService extends GetxService {
  static GlobalService get to => Get.find();

  Future<GlobalService> init() async {
    return this;
  }

  final _isDarkMode = Get.isDarkMode.obs;
  get isDarkMode => _isDarkMode.value;
  set isDarkMode(value) => _isDarkMode.value = value;

  void switchThemeModel() {
    isDarkMode = !isDarkMode;
    Get.changeTheme(isDarkMode ? AppTheme.dark : AppTheme.light);
  }
}
