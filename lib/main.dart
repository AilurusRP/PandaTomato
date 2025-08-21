import 'package:flutter/material.dart';
import 'package:panda_tomato/my_timer.dart';
import 'package:panda_tomato/time_utils.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

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
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            children: [
              Container(
                height: 50,
                width: 250,
                decoration: BoxDecoration(color: Colors.white),
                child: TextField(controller: _timeController),
              ),
              Expanded(
                child: TextButton(
                  onPressed: () async {
                    if (checkTimeInput(context, _timeController) ==
                        InputTimeState.correctInput) {
                      int totalTime = getTime(_timeController.text);
                      setState(() {
                        _showedTime = toShowedTime(totalTime);
                      });
                      MyTimer timer = MyTimer.getTimer(totalTime);
                      timer.count((restTime) {
                        setState(() {
                          _showedTime = toShowedTime(restTime);
                        });
                      });
                    }
                  },
                  child: Text("开始"),
                ),
              ),
            ],
          ),

          Expanded(
            child: Container(
              width: double.infinity,
              child: Center(
                child: Text(_showedTime, style: TextStyle(fontSize: 56)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
