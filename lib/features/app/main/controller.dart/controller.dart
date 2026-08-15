import 'package:get/get.dart';

import '../models/destinations.dart';

class MainPageController {
  Rx<HomeDestination> destination = HomeDestination.home.obs;
}