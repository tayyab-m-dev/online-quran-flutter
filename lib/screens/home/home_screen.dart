
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    required this.onNavigate,
  });

  final ValueChanged<int> onNavigate;

  void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isDesktop = constraints.maxWidth >= 768;

        return Scaffold(
          backgroundColor: const Color(0xFFF7F2E7),
          body: SafeArea(
            bottom: false,
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(
                isDesktop ? 40 : 20,
                16,
                isDesktop ? 40 : 20,
                24,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1120),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (isDesktop) ...[
                        _buildDesktopMenu(),
                        const SizedBox(height: 28),
                      ],
                      _buildHeader(context),
                      const SizedBox(height: 24),
                      _buildContinueReading(context),
                      const SizedBox(height: 20),
                      _buildDailyGoal(),
                      const SizedBox(height: 20),
                      _buildAyahCard(context),
                      const SizedBox(height: 24),
                      const Text(
                        'Keep learning',
                        style: TextStyle(
                          color: Color(0xFF1C2B26),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 14),
                      LayoutBuilder(
                        builder: (context, learningConstraints) {
                          final bool sideBySide =
                              learningConstraints.maxWidth >= 520;

                          if (!sideBySide) {
                            return Column(
                              children: [
                                _learningCard(
                                  icon: Icons.graphic_eq_rounded,
                                  title: 'Tajweed',
                                  subtitle: 'Lesson 4 of 12',
                                  progress: 4 / 12,
                                ),
                                const SizedBox(height: 12),
                                _learningCard(
                                  icon: Icons.school_rounded,
                                  title: 'Madani Qaida',
                                  subtitle: 'Lesson 9 of 20',
                                  progress: 9 / 20,
                                ),
                              ],
                            );
                          }

                          return Row(
                            children: [
                              Expanded(
                                child: _learningCard(
                                  icon: Icons.graphic_eq_rounded,
                                  title: 'Tajweed',
                                  subtitle: 'Lesson 4 of 12',
                                  progress: 4 / 12,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: _learningCard(
                                  icon: Icons.school_rounded,
                                  title: 'Madani Qaida',
                                  subtitle: 'Lesson 9 of 20',
                                  progress: 9 / 20,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // Desktop navigation connected to the shared navigation state.
  Widget _buildDesktopMenu() {
    return Row(
      children: [
        const Icon(
          Icons.menu_book_rounded,
          color: Color(0xFF136B54),
          size: 32,
        ),
        const SizedBox(width: 10),
        const Text(
          'Online Quran',
          style: TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1B2B26),
          ),
        ),
        const Spacer(),
        _menuItem('Home', true, () => onNavigate(0)),
        _menuItem('Quran', false, () => onNavigate(1)),
        _menuItem('Courses', false, () => onNavigate(2)),
        _menuItem('Profile', false, () => onNavigate(3)),
        const SizedBox(width: 12),
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: const Color(0xFFEFE8D6),
            borderRadius: BorderRadius.circular(14),
          ),
          child: const Icon(
            Icons.person_rounded,
            color: Color(0xFF136B54),
          ),
        ),
      ],
    );
  }

  Widget _menuItem(
      String label,
      bool selected,
      VoidCallback onTap,
      ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      child: TextButton(
        onPressed: onTap,
        style: TextButton.styleFrom(
          foregroundColor: selected
              ? const Color(0xFF136B54)
              : const Color(0xFF5F6F69),
          backgroundColor: selected
              ? const Color(0xFFE5EDE6)
              : Colors.transparent,
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 12,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontWeight:
            selected ? FontWeight.bold : FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Assalamu alaikum',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF51635B),
                ),
              ),
              SizedBox(height: 3),
              Text(
                'Ahmed',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1C2B26),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 9,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFFEFE8D6),
            borderRadius: BorderRadius.circular(22),
          ),
          child: const Row(
            children: [
              Icon(
                Icons.local_fire_department_rounded,
                color: Color(0xFFE58A36),
                size: 21,
              ),
              SizedBox(width: 5),
              Text(
                '5',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1C2B26),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Stack(
          children: [
            IconButton(
              onPressed: () => _showMessage(
                context,
                'No new notifications yet.',
              ),
              icon: const Icon(
                Icons.notifications_none_rounded,
                color: Color(0xFF1C2B26),
                size: 27,
              ),
            ),
            Positioned(
              right: 8,
              top: 7,
              child: Container(
                width: 9,
                height: 9,
                decoration: const BoxDecoration(
                  color: Color(0xFFD94B45),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildContinueReading(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF0F3D33),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Continue reading',
            style: TextStyle(
              color: Color(0xFFB9D0C5),
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'البقرة',
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        fontSize: 43,
                        height: 1.5,
                        color: Color(0xFFFFFDF8),
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Surah Al-Baqarah',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFFFFDF8),
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Ayah 255 of 286',
                      style: TextStyle(
                        fontSize: 13,
                        color: Color(0xFFB9D0C5),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 76,
                height: 76,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 76,
                      height: 76,
                      child: CircularProgressIndicator(
                        value: 0.89,
                        strokeWidth: 6,
                        backgroundColor: Colors.white24,
                        valueColor:
                        const AlwaysStoppedAnimation<Color>(
                          Color(0xFFD9B45C),
                        ),
                      ),
                    ),
                    const Text(
                      '89%',
                      style: TextStyle(
                        color: Color(0xFFFFFDF8),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 22),
          SizedBox(
            width: double.infinity,
            height: 54,
            child: FilledButton.icon(
              onPressed: () => onNavigate(1),
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFFD9B45C),
                foregroundColor: const Color(0xFF0F3D33),
                shape: const StadiumBorder(),
              ),
              icon: const Icon(Icons.play_arrow_rounded),
              label: const Text(
                'Resume from ayah 255',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDailyGoal() {
    const days = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];

    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Today's goal",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '6 of 10 min',
                style: TextStyle(
                  color: Color(0xFF51635B),
                  fontSize: 13,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: const LinearProgressIndicator(
              value: 0.6,
              minHeight: 8,
              backgroundColor: Color(0xFFEFE8D6),
              valueColor: AlwaysStoppedAnimation<Color>(
                Color(0xFF1B5E4B),
              ),
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            '4 more min keeps your 5-day streak.',
            style: TextStyle(
              color: Color(0xFF51635B),
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(7, (index) {
              final completed = index < 4;
              final today = index == 4;

              return Column(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: completed
                          ? const Color(0xFF1B5E4B)
                          : Colors.transparent,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: completed || today
                            ? const Color(0xFF1B5E4B)
                            : const Color(0xFFDDD3BC),
                        width: today ? 2 : 1,
                      ),
                    ),
                    child: Icon(
                      completed ? Icons.check_rounded : null,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    days[index],
                    style: const TextStyle(
                      color: Color(0xFF51635B),
                      fontSize: 12,
                    ),
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildAyahCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFDF8),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFD9B45C)),
      ),
      child: Column(
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Ayah of the day',
              style: TextStyle(
                color: Color(0xFF51635B),
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'فَإِنَّ مَعَ الْعُسْرِ يُسْرًا',
            textAlign: TextAlign.center,
            textDirection: TextDirection.rtl,
            style: TextStyle(
              fontSize: 29,
              height: 1.8,
              color: Color(0xFF1B5E4B),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'For indeed, with hardship comes ease.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF1C2B26),
            ),
          ),
          const SizedBox(height: 7),
          const Text(
            'Surah Ash-Sharh, 94:5',
            style: TextStyle(
              fontSize: 12,
              color: Color(0xFF51635B),
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              _roundAction(
                context,
                Icons.volume_up_outlined,
                'Audio',
              ),
              _roundAction(
                context,
                Icons.bookmark_border_rounded,
                'Bookmark',
              ),
              _roundAction(
                context,
                Icons.share_outlined,
                'Share',
              ),
              TextButton(
                onPressed: () => onNavigate(1),
                child: const Text('Read in context'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _roundAction(
      BuildContext context,
      IconData icon,
      String label,
      ) {
    return Tooltip(
      message: label,
      child: InkWell(
        borderRadius: BorderRadius.circular(30),
        onTap: () => _showMessage(
          context,
          '$label will be available soon.',
        ),
        child: Container(
          width: 38,
          height: 38,
          decoration: const BoxDecoration(
            color: Color(0xFFEFE8D6),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            size: 19,
            color: const Color(0xFF1B5E4B),
          ),
        ),
      ),
    );
  }

  Widget _learningCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required double progress,
  }) {
    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: const BoxDecoration(
              color: Color(0xFFEFE8D6),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: const Color(0xFF1B5E4B)),
          ),
          const SizedBox(height: 14),
          Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1C2B26),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF51635B),
            ),
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 5,
              backgroundColor: const Color(0xFFEFE8D6),
              valueColor: const AlwaysStoppedAnimation<Color>(
                Color(0xFF1B5E4B),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _card({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFDF8),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFFDDD3BC)),
      ),
      child: child,
    );
  }
}
