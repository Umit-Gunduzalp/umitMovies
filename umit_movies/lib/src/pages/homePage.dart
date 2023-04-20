import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:umit_movies/src/controllers/homePageController.dart';
import 'package:umit_movies/src/model/movieModel.dart';
import 'package:umit_movies/src/theme/colors.dart';
import 'package:umit_movies/src/theme/textStyles.dart';

import '../constants/urls.dart';

class MovieSearchPage extends StatefulWidget {
  const MovieSearchPage({super.key});

  @override
  State<MovieSearchPage> createState() => _MovieSearchPageState();
}


class _MovieSearchPageState extends State<MovieSearchPage> {
// this code is for MyController class dependency injection
  final MyController _homeControllerPut = Get.put(MyController());
  final _homeControllerFind = Get.find<MyController>();

  // Controller for the search bar
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List<ModelData?> movies = (_homeControllerFind.movies);
    return SafeArea(
      child: Obx(
        () => Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...searchBarWidget(),
              movies.isEmpty ? emptyMovieState() : movieListState(movies)
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> searchBarWidget() {
    return [
      const SizedBox(height: 20),
      Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: TextField(
            controller: searchController,
            style: s13BoldWhite,
            onChanged: (String text) {
              _homeControllerFind.onChangedConditions(
                  searchText: text, searchController: searchController);
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: primaryColor2,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none),
              hintText: "Search",
              hintStyle: s16BoldGrey,
              prefixIcon: const Icon(Icons.search, color: Colors.grey),
              prefixIconColor: primaryColor,
              suffixIcon: (searchController.value.text.isNotEmpty || searchController.value.text != "")
                  ? IconButton(
                  onPressed: (){searchController.clear(); _homeControllerFind.movies.clear();},
                  icon: const Icon(Icons.cancel,color: Colors.grey,))
                  : null,
            ),
          )),
      const SizedBox(height: 10)
    ];
  }

  Expanded movieListState(List<ModelData?> movies) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(
          right: 10,
          left: 10,
          top: 10,
        ),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: .66),
          itemCount: movies.length,
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          primary: false,
          itemBuilder: (context, index) {
            final item = movies[index];
            return movieComponent(item);
          },
        ),
      ),
    );
  }

  Container movieComponent(ModelData? item) {
    return Container(
            decoration: const BoxDecoration(
                color: primaryColor2,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 270,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 9,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10)),
                            image: DecorationImage(
                              image: NetworkImage(Urls.posterPath +
                                  (item!.posterPath ?? "")),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Expanded(
                        flex: 1,
                        child: Text(
                          item.title ?? "",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: s16BoldWhite,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
  }

  Padding emptyMovieState() {
    return const Padding(
      padding: EdgeInsets.only(left: 150, top: 250),
      child: Icon(
        Icons.local_movies_outlined,
        size: 120,
        color: primaryColor2,
      ),
    );
  }
}
