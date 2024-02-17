import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'Settings.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => Settings()));
              },
              icon: Icon(
                Icons.settings,
                color: Colors.black87,size: 30,
              ))
        ],
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Weather App',
          style: GoogleFonts.merriweather(color: Colors.black87, fontSize: 25),
        ),
      ),
      body: Center(
        child: WeatherWidget(),
      ),
    );
  }
}

class WeatherWidget extends StatefulWidget {
  @override
  _WeatherWidgetState createState() => _WeatherWidgetState();
}

class _WeatherWidgetState extends State<WeatherWidget> {
  String _location = '';
  String _temperature = '';
  String _weatherCondition = '';
  bool _loading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchWeatherData();
  }

  Future<void> _fetchWeatherData() async {
    setState(() {
      _loading = true;
      _errorMessage = '';
    });

    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      String url =
          'https://api.openweathermap.org/data/2.5/weather?lat=10.93&lon=76.00&appid=ac0797a458f376e58b5fcf709618283f'; // Corrected URL
      http.Response response = await http.get(Uri.parse(url));
      Map<String, dynamic> data = json.decode(response.body);
      setState(() {
        _location = '${data['name']}, ${data['sys']['country']}';
        _temperature = '${data['main']['temp']}°C';
        _weatherCondition = data['weather'][0]['main'];
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Error fetching weather data';
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _loading
            ? CircularProgressIndicator()
            : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  color: Colors.blue.shade100,
                  height: 500,
                  width: double.infinity,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: SvgPicture.asset(
                          "Asset/Svg images/weather.svg",
                          width: 200,
                          height: 200,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        _location,
                        style: TextStyle(fontSize: 20,color: Colors.black87),
                      ),
                      SizedBox(height: 10),
                      Text(
                        _temperature,
                        style: TextStyle(fontSize: 30,color: Colors.black87),
                      ),
                    ],
                  ),
                ),
            ),
        SizedBox(height: 10),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
          onPressed: () => _fetchWeatherData(),
          child: Text(
            'Refresh',
            style: GoogleFonts.aBeeZee(color: Colors.white),
          ),
        ),
        SizedBox(height: 10),
        Text(
          _errorMessage,
          style: TextStyle(color: Colors.red),
        ),
      ],
    );
  }
}
