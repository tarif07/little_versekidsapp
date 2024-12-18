import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class AlphabetsScreen extends StatefulWidget {
  @override
  _AlphabetsScreenState createState() => _AlphabetsScreenState();
}

class _AlphabetsScreenState extends State<AlphabetsScreen> {
  final List<String> letters = [
    'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O',
    'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'
  ];

  final Map<String, List<String>> images = {
    'A': ['assets/foralpha/ant.png', 'assets/foralpha/apple.png'],
    'B': ['assets/foralpha/ball.png', 'assets/foralpha/boy.png'],
    'C': ['assets/foralpha/cake.png', 'assets/foralpha/cat.png'],
    'D': ['assets/foralpha/dog.png', 'assets/foralpha/duck.png'],
    'E': ['assets/foralpha/elephant.png', 'assets/foralpha/egg.png'],
    'F': ['assets/foralpha/frog.png', 'assets/foralpha/fish.png'],
    'G': ['assets/foralpha/goat.png', 'assets/foralpha/grapes.png'],
    'H': ['assets/foralpha/hat.png', 'assets/foralpha/house.png'],
    'I': ['assets/foralpha/iceCream.png', 'assets/foralpha/iron.png'],
    'J': ['assets/foralpha/joker.png', 'assets/foralpha/juice.png'],
    'K': ['assets/foralpha/kangaroo.png', 'assets/foralpha/key.png'],
    'L': ['assets/foralpha/leaf.png', 'assets/foralpha/lion.png'],
    'M': ['assets/foralpha/monkey.png', 'assets/foralpha/mouse.png'],
    'N': ['assets/foralpha/nest.png', 'assets/foralpha/newspaper.png'],
    'O': ['assets/foralpha/octopus.png', 'assets/foralpha/owl.png'],
    'P': ['assets/foralpha/parrot.png', 'assets/foralpha/pig.png'],
    'Q': ['assets/foralpha/question.png', 'assets/foralpha/quill.png'],
    'R': ['assets/foralpha/rocket.png', 'assets/foralpha/rose.png'],
    'S': ['assets/foralpha/sun.png', 'assets/foralpha/sunflower.png'],
    'T': ['assets/foralpha/tiger.png', 'assets/foralpha/truck.png'],
    'U': ['assets/foralpha/umbrella.png', 'assets/foralpha/uniform.png'],
    'V': ['assets/foralpha/violin.png', 'assets/foralpha/volcano.png'],
    'W': ['assets/foralpha/watermelon.png', 'assets/foralpha/well.png'],
    'X': ['assets/foralpha/xray.png', 'assets/foralpha/xmasTree.png'],
    'Y': ['assets/foralpha/yak.png', 'assets/foralpha/yolk.png'],
    'Z': ['assets/foralpha/zebra.png', 'assets/foralpha/zoo.png'],
    // Add other images...
  };

  final Map<String, List<String>> audioPaths = {
    'A': ['audio/alphabets/a.mp3', 'audio/for/ant.mp3', 'audio/for/apple.mp3'],
    'B': ['audio/alphabets/b.mp3', 'audio/for/ball.mp3', 'audio/for/boy.mp3'],
    'C': ['audio/alphabets/c.mp3', 'audio/for/cake.mp3', 'audio/for/cat.mp3'],
    'D': ['audio/alphabets/d.mp3', 'audio/for/dog.mp3', 'audio/for/duck.mp3'],
    'E': ['audio/alphabets/e.mp3', 'audio/for/elephant.mp3', 'audio/for/egg.mp3'],
    'F': ['audio/alphabets/f.mp3', 'audio/for/frog.mp3', 'audio/for/fish.mp3'],
    'G': ['audio/alphabets/g.mp3', 'audio/for/goat.mp3', 'audio/for/grapes.mp3'],
    'H': ['audio/alphabets/h.mp3', 'audio/for/hat.mp3', 'audio/for/house.mp3'],
    'I': ['audio/alphabets/i.mp3', 'audio/for/iceCream.mp3', 'audio/for/iron.mp3'],
    'J': ['audio/alphabets/j.mp3', 'audio/for/joker.mp3', 'audio/for/juice.mp3'],
    'K': ['audio/alphabets/k.mp3', 'audio/for/kangaroo.mp3', 'audio/for/key.mp3'],
    'L': ['audio/alphabets/l.mp3', 'audio/for/leaf.mp3', 'audio/for/lion.mp3'],
    'M': ['audio/alphabets/m.mp3', 'audio/for/monkey.mp3', 'audio/for/mouse.mp3'],
    'N': ['audio/alphabets/n.mp3', 'audio/for/nest.mp3', 'audio/for/newspaper.mp3'],
    'O': ['audio/alphabets/o.mp3', 'audio/for/octopus.mp3', 'audio/for/owl.mp3'],
    'P': ['audio/alphabets/p.mp3', 'audio/for/parrot.mp3', 'audio/for/pig.mp3'],
    'Q': ['audio/alphabets/q.mp3', 'audio/for/question.mp3', 'audio/for/quill.mp3'],
    'R': ['audio/alphabets/r.mp3', 'audio/for/rocket.mp3', 'audio/for/rose.mp3'],
    'S': ['audio/alphabets/s.mp3', 'audio/for/sun.mp3', 'audio/for/sunflower.mp3'],
    'T': ['audio/alphabets/t.mp3', 'audio/for/tiger.mp3', 'audio/for/truck.mp3'],
    'U': ['audio/alphabets/u.mp3', 'audio/for/umbrella.mp3', 'audio/for/uniform.mp3'],
    'V': ['audio/alphabets/v.mp3', 'audio/for/violin.mp3', 'audio/for/volcano.mp3'],
    'W': ['audio/alphabets/w.mp3', 'audio/for/watermelon.mp3', 'audio/for/well.mp3'],
    'X': ['audio/alphabets/x.mp3', 'audio/for/xray.mp3', 'audio/for/xmasTree.mp3'],
    'Y': ['audio/alphabets/y.mp3', 'audio/for/yak.mp3', 'audio/for/yolk.mp3'],
    'Z': ['audio/alphabets/z.mp3', 'audio/for/zebra.mp3', 'audio/for/zoo.mp3'],
    // Add other audio paths...
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
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String currentLetter = letters[currentIndex];
    List<String> currentImages = images[currentLetter]!;
    List<String> currentAudioPaths = audioPaths[currentLetter]!;

    return Scaffold(
      appBar: AppBar(
        title: Text('Alphabets'),
        backgroundColor: Color(0xFF8E6CD0),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Letter Card
            Expanded(
              flex: 2,
              child: GestureDetector(
                onTap: () => playAudio(currentAudioPaths[0]),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0xFF8E6CD0),
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
                    child: Text(
                      currentLetter,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 120,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            blurRadius: 4.0,
                            color: Colors.black38,
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            // Images Row
            Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () => playAudio(currentAudioPaths[1]),
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.black, width: 1),
                        image: DecorationImage(
                          image: AssetImage(currentImages[0]),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => playAudio(currentAudioPaths[2]),
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.black, width: 1),
                        image: DecorationImage(
                          image: AssetImage(currentImages[1]),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ],
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
                      currentIndex = (currentIndex - 1 + letters.length) % letters.length;
                    });
                  },
                  icon: Icon(Icons.arrow_back),
                  iconSize: 45,
                  color: Colors.blueGrey.shade700,
                ),
                IconButton(
                  onPressed: () => playAudio(currentAudioPaths[0]),
                  icon: Icon(Icons.play_circle),
                  iconSize: 50,
                  color: Colors.black,
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      currentIndex = (currentIndex + 1) % letters.length;
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
