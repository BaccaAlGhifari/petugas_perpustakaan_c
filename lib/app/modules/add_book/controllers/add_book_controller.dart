import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petugas_perpustakaan_c/app/data/constant/endpoint.dart';
import 'package:petugas_perpustakaan_c/app/data/provider/api_provider.dart';
import 'package:petugas_perpustakaan_c/app/data/provider/storage_provider.dart';
import 'package:dio/dio.dart' as dio;
import 'package:petugas_perpustakaan_c/app/modules/book/controllers/book_controller.dart';

import '../../../routes/app_pages.dart';

class AddBookController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController  judulController = TextEditingController();
  final TextEditingController  penulisController = TextEditingController();
  final TextEditingController  penerbitController = TextEditingController();
  final TextEditingController  tahunterbitController = TextEditingController();
  final loading = false.obs;
  final count = 0.obs;
  final BookController _bookController = Get.find();
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }



add() async {
  loading(true);
  try {
    FocusScope.of(Get.context!).unfocus();
    formKey.currentState?.save();
    if (formKey.currentState!.validate()) {
      final response = await ApiProvider.instance().post(
        Endpoint.book,
        data: dio.FormData.fromMap({
          "judul": judulController.text.toString(),
          "penulis": penulisController.text.toString(),
          "penerbit": penerbitController.text.toString(),
          "tahun_terbit": int.parse(tahunterbitController.text.toString())
        }),
      );
      if (response.statusCode == 201) {
        _bookController.getData();
        Get.back();
      } else {
        Get.snackbar("Sorry", "Gagal menambahkan buku", backgroundColor: Colors.orange);
      }
    }
  } catch (e) {
    loading(false);
    if (e is dio.DioException) {
      loading(false);
      if (e.response != null) {
        if (e.response?.data != null) {
          Get.snackbar(
            "Sorry",
            "${e.response?.data['message']}",
            backgroundColor: Colors.orange,
          );
        }
      } else {
        Get.snackbar("Sorry", e.message ?? "", backgroundColor: Colors.red);
      }
    } else {
      loading(false);
      Get.snackbar("Error", e.toString(), backgroundColor: Colors.red);
    }
  } finally {
    loading(false);
  }
}
}

