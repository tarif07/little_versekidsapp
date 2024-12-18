import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class BirdsScreen extends StatefulWidget {
  @override
  _BirdsScreenState createState() => _BirdsScreenState();
}

class _BirdsScreenState extends State<BirdsScreen> {
  // List of birds
  final List<String> birds = [
    'Duck',
    'Hen',
    'Owl',
    'Parrot',
    'Peacock',
    'Penguin',
    'Sparrow'
  ];

  // Map for images and audio paths
  final Map<String, String> images = {
    'Duck': 'assets/birds/duck.png',
    'Hen': 'assets/birds/hen.png',
    'Owl': 'assets/birds/owl.png',
    'Parrot': 'assets/birds/parrot.png',
    'Peacock': 'assets/birds/peacock.png',
    'Penguin': 'assets/birds/penguin.png',
    'Sparrow': 'assets/birds/sparrow.png',
  };

  final Map<String, String> audioPaths = {
    'Duck': 'audio/birds/duck.mp3',
    'Hen': 'audio/birds/hen.mp3',
    'Owl': 'audio/birds/owl.mp3',
    'Parrot': 'audio/birds/parrot.mp3',
    'Peacock': 'audio/birds/peacock.mp3',
    'Penguin': 'audio/birds/penguin.mp3',
    'Sparrow': 'audio/birds/sparrow.mp3',
  };

  int currentIndex = 0;
  final AudioPlayer _audioPlayer = AudioPlayer();

  // Play audio function
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
    String currentBird = birds[currentIndex];
    String currentImage = images[currentBird]!;
    String currentAudio = audioPaths[currentBird]!;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Birds',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color(0xFF8E6CD0), // Purple background
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Bird Image Container (Bigger Size)
              Container(
                height: MediaQuery.of(context).size.height * 0.6, // 60% of screen height
                width: double.infinity, // Full width
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
                    // Bird Name at Bottom
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(top: BorderSide(color: Colors.black, width: 1)),
                      ),
                      child: Center(
                        child: Text(
                          currentBird.toUpperCase(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            color: Color(0xFF8E6CD0), // Purple text color
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Audio and Navigation Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        currentIndex = (currentIndex - 1 + birds.length) % birds.length;
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
                        currentIndex = (currentIndex + 1) % birds.length;
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
