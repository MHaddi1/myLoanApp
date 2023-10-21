import 'package:get/get.dart';

class PageControllers extends GetxController {
  RxInt pageCount = 1.obs;

  void incrementPage() {
    pageCount.value++;
  }

  void decrementPage() {
    if (pageCount.value > 0) {
      pageCount.value--;
    }
  }

  void setPageNo(int value) => pageCount.value = value;
}
