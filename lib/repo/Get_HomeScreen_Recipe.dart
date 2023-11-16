import 'package:dio/dio.dart';
import '../api/Api_key.dart';
import '../models/FoodType.dart';
import '../models/Failure.dart';

const BASE_URL = 'https://api.spoonacular.com/recipes/';

class GetHomeRecipes {
  var key = ApiKey.keys;
  // ignore: non_constant_identifier_names

  final dio = Dio();

  Future<FoodTypeList> getRecipes(String type, int no) async {
    var url = BASE_URL + "/random?number=$no&tags=$type" + '&apiKey=' + key;
    final response = await dio.get(url);

    if (response.statusCode == 200) {
      return FoodTypeList.fromJson(response.data['recipes']);
    } else if (response.statusCode == 401) {
      throw Failure(code: 401, message: response.data['message']);
    } else {
      print(response.statusCode);
      throw Failure(
          code: response.statusCode!, message: response.statusMessage!);
    }
  }
}
