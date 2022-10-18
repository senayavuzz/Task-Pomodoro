import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todoapp/tasks.dart';

void main() {
  runApp(timer());
}

class timer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
//genel tanımlamalar
class _MyHomePageState extends State<MyHomePage> {
  int _seconds = 00;
  int _minutes = 25;
  Timer _timer;
  var f = NumberFormat("00");
  //timer durdurmak içim çağırılacak olan kod parçası
  void _stopTimer(){
    if (_timer!=null){
      _timer.cancel();
      _seconds = 0;
      _minutes = 25;
    }
  }
  //timer başlatmak için çağırılacak olan kod parçası
  void _startTimer(){
    if (_timer != null){
      _stopTimer();
    }
    if (_minutes > 0){
      _seconds = _minutes * 60;
    }
    if (_seconds >60){
      _minutes = (_seconds/60).floor();
      _seconds -= (_minutes * 60);
    }
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_seconds > 0){
          _seconds--;
        }
        else {
          if (_minutes >0){
            _seconds = 59;
            _minutes--;
          }
          else {
            _timer.cancel();
          }
        }
      });
    });
  }
  //timer genel ekran özellikleri.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      //timer başlık kısmı
      appBar: AppBar(
        actions: <Widget>[
          //task ekranı ile bağlantıyı sağlayan icon
          IconButton(
            icon: Icon(
              Icons.arrow_back_outlined,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(context,MaterialPageRoute( builder:(context)=>focustask()),);
            },
          )

            ],
        centerTitle: true,
        backgroundColor: Colors.black,
        title:Text(
          'POMODORO TIMER',
        ),
      ),
      //ana ekran için konum tanımlamaları
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Center(
                child: Container(
                  alignment: Alignment.center,
                  height: 150.0 ,
                  width: 300.0,
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.deepPurpleAccent,
                        width: 5
                    ),
                    borderRadius: BorderRadius.all(
                        Radius.circular(80.0)),
                  ),
                  child:
                  Text(
                    "${f.format(_minutes)} : ${f.format(_seconds)}",
                    style: TextStyle(
                      color: Colors.deepPurpleAccent,
                      fontSize: 48,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 300,
          ),
          //sütun içerisindeki buton tanımlamaları
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RaisedButton(
                onPressed: (){
                  setState(() {
                    _stopTimer();
                  });
                },
                color: Colors.deepPurple,
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Text(
                    "STOP",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
              RaisedButton(
                onPressed: (){
                  _startTimer();
                },
                color: Colors.deepPurple,
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Text(
                    "START",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

