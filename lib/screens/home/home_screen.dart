
import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Assalamu Alaikum',
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
            ),
            Text(
              'Welcome to your Quran journey',
              style: TextStyle(fontSize: 12, color: AppTheme.textMuted),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () => _showMessage(
              context,
              'Notifications will be available in a future update.',
            ),
            icon: const Icon(Icons.notifications_none_rounded),
            tooltip: 'Notifications',
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildWelcomeCard(context),
            const SizedBox(height: 26),
            _buildSectionTitle('Continue Reading', 'Your last session'),
            const SizedBox(height: 12),
            _buildContinueReadingCard(context),
            const SizedBox(height: 26),
            _buildSectionTitle('Daily Ayah', 'A reminder for today'),
            const SizedBox(height: 12),
            _buildDailyAyahCard(),
            const SizedBox(height: 26),
            _buildSectionTitle('Explore Learning', 'Start learning today'),
            const SizedBox(height: 12),
            _buildLearningOptions(context),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: AppTheme.forestGreen,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.auto_stories_rounded,
            color: AppTheme.softGold,
            size: 36,
          ),
          const SizedBox(height: 16),
          const Text(
            'Connect your heart\nwith the Quran',
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              height: 1.35,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Read, learn, and build a consistent Quran habit.',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 20),
          FilledButton(
            onPressed: () => _showMessage(
              context,
              'Your Quran reading journey starts here.',
            ),
            style: FilledButton.styleFrom(
              backgroundColor: AppTheme.softGold,
              foregroundColor: AppTheme.forestGreen,
            ),
            child: const Text('Begin Your Journey'),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.bold,
            color: AppTheme.textDark,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: const TextStyle(
            fontSize: 13,
            color: AppTheme.textMuted,
          ),
        ),
      ],
    );
  }

  Widget _buildContinueReadingCard(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppTheme.warmCream,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Icon(
                    Icons.menu_book_rounded,
                    color: AppTheme.forestGreen,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Surah Al-Baqarah',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Continue from Ayah 255',
                        style: TextStyle(
                          color: AppTheme.textMuted,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Reading progress'),
                Text(
                  '38%',
                  style: TextStyle(
                    color: AppTheme.forestGreen,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: const LinearProgressIndicator(
                value: 0.38,
                minHeight: 7,
                backgroundColor: AppTheme.warmCream,
                color: AppTheme.forestGreen,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: () => _showMessage(
                  context,
                  'The Quran reading screen is coming next.',
                ),
                icon: const Icon(Icons.play_arrow_rounded),
                label: const Text('Resume Reading'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDailyAyahCard() {
    return Card(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppTheme.softGold.withValues(alpha: 0.7)),
        ),
        child: const Column(
          children: [
            Icon(
              Icons.format_quote_rounded,
              color: AppTheme.softGold,
              size: 30,
            ),
            SizedBox(height: 10),
            Text(
              'فَإِنَّ مَعَ الْعُسْرِ يُسْرًا',
              textAlign: TextAlign.center,
              textDirection: TextDirection.rtl,
              style: TextStyle(
                fontSize: 27,
                height: 1.8,
                color: AppTheme.forestGreen,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 12),
            Text(
              '“For indeed, with hardship comes ease.”',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                height: 1.6,
                color: AppTheme.textDark,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Surah Ash-Sharh · 94:5',
              style: TextStyle(
                color: AppTheme.textMuted,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLearningOptions(BuildContext context) {
    return Column(
      children: [
        _buildLearningTile(
          context,
          icon: Icons.menu_book_rounded,
          title: 'Quran Reading',
          subtitle: 'Read Surahs and their translations',
        ),
        const SizedBox(height: 10),
        _buildLearningTile(
          context,
          icon: Icons.record_voice_over_rounded,
          title: 'Learn Tajweed',
          subtitle: 'Improve your Quran recitation',
        ),
        const SizedBox(height: 10),
        _buildLearningTile(
          context,
          icon: Icons.school_rounded,
          title: 'Madani Qaida',
          subtitle: 'Build your Arabic reading foundation',
        ),
      ],
    );
  }

  Widget _buildLearningTile(
      BuildContext context, {
        required IconData icon,
        required String title,
        required String subtitle,
      }) {
    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 6,
        ),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppTheme.warmCream,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: AppTheme.forestGreen),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(fontSize: 12),
        ),
        trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
        onTap: () => _showMessage(
          context,
          '$title will be connected to its screen soon.',
        ),
      ),
    );
  }
}
