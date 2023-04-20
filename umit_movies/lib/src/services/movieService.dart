import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:umit_movies/src/model/movieModel.dart';

import '../constants/urls.dart';

class MovieService {
  // This function retrieves a list of movies based on the provided search text.
  // It returns a Future of a list of ModelData objects.
  Future<List<ModelData>> fetchMovies(String searchText) async {
    String url = Urls.baseUrl;

    // // Get the API key from the environment variables.
    String? apiKey = dotenv.env['movieApiKey'] ?? "";

    // Create a Map to hold query parameters.
    Map<String, dynamic> queryParameters = {
      if (searchText.isNotEmpty) "query": searchText,
      "api_key": apiKey
    };

    // Send a GET request to the API with the query parameters.
    var response = await Dio().get(
      url,
      queryParameters: queryParameters,
    );

    // If the response status code is between 200 and 299, parse the JSON data and return a list of ModelData objects.
    if (response.statusCode! >= 200 && response.statusCode! <= 299) {
      return MovieModel.fromJson(response.data).results;
    }
    // If the response status code is not between 200 and 299, throw an exception with the status code.
    return throw Exception('Error: ${response.statusCode}');
  }
}
