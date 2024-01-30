import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/add_book_controller.dart';

class AddBookView extends GetView<AddBookController> {
  const AddBookView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AddBookView'),
        centerTitle: true,
      ),
      body:  Center(
        child: Form(
          child: Column(
            children: [
              TextFormField(
                controller:  controller.judulController,
                decoration: InputDecoration(hintText: "Judul"),
              ),
              TextFormField(
                controller:  controller.penulisController,
                decoration: InputDecoration(hintText: "Penulis"),
              ),
              TextFormField(
                controller:  controller.penerbitController,
                decoration: InputDecoration(hintText: "Penerbit"),
              ),
              TextFormField(
                controller:  controller.tahunterbitController,
                decoration: InputDecoration(hintText: "Tahun Terbit"),
              ),
              Obx(() => controller.loading.value
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                  onPressed: () {
                    controller.add();
                  },
                  child: Text("Tambah")))
            ],
          ),
        )
      ),
    );
  }
}
