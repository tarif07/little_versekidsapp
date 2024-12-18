import 'dart:async';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  int _currentQuestionIndex = 0;
  int _score = 0;
  int _timeLeft = 60; // Timer in seconds
  bool _quizEnded = false;

  // Quiz questions
  final List<Map<String, dynamic>> _questions = [
    {
      'type': 'Alphabet',
      'question': 'Identify the alphabet:',
      'image': 'assets/quiz/a.png',
      'options': ['A', 'B', 'C'],
      'answer': 'A'
    },
    {
      'type': 'Bird',
      'question': 'What bird is this?',
      'image': 'assets/quiz/parrot.png',
      'options': ['Duck', 'Parrot', 'Owl'],
      'answer': 'Parrot'
    },
    {
      'type': 'Animal',
      'question': 'Which animal is this?',
      'image': 'assets/quiz/elephant.png',
      'options': ['Camel', 'Elephant', 'Zebra'],
      'answer': 'Elephant'
    },
    {
      'type': 'Number',
      'question': 'Identify the number:',
      'image': 'assets/quiz/three.png',
      'options': ['2', '3', '4'],
      'answer': '3'
    },
    {
      'type': 'True/False',
      'question': 'True or False: A zebra is a bird.',
      'options': ['True', 'False'],
      'answer': 'False'
    },
  ];

  // Shuffle questions on quiz start
  @override
  void initState() {
    _questions.shuffle();
    startTimer();
    super.initState();
  }

  // Start Timer
  void startTimer() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (_timeLeft > 0) {
        setState(() => _timeLeft--);
      } else {
        timer.cancel();
        endQuiz();
      }
    });
  }

  // Play sound
  void playSound(String soundPath) async {
    await _audioPlayer.play(AssetSource(soundPath));
  }

  // Show Alert Dialog for Correct/Incorrect Answers
  void showAnswerAlert(bool isCorrect) {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent dialog dismissal
      builder: (context) => AlertDialog(
        title: Text(
          isCorrect ? 'Correct Answer!' : 'Incorrect Answer',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isCorrect ? Colors.green : Colors.red,
          ),
        ),
        content: Text(
          isCorrect
              ? 'Well done! Keep it up!'
              : 'Oops! That was not correct. Try the next one!',
          style: TextStyle(fontSize: 16),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              moveToNextQuestion();
            },
            child: Text('Next', style: TextStyle(fontSize: 16)),
          ),
        ],
      ),
    );
  }

  // Check Answer and Show Alert
  void checkAnswer(String selectedOption) {
    bool isCorrect =
        selectedOption == _questions[_currentQuestionIndex]['answer'];

    if (isCorrect) {
      setState(() => _score += 10);
      playSound('audio/quiz/correct.mp3');
    } else {
      playSound('audio/quiz/wrong.mp3');
    }

    // Show the alert dialog
    showAnswerAlert(isCorrect);
  }

  // Move to the next question
  void moveToNextQuestion() {
    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() => _currentQuestionIndex++);
    } else {
      endQuiz();
    }
  }

  // End Quiz
  void endQuiz() {
    setState(() => _quizEnded = true);
  }

  // Restart Quiz
  void restartQuiz() {
    setState(() {
      _currentQuestionIndex = 0;
      _score = 0;
      _timeLeft = 60;
      _quizEnded = false;
      _questions.shuffle();
      startTimer();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_quizEnded) {
      return Scaffold(
        backgroundColor: Colors.purple.shade50,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Quiz Completed!',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                'Your Score: $_score / 50',
                style: TextStyle(fontSize: 24, color: Colors.green),
              ),
              SizedBox(height: 20),
              Image.asset(
                _score >= 40
                    ? 'assets/quiz/star.jpg'
                    : 'assets/quiz/try.png', // Add reward images
                height: 100,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: restartQuiz,
                child: Text('Play Again'),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple, foregroundColor: Colors.white),
              ),
            ],
          ),
        ),
      );
    }

    // Question Screen
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz'),
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Timer
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'Time Left: $_timeLeft s',
                style: TextStyle(fontSize: 18, color: Colors.red),
              ),
            ),
            SizedBox(height: 20),
            // Question
            Text(
              _questions[_currentQuestionIndex]['question'],
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            if (_questions[_currentQuestionIndex]['image'] != null)
              Center(
                child: Image.asset(
                  _questions[_currentQuestionIndex]['image'],
                  height: 150,
                ),
              ),
            SizedBox(height: 20),
            // Options
            ...(_questions[_currentQuestionIndex]['options'] as List<String>)
                .map((option) => ElevatedButton(
              onPressed: () => checkAnswer(option),
              child: Text(option, style: TextStyle(fontSize: 18)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple.shade100,
                foregroundColor: Colors.black,
                padding: EdgeInsets.symmetric(vertical: 10),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
