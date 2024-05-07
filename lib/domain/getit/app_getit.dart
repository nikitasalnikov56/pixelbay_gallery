import 'package:flutter_application_1/domain/api/pixabay_service.dart';

import 'package:get_it/get_it.dart';

class AppGetIt {
  static final getIt = GetIt.instance;
  static void setupGetIt() {
    getIt.registerSingleton<PixabayService>(PixabayService());
  }
}
