import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class AnimalsScreen extends StatefulWidget {
  @override
  _AnimalsScreenState createState() => _AnimalsScreenState();
}

class _AnimalsScreenState extends State<AnimalsScreen> {
  final List<String> animals = [
    'Camel',
    'Cow',
    'Elephant',
    'Goat',
    'Horse',
    'Monkey',
    'Zebra'
  ];

  final Map<String, String> images = {
    'Camel': 'assets/animals/camel.png',
    'Cow': 'assets/animals/cow.png',
    'Elephant': 'assets/animals/elephant.png',
    'Goat': 'assets/animals/goat.png',
    'Horse': 'assets/animals/horse.png',
    'Monkey': 'assets/animals/monkey.png',
    'Zebra': 'assets/animals/zebra.png',
  };

  final Map<String, String> audioPaths = {
    'Camel': 'audio/animals/camel.mp3',
    'Cow': 'audio/animals/cow.mp3',
    'Elephant': 'audio/animals/elephant.mp3',
    'Goat': 'audio/animals/goat.mp3',
    'Horse': 'audio/animals/horse.mp3',
    'Monkey': 'audio/animals/monkey.mp3',
    'Zebra': 'audio/animals/zebra.mp3',
  };

  int currentIndex = 0;
  final AudioPlayer _audioPlayer = AudioPlayer();

  void playAudio(String path) async {
    try {
      await _audioPlayer.stop();
      await _audioPlayer.play(AssetSource(path));
    } catch (e) {
      print("Error playing audio: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    String currentAnimal = animals[currentIndex];
    String currentImage = images[currentAnimal]!;
    String currentAudio = audioPaths[currentAnimal]!;

    return Scaffold(
      appBar: AppBar(
        title: Text('Animals'),
        backgroundColor: Color(0xFF8E6CD0),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Animal Image Card
              Container(
                height: MediaQuery.of(context).size.height * 0.65,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.grey.shade300, width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          currentImage,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(top: BorderSide(color: Colors.black, width: 1)),
                      ),
                      child: Center(
                        child: Text(
                          currentAnimal.toUpperCase(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            color: Color(0xFF8E6CD0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Navigation and Audio Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        currentIndex = (currentIndex - 1 + animals.length) % animals.length;
                      });
                    },
                    icon: Icon(Icons.arrow_back),
                    iconSize: 50,
                    color: Colors.blueGrey.shade700,
                  ),
                  SizedBox(width: 20),
                  IconButton(
                    onPressed: () => playAudio(currentAudio),
                    icon: Icon(Icons.play_circle),
                    iconSize: 60,
                    color: Colors.black,
                  ),
                  SizedBox(width: 20),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        currentIndex = (currentIndex + 1) % animals.length;
                      });
                    },
                    icon: Icon(Icons.arrow_forward),
                    iconSize: 50,
                    color: Colors.blueGrey.shade700,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}
