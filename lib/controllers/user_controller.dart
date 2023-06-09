import 'package:get/get.dart';

class UserController extends GetxController {
  var user = [].obs;

  void addUser(data) {
    user.add(data);
    print("Added: $data");
  }

  void deleteUser() {
    user.clear();
  }
}
