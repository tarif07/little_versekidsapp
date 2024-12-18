import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class NumbersScreen extends StatefulWidget {
  @override
  _NumbersScreenState createState() => _NumbersScreenState();
}

class _NumbersScreenState extends State<NumbersScreen> {
  // List of numbers
  final List<String> numbers = ['1', '2', '3', '4', '5', '6', '7', '8', '9'];

  // Number images
  final Map<String, String> images = {
    '1': 'assets/number/one.png',
    '2': 'assets/number/two.png',
    '3': 'assets/number/three.png',
    '4': 'assets/number/four.png',
    '5': 'assets/number/five.png',
    '6': 'assets/number/six.png',
    '7': 'assets/number/seven.png',
    '8': 'assets/number/eight.png',
    '9': 'assets/number/nine.png',
  };

  // Number audio paths
  final Map<String, String> audioPaths = {
    '1': 'audio/number/1.mp3',
    '2': 'audio/number/2.mp3',
    '3': 'audio/number/3.mp3',
    '4': 'audio/number/4.mp3',
    '5': 'audio/number/5.mp3',
    '6': 'audio/number/6.mp3',
    '7': 'audio/number/7.mp3',
    '8': 'audio/number/8.mp3',
    '9': 'audio/number/9.mp3',
  };

  int currentIndex = 0; // Current number index
  final AudioPlayer _audioPlayer = AudioPlayer();

  // Initialize the audio player
  @override
  void initState() {
    super.initState();
    _audioPlayer.setReleaseMode(ReleaseMode.stop); // Stop after playback
  }

  // Play audio function
  void playAudio(String path) async {
    try {
      await _audioPlayer.stop(); // Stop existing audio
      await _audioPlayer.setSource(AssetSource(path)); // Set new audio source
      await _audioPlayer.resume(); // Play the audio
    } catch (e) {
      print("Error playing audio: $e");
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String currentNumber = numbers[currentIndex];
    String currentImage = images[currentNumber]!;
    String currentAudioPath = audioPaths[currentNumber]!;

    return Scaffold(
      appBar: AppBar(
        title: Text('Numbers'),
        backgroundColor: Color(0xFF77C1E9),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Display number image
            Expanded(
              flex: 4,
              child: GestureDetector(
                onTap: () => playAudio(currentAudioPath),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0xFF77C1E9),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.black, width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Image.asset(
                      currentImage,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            // Navigation Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      currentIndex = (currentIndex - 1 + numbers.length) % numbers.length;
                    });
                  },
                  icon: Icon(Icons.arrow_back),
                  iconSize: 45,
                  color: Colors.blueGrey.shade700,
                ),
                IconButton(
                  onPressed: () => playAudio(currentAudioPath),
                  icon: Icon(Icons.play_circle),
                  iconSize: 50,
                  color: Colors.black,
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      currentIndex = (currentIndex + 1) % numbers.length;
                    });
                  },
                  icon: Icon(Icons.arrow_forward),
                  iconSize: 45,
                  color: Colors.blueGrey.shade700,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
