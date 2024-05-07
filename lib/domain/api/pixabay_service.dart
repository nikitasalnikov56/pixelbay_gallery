import 'package:dio/dio.dart';
import 'package:flutter_application_1/domain/model/photos.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class PixabayService {
  static final apiKey = dotenv.get('API_KEY');
  final url = 'https://pixabay.com/api/';
 
  Future<Photos> searchPhotos(String query) async {
    final dio = Dio();
    final response = await dio.get('$url?key=$apiKey&q=$query&image_type=photo');

    try {
      return Photos.fromJson(response.data);
    } catch (e) {
      throw Exception('Error: ${e.toString()}');
    }
  }
}
