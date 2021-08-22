import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class InformationPage extends StatefulWidget {
  final String data;

  const InformationPage({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  _InformationPageState createState() => _InformationPageState();
}

class _InformationPageState extends State<InformationPage> {
  var temp;
  var description;
  var currently;
  var humidity;
  var windSpeed;

  Future getWeather() async {
    var url =
        "http://api.openweathermap.org/data/2.5/weather?q=${widget.data}&units=imperial&appid=a08f0acb7f9599faa5f2027f6f030483";
    http.Response response = await http.get(Uri.parse(url));

    var result = jsonDecode(response.body);

    setState(() {
      this.temp = result['main']['temp'];
      this.description = result['weather'][0]['description'];
      this.currently = result['weather'][0]['main'];
      this.humidity = result['main']['humidity'];
      this.windSpeed = result['wind']['speed'];
    });
  }

  @override
  void initState() {
    super.initState();
    this.getWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 4.5,
            width: MediaQuery.of(context).size.width,
            color: Colors.red,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: 10,
                  ),
                  child: Text(
                    widget.data,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Text(
                  temp != null ? temp.toString() + "52\u00B0" : "Loading...",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  currently != null ? currently.toString() : "Loading...",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: ListView(
                children: [
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.thermometerHalf),
                    title: Text("Temperature"),
                    trailing: Text(temp != null
                        ? temp.toString()
                        : "loading" + "52/u00B0"),
                  ),
                  ListTile(
                    leading: FaIcon(
                      FontAwesomeIcons.water,
                    ),
                    title: Text("Humidtiy"),
                    trailing: Text(
                        humidity != null ? humidity.toString() : "Loading..."),
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.sun),
                    title: Text("Weather"),
                    trailing:
                        Text(description != null ? description : "Loading..."),
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.wind),
                    title: Text("Wind Speed"),
                    trailing: Text(windSpeed != null
                        ? windSpeed.toString()
                        : "Loading..."),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
