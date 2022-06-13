import 'package:get/get.dart';
// import 'package:root/root.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class PreferensiController extends GetxController {
  var nomorInduk = ''.obs;
  var role = ''.obs;

  Future<String> getPrefs() async {
    nomorInduk('32601500598');
    return nomorInduk.value;
  }

  Future<bool> isDosen() async {
    return false;
  }
}
