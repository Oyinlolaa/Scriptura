import 'package:flutter/material.dart';

class QuizResultScreen extends StatelessWidget {
  final List<List<String>> options;
  final List<String?> selectedAnswers;

  // correct answers list
  final List<String> correctAnswers = [
    'Adam', 'Noah', 'Jonah', 'Isaac', 'Joseph',
    'Samson', 'David', 'Solomon', 'Moses', 'David',
    'Valley of Elah', 'Joshua', 'Ten Commandments', 'Sodom and Gomorrah',
    'Abraham', 'Coat of Many Colors', 'Threw him in a well and sold him for silver',
    'Joseph', 'Hannah', 'Saul', 'Elijah', 'Elijah',
    'Nehemiah', 'Jonah', 'Ezekiel', 'Esther', 'Daniel',
    'Jonah', 'Moses', 'Noah'
  ];

  QuizResultScreen({
    required this.options,
    required this.selectedAnswers,
  });

  @override
  Widget build(BuildContext context) {
    int correctAnswersCount = 0;

    
    for (int i = 0; i < options.length; i++) {
      if (selectedAnswers[i] == correctAnswers[i]) {
        correctAnswersCount++;
      }
    }

    
    double scorePercentage = (correctAnswersCount / options.length) * 100;

    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz Results'),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        color: Colors.white.withOpacity(0.8), 
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Text(
              'Results',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Score:',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '$correctAnswersCount out of ${options.length} (${scorePercentage.toStringAsFixed(2)}%)',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: options.length,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 3,
                          margin: EdgeInsets.symmetric(vertical: 8),
                          child: ListTile(
                            title: Text(
                              'Question ${index + 1}',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 8),
                                Text(
                                  'Selected Answer: ${selectedAnswers[index]}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: selectedAnswers[index] == correctAnswers[index] ? Colors.green : Colors.red,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Correct Answer: ${correctAnswers[index]}',
                                  style: TextStyle(fontSize: 16, color: Colors.green),
                                ),
                              ],
                            ),
                            trailing: selectedAnswers[index] == correctAnswers[index]
                                ? Icon(Icons.check, color: Colors.green)
                                : Icon(Icons.close, color: Colors.red),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); 
                    },
                    child: Text('Retry Quiz'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.popUntil(context, ModalRoute.withName(Navigator.defaultRouteName)); // Navigate to the homepage
                    },
                    child: Text('Go to Homepage'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      
                    },
                    child: Text('Share Results'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
