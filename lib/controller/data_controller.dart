import 'package:get/get.dart';

import '../model/Data.dart';

class DataController extends GetxController {
  var currentPage = 1.obs;
  var itemsPerPage = 10;
  RxList<Data> data = <Data>[].obs;

  @override
  void onInit() {
    // Load the initial data
    loadMoreData();
    super.onInit();
  }

  void loadMoreData() {
    // Simulate loading more data, you should replace this with your actual data loading logic
    // For example, you can make an API call to fetch the next page of data.
    // Here, we're just generating dummy data.
    for (var i = 0; i < itemsPerPage; i++) {
      data.add(Data.fromJson({
        'id': i + data.length,
        'firstName': 'First Name $i',
        'lastName': 'Last Name $i',
        // Add other data fields here
      }));
    }
  }
}
