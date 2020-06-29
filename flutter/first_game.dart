import 'dart:math';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

final Color gray = Color.fromARGB(255, 160, 160, 160);

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: gray,
        body: new HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int secondsLeft = 30;
  double kilometers = 0;
  double speed = 0;
  double fuel = 0;
  Timer timer;

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(Duration(seconds: 1), updateClock);
  }

  void updateClock(Timer timer) {
    if (secondsLeft == 0) {
      timer.cancel();      
      _showDialog();
      return;
    }

    setState(() {
      secondsLeft -= 1;
    });
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Powiadomienie"),
          content: new Text("Koniec czasu!"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Zamknij"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _train() {
    if (secondsLeft > 0) {
      setState(() {
        var random = Random();

        kilometers += random.nextInt(30) / 10;
        speed += random.nextInt(20) / 10;
        fuel += random.nextInt(10) / 50;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          "$secondsLeft sekund",
          style: TextStyle(
            color: Colors.black,
            fontSize: 32,
          ),
        ),
        Image.network(
          "http://pluspng.com/img-png/volkswagen-png-blue-volkswagen-golf-png-car-image-1881.png",
          width: 500,
          height: 268,
        ),
        RaisedButton(
          onPressed: _train,
          color: Colors.black,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Text("Jedź", style: TextStyle(color: Colors.white)),
          ),
        ),
        Container(
          padding: EdgeInsets.all(16),
          color: Colors.black,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              StatsBox(label: "km/h", value: speed),
              StatsBox(label: "Dystans", value: kilometers),
              StatsBox(label: "Paliwo", value: fuel),
            ],
          ),
        ),
      ],
    );
  }
}

class StatsBox extends StatelessWidget {
  StatsBox({
    Key key,
    this.label,
    this.value,
  }) : super(key: key);

  final String label;
  final double value;

  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.amber,
            fontSize: 13,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            value.toStringAsFixed(2),
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

