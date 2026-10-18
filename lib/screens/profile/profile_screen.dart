
import 'package:flutter/material.dart';
import '../auth/login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    super.key,
    required this.onNavigate,
    this.studentName = 'Muhammad Tayyab',
    this.email = 'student@example.com',
  });

  final ValueChanged<int> onNavigate;
  final String studentName;
  final String email;

  static const Color _cream = Color(0xFFF8F6EF);
  static const Color _emerald = Color(0xFF174D3A);
  static const Color _darkGreen = Color(0xFF103729);
  static const Color _gold = Color(0xFFC5A45D);
  static const Color _ink = Color(0xFF252923);
  static const Color _muted = Color(0xFF777C73);
  static const Color _border = Color(0xFFE8E2D3);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isDesktop = constraints.maxWidth >= 768;
        final double horizontalPadding =
        constraints.maxWidth >= 1100 ? 48 : 20;

        return Scaffold(
          backgroundColor: _cream,
          appBar: isDesktop
              ? null
              : AppBar(
            backgroundColor: _cream,
            elevation: 0,
            title: const Text(
              'My Profile',
              style: TextStyle(
                color: _darkGreen,
                fontWeight: FontWeight.bold,
              ),
            ),
            iconTheme: const IconThemeData(color: _darkGreen),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1200),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: horizontalPadding,
                      vertical: isDesktop ? 24 : 12,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (isDesktop) ...[
                          _buildDesktopMenu(),
                          const SizedBox(height: 28),
                        ],
                        _buildPageHeading(context, isDesktop),
                        const SizedBox(height: 24),
                        _buildProfileBanner(
                          context,
                          isDesktop: isDesktop,
                        ),
                        const SizedBox(height: 32),
                        _buildSectionHeading(
                          'Learning Overview',
                          'Your Quran learning journey at a glance',
                        ),
                        const SizedBox(height: 16),
                        _buildStatistics(context),
                        const SizedBox(height: 32),
                        _buildSectionHeading(
                          'Learning Progress',
                          'Keep building a consistent learning habit',
                        ),
                        const SizedBox(height: 16),
                        _buildProgressCard(),
                        const SizedBox(height: 24),
                        _buildReminderCard(),
                        const SizedBox(height: 32),
                        _buildFooter(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // ------------------------------------------------------------
  // Logout
  // ------------------------------------------------------------

  Future<void> _confirmLogout(BuildContext context) async {
    final bool? shouldLogout = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: _cream,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        icon: const Icon(
          Icons.logout_rounded,
          color: _emerald,
          size: 32,
        ),
        title: const Text(
          'Logout?',
          style: TextStyle(
            color: _darkGreen,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: const Text(
          'Are you sure you want to log out of your account?',
          textAlign: TextAlign.center,
          style: TextStyle(color: _muted),
        ),
        actionsAlignment: MainAxisAlignment.spaceEvenly,
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text(
              'Cancel',
              style: TextStyle(color: _muted),
            ),
          ),
          FilledButton.icon(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            style: FilledButton.styleFrom(
              backgroundColor: _emerald,
              foregroundColor: Colors.white,
            ),
            icon: const Icon(Icons.logout_rounded, size: 18),
            label: const Text('Logout'),
          ),
        ],
      ),
    );

    if (shouldLogout != true || !context.mounted) return;

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute<void>(
        builder: (_) => const LoginScreen(),
      ),
          (route) => false,
    );
  }

  // ------------------------------------------------------------
  // Desktop navigation
  // ------------------------------------------------------------

  Widget _buildDesktopMenu() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 22,
        vertical: 16,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: _border),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: _emerald,
              borderRadius: BorderRadius.circular(13),
            ),
            child: const Icon(
              Icons.menu_book_rounded,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Text(
              'Online Quran System',
              style: TextStyle(
                color: _darkGreen,
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          _desktopMenuItem('Home', 0),
          _desktopMenuItem('Quran', 1),
          _desktopMenuItem('Courses', 2),
          _desktopMenuItem('Profile', 3),
        ],
      ),
    );
  }

  Widget _desktopMenuItem(String label, int index) {
    final bool isSelected = index == 3;

    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: TextButton(
        onPressed: () => onNavigate(index),
        style: TextButton.styleFrom(
          backgroundColor:
          isSelected ? _emerald.withValues(alpha: 0.09) : Colors.transparent,
          foregroundColor: isSelected ? _emerald : _muted,
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
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
            isSelected ? FontWeight.bold : FontWeight.w500,
          ),
        ),
      ),
    );
  }

  // ------------------------------------------------------------
  // Page heading
  // ------------------------------------------------------------

  Widget _buildPageHeading(BuildContext context, bool isDesktop) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'My Profile',
                style: TextStyle(
                  fontSize: isDesktop ? 30 : 26,
                  fontWeight: FontWeight.bold,
                  color: _darkGreen,
                  letterSpacing: -0.6,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Manage your account and track your progress.',
                style: TextStyle(
                  color: _muted,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        if (isDesktop)
          OutlinedButton.icon(
            onPressed: () => _confirmLogout(context),
            icon: const Icon(Icons.logout_rounded, size: 18),
            label: const Text('Logout'),
            style: OutlinedButton.styleFrom(
              foregroundColor: _emerald,
              side: const BorderSide(color: _emerald),
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          )
        else
          IconButton.filledTonal(
            tooltip: 'Logout',
            onPressed: () => _confirmLogout(context),
            style: IconButton.styleFrom(
              foregroundColor: _emerald,
              backgroundColor: Colors.white,
              side: const BorderSide(color: _border),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            icon: const Icon(Icons.logout_rounded),
          ),
      ],
    );
  }

  // ------------------------------------------------------------
  // Profile banner
  // ------------------------------------------------------------

  Widget _buildProfileBanner(
      BuildContext context, {
        required bool isDesktop,
      }) {
    final double bannerHeight = isDesktop ? 290 : 310;

    return Container(
      width: double.infinity,
      height: bannerHeight,
      decoration: BoxDecoration(
        color: _darkGreen,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: _darkGreen.withValues(alpha: 0.10),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/profile_mosque_banner.png',
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF28664E),
                      _darkGreen,
                      Color(0xFF0B2920),
                    ],
                  ),
                ),
                child: const Center(
                  child: Icon(
                    Icons.mosque_rounded,
                    size: 150,
                    color: Color(0x30FFFFFF),
                  ),
                ),
              );
            },
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  _darkGreen.withValues(alpha: 0.96),
                  _darkGreen.withValues(alpha: 0.78),
                  _darkGreen.withValues(alpha: 0.22),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(isDesktop ? 32 : 22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 7,
                  ),
                  decoration: BoxDecoration(
                    color: _gold.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: _gold.withValues(alpha: 0.6),
                    ),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.auto_awesome_rounded,
                        color: _gold,
                        size: 15,
                      ),
                      SizedBox(width: 7),
                      Text(
                        'YOUR QURAN JOURNEY',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Assalamu Alaikum,',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.85),
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  studentName,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isDesktop ? 30 : 25,
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 10),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 420),
                  child: Text(
                    'Every verse you learn is a step towards a stronger connection with the Quran.',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.86),
                      fontSize: 13,
                      height: 1.6,
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                Row(
                  children: [
                    const Icon(
                      Icons.email_outlined,
                      size: 16,
                      color: _gold,
                    ),
                    const SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        email,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ------------------------------------------------------------
  // Section heading
  // ------------------------------------------------------------

  Widget _buildSectionHeading(String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: _darkGreen,
            fontSize: 21,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          subtitle,
          style: const TextStyle(
            color: _muted,
            fontSize: 13,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  // ------------------------------------------------------------
  // Statistics
  // ------------------------------------------------------------

  Widget _buildStatistics(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final int columns = constraints.maxWidth >= 700
            ? 4
            : constraints.maxWidth >= 400
            ? 2
            : 1;

        final double spacing = 14;
        final double cardWidth =
            (constraints.maxWidth - spacing * (columns - 1)) / columns;

        final stats = [
          _StatData(
            title: 'Courses',
            value: '02',
            subtitle: 'Courses available',
            icon: Icons.school_outlined,
            color: _emerald,
          ),
          _StatData(
            title: 'Completed',
            value: '00',
            subtitle: 'Courses completed',
            icon: Icons.verified_outlined,
            color: const Color(0xFF99752C),
          ),
          _StatData(
            title: 'Learning',
            value: '01',
            subtitle: 'Learning goal',
            icon: Icons.menu_book_outlined,
            color: const Color(0xFF4778A8),
          ),
          _StatData(
            title: 'Streak',
            value: '00',
            subtitle: 'Day learning streak',
            icon: Icons.local_fire_department_outlined,
            color: const Color(0xFFB96A3C),
          ),
        ];

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: stats.map((stat) {
            return SizedBox(
              width: cardWidth,
              child: _StatCard(data: stat),
            );
          }).toList(),
        );
      },
    );
  }

  // ------------------------------------------------------------
  // Progress card
  // ------------------------------------------------------------

  Widget _buildProgressCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(11),
                decoration: BoxDecoration(
                  color: _emerald.withValues(alpha: 0.09),
                  borderRadius: BorderRadius.circular(13),
                ),
                child: const Icon(
                  Icons.trending_up_rounded,
                  color: _emerald,
                  size: 24,
                ),
              ),
              const SizedBox(width: 14),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Your learning progress',
                      style: TextStyle(
                        color: _ink,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Your progress will grow as you learn.',
                      style: TextStyle(
                        color: _muted,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              const Text(
                '0%',
                style: TextStyle(
                  color: _emerald,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ],
          ),
          const SizedBox(height: 22),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: const LinearProgressIndicator(
              value: 0,
              minHeight: 9,
              backgroundColor: Color(0xFFECEFE8),
              valueColor: AlwaysStoppedAnimation<Color>(_emerald),
            ),
          ),
          const SizedBox(height: 12),
          const Row(
            children: [
              Expanded(
                child: Text(
                  'Start learning to track your progress.',
                  style: TextStyle(
                    color: _muted,
                    fontSize: 12,
                  ),
                ),
              ),
              Icon(
                Icons.flag_outlined,
                color: _gold,
                size: 18,
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: () => onNavigate(2),
              style: FilledButton.styleFrom(
                backgroundColor: _emerald,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              icon: const Icon(Icons.school_outlined),
              label: const Text('Explore Courses'),
            ),
          ),
        ],
      ),
    );
  }

  // ------------------------------------------------------------
  // Daily reminder
  // ------------------------------------------------------------

  Widget _buildReminderCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: const Color(0xFFF1EBD9),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE5D8B8)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _gold.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.light_mode_outlined,
              color: _darkGreen,
              size: 25,
            ),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'A gentle reminder',
                  style: TextStyle(
                    color: _darkGreen,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Make time for the Quran every day, even if it is only a few verses. Consistency matters.',
                  style: TextStyle(
                    color: _ink,
                    fontSize: 13,
                    height: 1.6,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ------------------------------------------------------------
  // Footer
  // ------------------------------------------------------------

  Widget _buildFooter() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Column(
          children: [
            const Icon(
              Icons.menu_book_rounded,
              color: _emerald,
              size: 27,
            ),
            const SizedBox(height: 9),
            const Text(
              'Online Quran System',
              style: TextStyle(
                color: _darkGreen,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              'Learn with sincerity. Grow with consistency.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: _muted.withValues(alpha: 0.9),
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 18),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// Statistics model
// ============================================================

class _StatData {
  const _StatData({
    required this.title,
    required this.value,
    required this.subtitle,
    required this.icon,
    required this.color,
  });

  final String title;
  final String value;
  final String subtitle;
  final IconData icon;
  final Color color;
}

// ============================================================
// Statistics card
// ============================================================

class _StatCard extends StatelessWidget {
  const _StatCard({required this.data});

  final _StatData data;

  static const Color _border = Color(0xFFE8E2D3);
  static const Color _ink = Color(0xFF252923);
  static const Color _muted = Color(0xFF777C73);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(19),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: _border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: data.color.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  data.icon,
                  color: data.color,
                  size: 22,
                ),
              ),
              const Spacer(),
              Text(
                data.value,
                style: TextStyle(
                  color: data.color,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Text(
            data.title,
            style: const TextStyle(
              color: _ink,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            data.subtitle,
            style: const TextStyle(
              color: _muted,
              fontSize: 12,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
