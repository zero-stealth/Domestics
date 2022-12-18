import 'package:get/get.dart';

class ClientsController extends GetxController {
  var clients = [].obs;

  void addClient(data) {
    clients.add(data);
  }

  void deleteClients() {
    clients.clear();
  }
}
