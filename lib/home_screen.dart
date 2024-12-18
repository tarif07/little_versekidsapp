import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../alphabets/alphabets_screen.dart';
import '../numbers/numbers_screen.dart';
import '../animals/animals_screen.dart';
import '../birds/birds_screen.dart';
import '../quiz/quiz_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  String searchQuery = "";
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Screens for Bottom Navigation Bar
  static List<Widget> _pages = [
    HomeContent(),
    SettingsScreen(),
    HelpScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _logOut() async {
    await _auth.signOut();
    Navigator.of(context).pushReplacementNamed('/login');
  }

  // Search Filter Logic
  void _updateSearchQuery(String query) {
    setState(() {
      searchQuery = query;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: [Colors.teal, Colors.purple],
          ).createShader(bounds),
          child: Text(
            'LittleVerse',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu, color: Colors.black),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.teal),
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: Icon(Icons.info_outline, color: Colors.teal),
              title: Text('About'),
              onTap: () {
                showAboutDialog(
                  context: context,
                  applicationName: 'LittleVerse',
                  applicationVersion: '1.0.0',
                  applicationLegalese: 'Developed by Tarif and Maria',
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: Text(
                        'LittleVerse is an interactive educational app designed to make learning fun and engaging for kids.',
                      ),
                    ),
                  ],
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.logout, color: Colors.red),
              title: Text('Log Out'),
              onTap: _logOut,
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: _updateSearchQuery,
              decoration: InputDecoration(
                hintText: "Search...",
                prefixIcon: Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: _selectedIndex == 0
                ? HomeContent(searchQuery: searchQuery)
                : _pages[_selectedIndex],
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.help),
            label: 'Help',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.teal,
        onTap: _onItemTapped,
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  final String searchQuery;
  HomeContent({this.searchQuery = ""});

  final List<Map<String, dynamic>> lessons = [
    {
      'title': 'Alphabets',
      'lessonNumber': 'LESSON-01',
      'color': Color(0xFF8E6CD0),
      'imagePath': 'assets/home/d.png',
      'arrowPath': 'assets/home/arr1.png',
      'screen': AlphabetsScreen(),
    },
    {
      'title': 'Numbers',
      'lessonNumber': 'LESSON-02',
      'color': Color(0xFFF4B400),
      'imagePath': 'assets/home/dsc.jpeg',
      'arrowPath': 'assets/home/arrB.png',
      'screen': NumbersScreen(),
    },
    {
      'title': 'Animals',
      'lessonNumber': 'LESSON-03',
      'color': Color(0xFF77C1E9),
      'imagePath': 'assets/home/animal.png',
      'arrowPath': 'assets/home/arrY.png',
      'screen': AnimalsScreen(),
    },
    {
      'title': 'Birds',
      'lessonNumber': 'LESSON-04',
      'color': Color(0xFFF75656),
      'imagePath': 'assets/home/red.jpeg',
      'arrowPath': 'assets/home/arrR.png',
      'screen': BirdsScreen(),
    },
    {
      'title': 'Quiz',
      'lessonNumber': 'TAKE A QUIZ',
      'color': Color(0xFF4CAF50),
      'imagePath': 'assets/home/quiz.png',
      'arrowPath': 'assets/home/arrG.png',
      'screen': QuizScreen(),
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filteredLessons = lessons.where((lesson) {
      return lesson['title'].toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();

    return SingleChildScrollView(
      child: Column(
        children: filteredLessons.map((lesson) {
          return LessonCard(
            title: lesson['title'],
            lessonNumber: lesson['lessonNumber'],
            color: lesson['color'],
            imagePath: lesson['imagePath'],
            arrowPath: lesson['arrowPath'],
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => lesson['screen']),
              );
            },
          );
        }).toList(),
      ),
    );
  }
}

class LessonCard extends StatelessWidget {
  final String title;
  final String lessonNumber;
  final Color color;
  final String imagePath;
  final String arrowPath;
  final VoidCallback onTap;

  LessonCard({
    required this.title,
    required this.lessonNumber,
    required this.color,
    required this.imagePath,
    required this.arrowPath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        height: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            colors: [color.withOpacity(0.9), color.withOpacity(0.6)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                bottomLeft: Radius.circular(15),
              ),
              child: Image.asset(imagePath, width: 120, fit: BoxFit.cover),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(lessonNumber, style: TextStyle(color: Colors.white70, fontSize: 12)),
                    Text(title, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
                  ],
                ),
              ),
            ),
            Padding(padding: const EdgeInsets.all(12.0), child: Image.asset(arrowPath, width: 30)),
          ],
        ),
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Settings: Manage Profile, Reset Password'));
  }
}

class HelpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Help: Contact us at helplittleverse@gmail.com'));
  }
}
