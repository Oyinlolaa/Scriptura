import 'dart:async';
import 'package:flutter/material.dart';
import 'quizresultscreen.dart';

class OldTestamentQuizScreen extends StatefulWidget {
  final String category;
  final String difficulty;
  final int numberOfQuestions;
  final bool hintsEnabled;
  final int timerDuration;

  OldTestamentQuizScreen({
    required this.category,
    required this.difficulty,
    required this.numberOfQuestions,
    required this.hintsEnabled,
    required this.timerDuration,
  });

  @override
  _OldTestamentQuizScreenState createState() => _OldTestamentQuizScreenState();
}

class _OldTestamentQuizScreenState extends State<OldTestamentQuizScreen> {
  late int _quizDuration;
  int _currentQuestionIndex = 0;
  List<String> _questions = [
    'What was the name of the first man God created?',
    'Who built the ark?',
    'Who was swallowed by a great fish?',
    'What did God instruct Abraham to sacrifice?',
    'Who was sold into slavery by his brothers?',
    'Who was known for his strength?',
    'Who was a shepherd boy who became king?',
    'Who was known as the wisest man who ever lived?',
    'Who led the Israelites out of Egypt?',
    'Who defeated the giant Goliath?',
    'What was the name of the valley where David fought Goliath?',
    'Who succeeded Moses as leader of the Israelites?',
    'What did God give Moses on Mount Sinai?',
    'What was the name of the city destroyed by God because of its wickedness?',
    'Who was the father of many nations?',
    'What was the name of Joseph\'s coat?',
    'What did Joseph\'s brothers do to him?',
    'Who interpreted dreams in Egypt?',
    'Who was the mother of Samuel?',
    'Who was the first king of Israel?',
    'Who was the prophet who called down fire from heaven?',
    'Who was the prophet who was taken up to heaven in a whirlwind?',
    'Who rebuilt the walls of Jerusalem?',
    'Who was the prophet who lived in the belly of a big fish?',
    'Who was the prophet who saw a valley of dry bones come to life?',
    'Who was the queen who saved her people from destruction?',
    'Who was the prophet who was thrown into a den of lions?',
    'Who was the prophet who was swallowed by a whale?',
    'Who was the prophet who spoke to a burning bush?',
    'Who was the prophet who built an ark?',
  ];
  List<List<String>> _options = [
    ['Adam', 'Noah', 'Abraham', 'Moses'],
    ['Moses', 'Noah', 'Abraham', 'David'],
    ['Jonah', 'Moses', 'David', 'Joseph'],
    ['Isaac', 'A lamb', 'His only son', 'A bull'],
    ['Joseph', 'David', 'Moses', 'Jacob'],
    ['Samson', 'David', 'Moses', 'Joshua'],
    ['David', 'Solomon', 'Moses', 'Abraham'],
    ['Solomon', 'David', 'Abraham', 'Moses'],
    ['Abraham', 'Moses', 'Joshua', 'David'],
    ['David', 'Solomon', 'Joshua', 'Joseph'],
    ['Valley of Kings', 'Valley of Giants', 'Valley of Elah', 'Valley of Judea'],
    ['Joshua', 'David', 'Moses', 'Solomon'],
    ['Ten Commandments', 'Holy Scriptures', 'Staff of Power', 'Golden Calf'],
    ['Sodom', 'Gomorrah', 'Babylon', 'Nineveh'],
    ['Abraham', 'Moses', 'David', 'Solomon'],
    ['Coat of Many Colors', 'Coat of Many Stripes', 'Coat of Many Patterns', 'Coat of Many Shapes'],
    ['Sold him as a slave', 'Threw him in a well', 'Killed him', 'Traded him for silver'],
    ['Daniel', 'Joseph', 'David', 'Samuel'],
    ['Hannah', 'Rachel', 'Rebecca', 'Leah'],
    ['David', 'Solomon', 'Saul', 'Moses'],
    ['Elijah', 'Elisha', 'Samuel', 'Jonah'],
    ['Elijah', 'Elisha', 'Moses', 'Jonah'],
    ['Nehemiah', 'Ezra', 'David', 'Solomon'],
    ['Jonah', 'Moses', 'David', 'Joseph'],
    ['Ezekiel', 'Daniel', 'Jeremiah', 'Isaiah'],
    ['Esther', 'Ruth', 'Deborah', 'Hannah'],
    ['Elijah', 'Elisha', 'Daniel', 'Jeremiah'],
    ['Jonah', 'Moses', 'David', 'Joseph'],
    ['Moses', 'Abraham', 'Joshua', 'David'],
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
      child: OutlinedButton(
        onPressed: () {
          _selectAnswer(optionText);
        },
        child: Text(
          optionText,
          style: TextStyle(
            color: _selectedAnswers[_currentQuestionIndex] == optionText ? Colors.green : Colors.black,
          ),
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
        title: Text('Old Testament Quiz'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: _buildQuiz(),
      ),
    );
  }
}
