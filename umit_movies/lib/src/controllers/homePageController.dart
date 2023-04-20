import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:umit_movies/src/model/movieModel.dart';
import 'package:umit_movies/src/services/movieService.dart';

class MyController extends GetxController {
  // The onInit method is overridden to fetchMovies on initialization.
  @override
  void onInit() {
    fetchMovies("");
    super.onInit();
  }

  //
  //RxBool isLoading = false.obs;

  // This list of movies that can be updated and observed for changes.
  RxList<ModelData?> movies = <ModelData>[].obs;

  // This function fetches movies from the MovieService using the specified search text.
  void fetchMovies(searchText) async {
    try {
      //isLoading.value = true;
      movies.value = await MovieService().fetchMovies(searchText);
      //isLoading.value = false;
    } catch (e) {
      //isLoading.value = false;
      print(e);
    }
  }
  // The onChangedConditions method takes in a search text and a search controller and calls the fetchMovies method based on the length of the search text.
  void onChangedConditions(
      {required String searchText,
      required TextEditingController searchController}) {
    if (searchController.text.length >= 2) {
      fetchMovies(searchText);
    } else {
      fetchMovies("");
    }
  }
}
