import 'package:flutter/material.dart';
import 'utils/time_utils.dart';
import 'widgets/clock_button_area/clock_button_area.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _timeController = TextEditingController();
  String _showedTime = "0:00:00";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 550,
            width: double.infinity,
            child: Center(
              child: Text(_showedTime, style: TextStyle(fontSize: 56)),
            ),
          ),
          Divider(),
          ClockButtonArea(
            setShowedTime: (restTime) {
              setState(() {
                _showedTime = toShowedTime(restTime);
              });
            },
          ),
        ],
      ),
    );
  }
}
