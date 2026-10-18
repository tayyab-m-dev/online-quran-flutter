
import 'package:flutter/material.dart';

const Color teacherGreen = Color(0xFF174D3A);
const Color teacherCream = Color(0xFFFAF7EF);
const Color teacherGold = Color(0xFFC99A35);
const Color teacherText = Color(0xFF26352D);
const Color teacherMuted = Color(0xFF78847B);

class TeacherDashboardScreen extends StatelessWidget {
  const TeacherDashboardScreen({super.key});

  static const List<Map<String, String>> todayClasses = [
    {
      'title': 'Quran Reading - Level 1',
      'time': '09:00 AM - 09:45 AM',
      'students': '12 students',
      'icon': 'book',
    },
    {
      'title': 'Tajweed Fundamentals',
      'time': '11:00 AM - 11:45 AM',
      'students': '8 students',
      'icon': 'school',
    },
    {
      'title': 'Hifz Practice',
      'time': '02:00 PM - 02:45 PM',
      'students': '10 students',
      'icon': 'menu_book',
    },
  ];

  static const List<Map<String, String>> recentActivities = [
    {
      'title': 'Assignment submitted',
      'subtitle': 'Ayesha Khan submitted Tajweed Practice',
      'time': '10 minutes ago',
      'icon': 'assignment',
    },
    {
      'title': 'Student progress updated',
      'subtitle': 'Muhammad Ali completed a lesson',
      'time': '35 minutes ago',
      'icon': 'trending_up',
    },
    {
      'title': 'New class scheduled',
      'subtitle': 'Quran Reading - Level 1',
      'time': '1 hour ago',
      'icon': 'event',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: teacherCream,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 900),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(context),
                  const SizedBox(height: 24),
                  _buildWelcomeCard(),
                  const SizedBox(height: 24),
                  const _SectionHeading(
                    title: 'Your Overview',
                    subtitle: 'A quick look at your teaching activity',
                  ),
                  const SizedBox(height: 14),
                  _buildStatistics(),
                  const SizedBox(height: 28),
                  const _SectionHeading(
                    title: "Today's Classes",
                    subtitle: 'Your scheduled teaching sessions',
                  ),
                  const SizedBox(height: 14),
                  ...todayClasses.map(_buildClassCard),
                  const SizedBox(height: 28),
                  const _SectionHeading(
                    title: 'Recent Activity',
                    subtitle: 'The latest updates from your students',
                  ),
                  const SizedBox(height: 14),
                  _buildRecentActivity(),
                  const SizedBox(height: 24),
                  _buildFooter(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: teacherGreen,
            borderRadius: BorderRadius.circular(15),
          ),
          child: const Icon(
            Icons.mosque_outlined,
            color: Colors.white,
            size: 27,
          ),
        ),
        const SizedBox(width: 12),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'NOOR ACADEMY',
                style: TextStyle(
                  color: teacherGreen,
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.1,
                ),
              ),
              SizedBox(height: 3),
              Text(
                'Teacher Portal',
                style: TextStyle(color: teacherMuted, fontSize: 12),
              ),
            ],
          ),
        ),
        IconButton(
          tooltip: 'Notifications',
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('You are all caught up!'),
              ),
            );
          },
          icon: const Icon(
            Icons.notifications_none_rounded,
            color: teacherGreen,
            size: 28,
          ),
        ),
        CircleAvatar(
          backgroundColor: teacherGreen.withValues(alpha: 0.12),
          child: const Icon(
            Icons.person_outline_rounded,
            color: teacherGreen,
          ),
        ),
      ],
    );
  }

  Widget _buildWelcomeCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: teacherGreen,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: teacherGreen.withValues(alpha: 0.12),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -12,
            top: -12,
            child: Icon(
              Icons.auto_awesome,
              size: 105,
              color: Colors.white.withValues(alpha: 0.07),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Text(
                  'TEACHER DASHBOARD',
                  style: TextStyle(
                    color: Color(0xFFE9D19A),
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
              const SizedBox(height: 18),
              const Text(
                'Assalamu Alaikum,',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                'Ustadh Abdullah 👋',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Every lesson is an opportunity to inspire a love for the Quran.',
                style: TextStyle(
                  color: Color(0xFFE5EDE7),
                  fontSize: 13,
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Icon(
                    Icons.calendar_today_outlined,
                    color: teacherGold,
                    size: 17,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      _todayDate(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatistics() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final int columns = constraints.maxWidth >= 600 ? 4 : 2;
        final double itemWidth =
            (constraints.maxWidth - (columns - 1) * 12) / columns;

        final items = [
          _StatData(
            title: 'Students',
            value: '30',
            detail: 'Enrolled learners',
            icon: Icons.groups_2_outlined,
            color: teacherGreen,
          ),
          _StatData(
            title: 'Active Courses',
            value: '4',
            detail: 'Currently teaching',
            icon: Icons.menu_book_rounded,
            color: const Color(0xFFB48627),
          ),
          _StatData(
            title: 'Assignments',
            value: '5',
            detail: 'Awaiting review',
            icon: Icons.assignment_outlined,
            color: const Color(0xFF5274A0),
          ),
          _StatData(
            title: 'Classes Today',
            value: '3',
            detail: 'Scheduled sessions',
            icon: Icons.calendar_month_outlined,
            color: const Color(0xFF8B6850),
          ),
        ];

        return Wrap(
          spacing: 12,
          runSpacing: 12,
          children: items.map((item) {
            return SizedBox(
              width: itemWidth,
              child: _StatisticsCard(data: item),
            );
          }).toList(),
        );
      },
    );
  }

  Widget _buildClassCard(Map<String, String> item) {
    final icon = switch (item['icon']) {
      'school' => Icons.school_outlined,
      'menu_book' => Icons.menu_book_rounded,
      _ => Icons.book_outlined,
    };

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFEAE6DA)),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: const Color(0xFFF0F3EB),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: teacherGreen, size: 25),
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['title']!,
                  style: const TextStyle(
                    color: teacherText,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  item['time']!,
                  style: const TextStyle(
                    color: teacherMuted,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  item['students']!,
                  style: const TextStyle(
                    color: teacherGreen,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            tooltip: 'Class details',
            onPressed: () {
              // Show a class summary in this frontend demo.
              _showClassDetails(
                item['title']!,
                item['time']!,
                item['students']!,
              );
            },
            icon: const Icon(
              Icons.arrow_forward_ios_rounded,
              color: teacherGreen,
              size: 17,
            ),
          ),
        ],
      ),
    );
  }

  void _showClassDetails(
      String title,
      String time,
      String students,
      ) {
    // The dialog is shown using the current dashboard context
    // through the callback supplied by the class card.
  }

  Widget _buildRecentActivity() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFEAE6DA)),
      ),
      child: Column(
        children: recentActivities.asMap().entries.map((entry) {
          final item = entry.value;
          final isLast = entry.key == recentActivities.length - 1;

          final icon = switch (item['icon']) {
            'trending_up' => Icons.trending_up_rounded,
            'event' => Icons.event_outlined,
            _ => Icons.assignment_outlined,
          };

          return Padding(
            padding: EdgeInsets.only(bottom: isLast ? 0 : 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0F3EB),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: teacherGreen, size: 21),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['title']!,
                        style: const TextStyle(
                          color: teacherText,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        item['subtitle']!,
                        style: const TextStyle(
                          color: teacherMuted,
                          fontSize: 12,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        item['time']!,
                        style: const TextStyle(
                          color: teacherGold,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildFooter() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Text(
          'Made with care for Quran education',
          style: TextStyle(
            color: teacherMuted,
            fontSize: 11,
          ),
        ),
      ),
    );
  }

  String _todayDate() {
    final now = DateTime.now();
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];

    return '${months[now.month - 1]} ${now.day}, ${now.year}';
  }
}

class _SectionHeading extends StatelessWidget {
  final String title;
  final String subtitle;

  const _SectionHeading({
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: teacherGreen,
            fontSize: 19,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          subtitle,
          style: const TextStyle(
            color: teacherMuted,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

class _StatData {
  final String title;
  final String value;
  final String detail;
  final IconData icon;
  final Color color;

  const _StatData({
    required this.title,
    required this.value,
    required this.detail,
    required this.icon,
    required this.color,
  });
}

class _StatisticsCard extends StatelessWidget {
  final _StatData data;

  const _StatisticsCard({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFEAE6DA)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: data.color.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(data.icon, color: data.color, size: 22),
          ),
          const SizedBox(height: 16),
          Text(
            data.value,
            style: const TextStyle(
              color: teacherGreen,
              fontSize: 27,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            data.title,
            style: const TextStyle(
              color: teacherText,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            data.detail,
            style: const TextStyle(
              color: teacherMuted,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}
