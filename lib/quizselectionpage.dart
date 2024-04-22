import 'package:flutter/material.dart';
import 'package:scriptura/quizfilterpage.dart';

class QuizSelectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Quiz Categories'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Handle search action
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 400,
              width: MediaQuery.of(context).size.width,
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => QuizFilterPage(category: 'Old Testament')),
                      );
                    },
                    child: _buildCategoryCard(context, 'Old Testament', 'Explore quizzes from the Old Testament', Icons.book, Color(0xFFB2DFDB)),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => QuizFilterPage(category: 'New Testament')),
                      );
                    },
                    child: _buildCategoryCard(context, 'New Testament', 'Discover quizzes from the New Testament', Icons.book, Color(0xFFB2DFDB)),
                  ),
                  _buildCategoryCard(context, 'Famous Bible Stories', 'Test your knowledge on famous Bible stories', Icons.lightbulb_outline, Color(0xFFFFE0B2)),
                  _buildCategoryCard(context, 'Biblical Characters', 'Learn about important Biblical characters', Icons.people, Color(0xFFE1BEE7)),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.only(top: 20), // margin to move the container up
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Featured Quizzes',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    height: 150,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        _buildFeaturedQuizCard('Quiz 1', 'Test your knowledge on the Ten Commandments', Color(0xFFFFCCBC)),
                        _buildFeaturedQuizCard('Quiz 2', 'Explore the parables of Jesus Christ', Color(0xFFB2EBF2)),
                        _buildFeaturedQuizCard('Quiz 3', 'Identify key figures in the Book of Genesis', Color(0xFFC5CAE9)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryCard(BuildContext context, String title, String description, IconData icon, Color color) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: color,
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 27,
              color: Colors.black87,
            ),
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10), // space between the title and description
            Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeaturedQuizCard(String quizTitle, String description, Color color) {
    return Card(
      color: color,
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        width: 150,
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              quizTitle,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            SizedBox(height: 5),
            Text(
              description,
              style: TextStyle(fontSize: 11, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }
}
