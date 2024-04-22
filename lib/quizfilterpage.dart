import 'package:flutter/material.dart';
import 'OldTestamentQuizScreen.dart';
import 'NewTestamentQuizScreen.dart';

class QuizFilterPage extends StatefulWidget {
  final String category;

  QuizFilterPage({required this.category});

  @override
  _QuizFilterPageState createState() => _QuizFilterPageState();
}

class _QuizFilterPageState extends State<QuizFilterPage> {
  int _numberOfQuestions = 20;
  bool _hintsEnabled = true;
  int _selectedTimerDuration = 30;
  bool _isDarkMode = false;
  String _selectedDifficulty = 'Any';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _isDarkMode ? _darkTheme : _lightTheme,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Customize Your Quiz'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            IconButton(
              icon: _isDarkMode ? Icon(Icons.light_mode) : Icon(Icons.dark_mode),
              onPressed: () {
                setState(() {
                  _isDarkMode = !_isDarkMode;
                });
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Text(
                'Customize your quiz by selecting filters below:',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    'Select Difficulty',
                    style: TextStyle(fontSize: 18, color: _isDarkMode ? Colors.white : Colors.black),
                  ),
                  SizedBox(width: 20),
                  DropdownButton<String>(
                    value: _selectedDifficulty,
                    icon: null, // Remove the icon
                    elevation: 16,
                    style: TextStyle(color: _isDarkMode ? Colors.white : Colors.black),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedDifficulty = newValue!;
                      });
                    },
                    items: <String>['Any', 'Easy', 'Medium', 'Hard']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                'Number of Questions: $_numberOfQuestions',
                style: TextStyle(fontSize: 18),
              ),
              Slider(
                value: _numberOfQuestions.toDouble(),
                min: 5,
                max: 30,
                divisions: 25,
                label: _numberOfQuestions.toString(),
                onChanged: (double value) {
                  setState(() {
                    _numberOfQuestions = value.toInt();
                  });
                },
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Enable Hints',
                    style: TextStyle(fontSize: 18),
                  ),
                  Switch(
                    value: _hintsEnabled,
                    onChanged: (value) {
                      setState(() {
                        _hintsEnabled = value;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                'Select Timer Duration: $_selectedTimerDuration seconds',
                style: TextStyle(fontSize: 18),
              ),
              Slider(
                value: _selectedTimerDuration.toDouble(),
                min: 30,
                max: 60,
                divisions: 3,
                label: _selectedTimerDuration.toString(),
                onChanged: (double value) {
                  setState(() {
                    _selectedTimerDuration = value.toInt();
                  });
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (widget.category == 'Old Testament') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OldTestamentQuizScreen(
                          category: widget.category,
                          difficulty: _selectedDifficulty,
                          numberOfQuestions: _numberOfQuestions,
                          hintsEnabled: _hintsEnabled,
                          timerDuration: _selectedTimerDuration,
                        ),
                      ),
                    );
                  } else if (widget.category == 'New Testament') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewTestamentQuizScreen(
                          category: widget.category,
                          difficulty: _selectedDifficulty,
                          numberOfQuestions: _numberOfQuestions,
                          hintsEnabled: _hintsEnabled,
                          timerDuration: _selectedTimerDuration,
                        ),
                      ),
                    );
                  }
                },
                child: Text(
                  'Start Quiz',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  final ThemeData _lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.blue,
    hintColor: Colors.blueAccent,
    scaffoldBackgroundColor: Colors.white,
  );

  final ThemeData _darkTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.grey,
    hintColor: Colors.grey[700],
    scaffoldBackgroundColor: Colors.black,
  );
}
