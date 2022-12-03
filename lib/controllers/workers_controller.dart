import 'package:get/get.dart';

class Controller extends GetxController {
  var workers = [].obs;

  void addWorker(data) {
    workers.add(data);
  }

  void deleteWorkers() {
    workers.clear();
  }
}
