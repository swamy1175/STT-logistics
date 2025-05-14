import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../controller/shipment_controller.dart';

class ShipmentPage extends StatelessWidget {
  final ShipmentController controller = Get.put(ShipmentController());

  final nameCtrl = TextEditingController();
  final originCtrl = TextEditingController();
  final destinationCtrl = TextEditingController();
  final statusCtrl = TextEditingController();

  final statuses = ['Pending', 'In Transit', 'Delivered'];
  final selectedStatus = ''.obs;

  ShipmentPage({super.key});

  void clearFields() {
    nameCtrl.clear();
    originCtrl.clear();
    destinationCtrl.clear();
    selectedStatus.value = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Shipment CRUD')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: nameCtrl, decoration: InputDecoration(labelText: 'Customer Name')),
            TextField(controller: originCtrl, decoration: InputDecoration(labelText: 'Origin')),
            TextField(controller: destinationCtrl, decoration: InputDecoration(labelText: 'Destination')),
            SizedBox(height: 20,),
            Obx(() => DropdownButton<String>(
              value: selectedStatus.value.isEmpty ? null : selectedStatus.value,
              hint: Text('Select Status'),
              items: statuses.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              onChanged: (val) => selectedStatus.value = val!,
            )),
            SizedBox(height: 10),
            MaterialButton(
              color: Colors.indigo,
              onPressed: () {
                if (nameCtrl.text.isNotEmpty && originCtrl.text.isNotEmpty &&
                    destinationCtrl.text.isNotEmpty && selectedStatus.value.isNotEmpty) {
                  controller.addShipment(
                    nameCtrl.text,
                    originCtrl.text,
                    destinationCtrl.text,
                    selectedStatus.value,
                  );
                  clearFields();
                } else {
                  Get.snackbar("Validation", "Please fill all fields");
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Add Shipment',style: TextStyle(color: Colors.white),),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: Obx(() => ListView.builder(
                itemCount: controller.shipments.length,
                itemBuilder: (context, index) {
                  final s = controller.shipments[index];
                  return Card(
                    child: ListTile(
                      title: Text('${s.customerName} (${s.status})'),
                      subtitle: Text('${s.origin} → ${s.destination}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              nameCtrl.text = s.customerName;
                              originCtrl.text = s.origin;
                              destinationCtrl.text = s.destination;
                              selectedStatus.value = s.status;
                              Get.dialog(AlertDialog(
                                title: Text('Update Shipment'),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextField(controller: nameCtrl),
                                    TextField(controller: originCtrl),
                                    TextField(controller: destinationCtrl),
                                    Obx(() => DropdownButton<String>(
                                      value: selectedStatus.value,
                                      items: statuses.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                                      onChanged: (val) => selectedStatus.value = val!,
                                    )),
                                  ],
                                ),
                                actions: [
                                  TextButton(onPressed: () => Get.back(), child: Text('Cancel')),
                                  TextButton(
                                    onPressed: () {
                                      controller.updateShipment(
                                        s.id,
                                        nameCtrl.text,
                                        originCtrl.text,
                                        destinationCtrl.text,
                                        selectedStatus.value,
                                      );
                                      clearFields();
                                      Get.back();
                                    },
                                    child: Text('Save'),
                                  )
                                ],
                              ));
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () => controller.deleteShipment(s.id),
                          )
                        ],
                      ),
                    ),
                  );
                },
              )),
            )
          ],
        ),
      ),
    );
  }
}