import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class ApiHelper{
  Future<List> fetchApi() async {
    Uri uri = Uri.parse("https://jsonplaceholder.typicode.com/todos");
    Response response = await http.get(uri);

    try{
      if(response.statusCode == 200){
        List data = jsonDecode(response.body);
        return data;
      } else{
        throw Exception("Failed to fetch data!");
      }
    } catch(e){
      throw Exception("Failed to fetch");
    }
  }
}
