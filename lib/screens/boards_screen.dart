import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';

class BoardsScreen extends StatelessWidget {
  const BoardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);

    // Updated data: add illustration paths + colors for section backgrounds
    final boards = [
      {
        'name': 'Games',
        'image': 'assets/images/games.png',
        'start': const Color(0xFFFF6B6B),
        'end': const Color(0xFFFF8E8E),
      },
      {
        'name': 'Business',
        'image': 'assets/images/business.png',
        'start': const Color(0xFF4ECDC4),
        'end': const Color(0xFF6EE7D4),
      },
      {
        'name': 'Public Health',
        'image': 'assets/images/health.png',
        'start': const Color(0xFFF38BA0),
        'end': const Color(0xFFFFB6C1),
      },
      {
        'name': 'Study',
        'image': 'assets/images/study.png',
        'start': const Color(0xFF9B59B6),
        'end': const Color(0xFFC39BD3),
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Select A Room',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
      ),

      drawer: _buildDrawer(authService),

      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: boards.length,
        itemBuilder: (context, index) =>
            _buildBoardBanner(context, boards[index]),
      ),
    );
  }

  // -------------------------------
  // Illustration-style Banner
  // -------------------------------

  Widget _buildBoardBanner(BuildContext context, Map<String, dynamic> board) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, '/chat/${board['name']}'),
      child: Container(
        height: 230,
        margin: const EdgeInsets.only(bottom: 22),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(26),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              board['start'],
              board['end'],
            ],
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(26),
          child: Stack(
            children: [
              // Illustration image (fills container)
              Positioned.fill(
                child: Image.asset(
                  board['image'],
                  fit: BoxFit.cover,
                ),
              ),

              // Gradient overlay for text visibility
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withValues(alpha: 0.55),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),

              // Category title
              Positioned(
                left: 20,
                bottom: 22,
                child: Text(
                  board['name'],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 34,
                    fontWeight: FontWeight.w800,
                    shadows: [
                      Shadow(
                        color: Colors.black45,
                        offset: Offset(0, 3),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // -------------------------------
  // Drawer (unchanged except style)
  // -------------------------------
  Widget _buildDrawer(AuthService authService) {
    return Builder(
      builder: (context) {
        return _buildDrawerContent(context, authService);
      },
    );
  }

  Widget _buildDrawerContent(BuildContext context, AuthService authService) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF88BDF2), Color(0xFF6A89A7)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Icon(Icons.chat_bubble_outline,
                    size: 50, color: Colors.white),
                const SizedBox(height: 10),
                const Text(
                  'Message Board',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                FutureBuilder(
                  future: authService.getUserData(authService.currentUser!.uid),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Text(
                        snapshot.data!.effectiveDisplayName,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.forum),
            title: const Text('Message Boards'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profile'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/profile');
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/settings');
            },
          ),
        ],
      ),
    );
  }
}
