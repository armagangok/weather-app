import 'package:flutter/material.dart';
import 'package:weather_app/Widgets/information_page.dart';

class HomePage extends StatelessWidget {
  final data = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          // margin: ,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextFormField(
                controller: data,
                decoration: const InputDecoration(
                  icon: Icon(Icons.search),
                  labelText: 'Location',
                  hintText: 'Type location name',
                ),
              ),
              SizedBox(height: 50),
              TextButton(
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => InformationPage(
                        data: data.text,
                      ),
                    ),
                  );
                },
                child: Text(
                  "SEARCH",
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
