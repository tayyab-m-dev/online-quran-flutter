import 'package:flutter/material.dart';
import '../../widgets/progress_card.dart';
import '../../widgets/section_title.dart';

class ProfileScreen extends StatelessWidget {
  final String studentName;
  final String email;

  const ProfileScreen({
    super.key,
    this.studentName = 'Quran Student',
    this.email = 'Keep learning, one verse at a time',
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appCream,
      appBar: AppBar(
        backgroundColor: appCream,
        foregroundColor: appInk,
        elevation: 0,
        title: const Text(
          'My Profile',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 760),
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                _buildProfileHeader(context),
                const SizedBox(height: 28),
                const SectionTitle(
                  title: 'Your learning journey',
                  subtitle: 'Every small step brings you closer.',
                ),
                const SizedBox(height: 14),
                const ProgressCard(
                  title: 'Overall progress',
                  subtitle: 'Keep your daily Quran learning consistent.',
                  progress: 0.65,
                  icon: Icons.auto_stories_rounded,
                ),
                const SizedBox(height: 24),
                const SectionTitle(title: 'Learning overview'),
                const SizedBox(height: 14),
                const Row(
                  children: [
                    Expanded(
                      child: _StatCard(
                        icon: Icons.menu_book_rounded,
                        value: '2',
                        label: 'Courses',
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: _StatCard(
                        icon: Icons.check_circle_outline_rounded,
                        value: '12',
                        label: 'Lessons done',
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: _StatCard(
                        icon: Icons.local_fire_department_rounded,
                        value: '5 days',
                        label: 'Learning streak',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                _buildReminderCard(),
                const SizedBox(height: 24),
                const Center(
                  child: Text(
                    'May your journey with the Quran be full of barakah.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: appMuted,
                      fontSize: 13,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: appEmerald,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          Container(
            width: 82,
            height: 82,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.14),
              shape: BoxShape.circle,
              border: Border.all(
                color: appGold,
                width: 2,
              ),
            ),
            child: const Icon(
              Icons.person_rounded,
              color: Colors.white,
              size: 44,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            studentName,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            email,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.8),
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 18),
          OutlinedButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Profile editing will be available soon.'),
                ),
              );
            },
            icon: const Icon(Icons.edit_outlined, size: 18),
            label: const Text('Edit profile'),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
              side: BorderSide(
                color: Colors.white.withValues(alpha: 0.65),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 12,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReminderCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF4D9),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: appGold.withValues(alpha: 0.6)),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.wb_twilight_rounded,
            color: appEmerald,
            size: 28,
          ),
          SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'A little learning every day',
                  style: TextStyle(
                    color: appInk,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Set aside a few quiet minutes today to read, listen, '
                      'and reflect.',
                  style: TextStyle(
                    color: appMuted,
                    fontSize: 13,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const _StatCard({
    required this.icon,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 120),
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 16,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFEAE8DF)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: appEmerald, size: 25),
          const SizedBox(height: 10),
          Text(
            value,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: appInk,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: appMuted,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}