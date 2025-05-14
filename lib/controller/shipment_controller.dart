import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/state_manager.dart';

import '../model/shipment_model.dart';

class ShipmentController extends GetxController {
  var shipments = <Shipment>[].obs;
  var nextId = 1.obs;

  void addShipment(String name, String origin, String destination, String status) {
    final shipment = Shipment(
      id: nextId.value,
      customerName: name,
      origin: origin,
      destination: destination,
      status: status,
    );
    shipments.add(shipment);
    nextId.value++;
  }

  void updateShipment(int id, String name, String origin, String destination, String status) {
    final index = shipments.indexWhere((s) => s.id == id);
    if (index != -1) {
      shipments[index] = shipments[index].copyWith(
        customerName: name,
        origin: origin,
        destination: destination,
        status: status,
      );
    }
  }

  void deleteShipment(int id) {
    shipments.removeWhere((s) => s.id == id);
  }
}