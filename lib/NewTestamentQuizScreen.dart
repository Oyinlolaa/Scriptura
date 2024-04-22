import 'dart:async';
import 'package:flutter/material.dart';
import 'quizresultscreen.dart';

class NewTestamentQuizScreen extends StatefulWidget {
  final String category;
  final String difficulty;
  final int numberOfQuestions;
  final bool hintsEnabled;
  final int timerDuration;

  NewTestamentQuizScreen({
    required this.category,
    required this.difficulty,
    required this.numberOfQuestions,
    required this.hintsEnabled,
    required this.timerDuration,
  });

  @override
  _NewTestamentQuizScreenState createState() => _NewTestamentQuizScreenState();
}

class _NewTestamentQuizScreenState extends State<NewTestamentQuizScreen> {
  late int _quizDuration;
  int _currentQuestionIndex = 0;
  List<String> _questions = [
    'What did Jesus say when he was crucified?',
    'Who was the disciple known as "doubting Thomas"?',
    'Who was the apostle to the Gentiles?',
    'Who wrote the Book of Revelation?',
    'Who was the Roman governor that sentenced Jesus to death?',
    'Where was Jesus born?',
    'Who betrayed Jesus to the authorities?',
    'What sea did Jesus calm during a storm?',
    'Who was the high priest during Jesus\' trial?',
    'Where did Jesus pray before his arrest?',
    'Who helped Jesus carry the cross?',
    'Who declared "Truly this was the Son of God" after Jesus\' death?',
    'Who were the women at the tomb after Jesus\' resurrection?',
    'Who denied knowing Jesus three times?',
    'Who was the disciple known as "the beloved disciple"?',
    'What did Jesus turn water into at the wedding in Cana?',
    'Who was the mother of John the Baptist?',
    'Which disciple was a tax collector before following Jesus?',
    'Who helped bury Jesus after his crucifixion?',
    'Which angel announced the birth of Jesus to Mary?',
    'Who was the wealthy Pharisee who hosted Jesus?',
    'Who denied Jesus\' body to be taken down from the cross?',
    'Who was the first disciple called by Jesus?',
  ];
  List<List<String>> _options = [
    ['"My God, my God, why have you forsaken me?"', '"Father, forgive them, for they know not what they do."'],
    ['Peter', 'Thomas', 'Paul', 'John'],
    ['Paul', 'Peter', 'John', 'Andrew'],
    ['John', 'Matthew', 'Luke', 'Paul'],
    ['Pontius Pilate', 'Herod Antipas', 'Herod the Great', 'Augustus Caesar'],
    ['Bethlehem', 'Jerusalem', 'Nazareth', 'Bethany'],
    ['Peter', 'John', 'Judas Iscariot', 'Matthew'],
    ['Dead Sea', 'Sea of Galilee', 'Mediterranean Sea', 'Red Sea'],
    ['Caiaphas', 'Annas', 'Herod', 'Pilate'],
    ['Gethsemane', 'Calvary', 'Nazareth', 'Jerusalem'],
    ['Simon of Cyrene', 'Joseph of Arimathea', 'Nicodemus', 'John the Baptist'],
    ['Centurion', 'Pontius Pilate', 'Herod', 'Caesar'],
    ['Mary Magdalene', 'Mary, mother of Jesus', 'Martha', 'Mary, sister of Lazarus'],
    ['Judas Iscariot', 'Simon Peter', 'James', 'John'],
    ['John', 'Peter', 'James', 'Matthew'],
    ['Wine', 'Oil', 'Milk', 'Honey'],
    ['Mary', 'Martha', 'Elizabeth', 'Ruth'],
    ['Thomas', 'Simon', 'Matthew', 'Andrew'],
    ['Joseph of Arimathea', 'Simon of Cyrene', 'Nicodemus', 'John the Baptist'],
    ['Gabriel', 'Michael', 'Raphael', 'Uriel'],
    ['Nicodemus', 'Zacchaeus', 'Joseph of Arimathea', 'Simon the Pharisee'],
    ['Peter', 'John', 'Andrew', 'James'],
  ];
  List<String> _selectedAnswers = List.filled(30, '');
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _quizDuration = widget.timerDuration;
    _startQuizTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startQuizTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (timer) {
      setState(() {
        if (_quizDuration < 1) {
          timer.cancel();
          _navigateToQuizResult();
        } else {
          _quizDuration--;
        }
      });
    });
  }

  void _navigateToQuizResult() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => QuizResultScreen(
          options: _options,
          selectedAnswers: _selectedAnswers,
        ),
      ),
    );
  }

  void _selectAnswer(String answer) {
    setState(() {
      _selectedAnswers[_currentQuestionIndex] = answer;
    });
  }

  Widget _buildQuiz() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Question ${_currentQuestionIndex + 1}/${_questions.length}',
          style: TextStyle(fontSize: 18),
        ),
        SizedBox(height: 20),
        Text(
          _questions[_currentQuestionIndex],
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20),
        Column(
          children: _options[_currentQuestionIndex].map((option) {
            return _buildQuizOption(option);
          }).toList(),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            _goToNextQuestion();
          },
          child: Text('Next'),
        ),
        SizedBox(height: 20),
        Text(
          'Time left: $_quizDuration seconds',
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  Widget _buildQuizOption(String optionText) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: ElevatedButton(
        onPressed: () {
          _selectAnswer(optionText);
        },
        child: Text(optionText),
        style: ElevatedButton.styleFrom(
          backgroundColor: _selectedAnswers[_currentQuestionIndex] == optionText ? Colors.green : Colors.grey,
          padding: EdgeInsets.symmetric(vertical: 15),
        ),
      ),
    );
  }

  void _goToNextQuestion() {
    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
      });
    } else {
      _navigateToQuizResult();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Testament Quiz'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: _buildQuiz(),
      ),
    );
  }
}
