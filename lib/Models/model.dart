import 'package:http/http.dart' as http;
import 'dart:convert';

class Weather {
  late double temp;
  late String description;
  late String currently;
  late int humidity;
  late double windSpeed;

  Weather({
    required this.temp,
    required this.description,
    required this.currently,
    required this.humidity,
    required this.windSpeed,
  });

  //uzak sunucudan gelen json , _tempverisini HavaModeli sınıfına dönüştürüyor.
  factory Weather.fromJson(Map<dynamic, dynamic> json) {
    return Weather(
        temp: json["main"]["temp"],
        description: json["weather"][0]["description"],
        currently: json["weather"][0]["main"],
        humidity: json["main"]["humidity"],
        windSpeed: json["wind"]["speed"]);
  }
  static Future<Weather> getWeather(String data) async {
    http.Response response = await http.get(Uri.parse(
        "http://api.openweathermap.org/data/2.5/weather?q=$data&units=metric&appid=a08f0acb7f9599faa5f2027f6f030483"));

    //gelen veri başarılıysa
    if (response.statusCode == 200) {
      Map result = jsonDecode(response.body);
      print(result);
      return Weather.fromJson(result);
    } else {
      print("uzak sunucuda hata çıktı");
    }
    throw {print("ERROR!")};
  }

  double get temp1 => temp;
  String get description1 => description;
  String get currently1 => currently;
  int get humidity1 => humidity;
  double get windSpeed1 => windSpeed;
}
