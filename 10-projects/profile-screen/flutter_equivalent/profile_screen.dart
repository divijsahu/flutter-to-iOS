import 'dart:ui';
import 'package:flutter/material.dart';

void main() => runApp(const ProfileApp());

class ProfileApp extends StatelessWidget {
  const ProfileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const ProfileScreen(),
      theme: ThemeData.dark(useMaterial3: true),
    );
  }
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isFollowing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 260,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: _buildHeader(),
            ),
          ),
          SliverToBoxAdapter(child: _buildStatsRow()),
          SliverToBoxAdapter(child: _buildBioSection()),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    // NOTE: Flutter cannot replicate Liquid Glass refraction.
    // BackdropFilter provides a static blur only.
    return Stack(
      fit: StackFit.expand,
      children: [
        // Static gradient (MeshGradient not available in Flutter)
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF0A84FF), Color(0xFF5E5CE6), Color(0xFF64D2FF)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                color: Colors.black.withOpacity(0.15),
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 36,
                      backgroundImage: NetworkImage(
                        'https://i.pravatar.cc/150?img=8',
                      ),
                    ),
                    const SizedBox(width: 14),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Alex Chen',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)),
                          Text('@alexchen_dev',
                              style: TextStyle(color: Colors.white70, fontSize: 13)),
                        ],
                      ),
                    ),
                    OutlinedButton(
                      onPressed: () => setState(() => _isFollowing = !_isFollowing),
                      style: OutlinedButton.styleFrom(foregroundColor: Colors.white),
                      child: Text(_isFollowing ? 'Following' : 'Follow'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatsRow() {
    return Row(
      children: [
        for (final stat in [('256', 'Posts'), ('14.2K', 'Followers'), ('891', 'Following')])
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Column(
                children: [
                  Text(stat.$1,
                      style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                  Text(stat.$2,
                      style: const TextStyle(fontSize: 12, color: Colors.grey)),
                ],
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildBioSection() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Flutter dev turned iOS engineer. Building native apps that Liquid Glass can\'t reach.',
          ),
          const SizedBox(height: 8),
          const Row(
            children: [
              Icon(Icons.location_on, size: 14, color: Colors.grey),
              SizedBox(width: 4),
              Text('San Francisco, CA',
                  style: TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.link, size: 14, color: Colors.blue),
              const SizedBox(width: 4),
              Text('github.com/flutter-to-ios',
                  style: TextStyle(fontSize: 12, color: Colors.blue[300])),
            ],
          ),
        ],
      ),
    );
  }
}
