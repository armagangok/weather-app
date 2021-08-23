import 'package:flutter/material.dart';
import 'package:weather_app/Models/model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Weather>(
          future: Weather.getWeather(widget.data),
          builder: (context, AsyncSnapshot<Weather> snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  '${snapshot.error} occured',
                  style: TextStyle(fontSize: 18),
                ),
              );
            } else if (snapshot.hasData) {
              return Column(
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
                            widget.data.toUpperCase(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Text(
                          snapshot.data!.temp1 != null
                              ? snapshot.data!.temp.toString() + "52\u00B0"
                              : "Loading...",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 40.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          snapshot.data!.currently1 != null
                              ? snapshot.data!.currently.toString()
                              : "Loading...",
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
                            buildListTile(
                                apiEleman: snapshot.data!.currently1,
                                icon: FontAwesomeIcons.thermometerHalf,
                                text: "Temprature"),
                            buildListTile(
                                apiEleman: snapshot.data!.humidity1,
                                icon: FontAwesomeIcons.water,
                                text: "Humidtiy"),
                            buildListTile(
                                apiEleman: snapshot.data!.description1,
                                icon: FontAwesomeIcons.sun,
                                text: "Weather"),
                            buildListTile(
                                apiEleman: snapshot.data!.windSpeed1,
                                icon: FontAwesomeIcons.wind,
                                text: "Wind Speed"),
                          ],
                        )),
                  ),
                ],
              );
            }
            // Displaying LoadingSpinner to indicate waiting state
            else
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("YÜKLENİYOR!"),
                    CircularProgressIndicator(),
                  ],
                ),
              );
          }),
    );
  }

  ListTile buildListTile({apiEleman, IconData? icon, required String text}) {
    return ListTile(
      leading: FaIcon(icon),
      title: Text(text),
      trailing: Text(apiEleman != null ? apiEleman.toString() : "Loading..."),
    );
  }
}
