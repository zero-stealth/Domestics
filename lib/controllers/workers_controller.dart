import 'package:get/get.dart';

class WorkersController extends GetxController {
  var workers = [].obs;

  void addWorker(data) {
    workers.add(data);
  }

  void deleteWorkers() {
    workers.clear();
  }
}
