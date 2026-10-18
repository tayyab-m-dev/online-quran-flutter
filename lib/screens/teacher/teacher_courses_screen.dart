import 'package:flutter/material.dart';

const Color _green = Color(0xFF174D3A);
const Color _cream = Color(0xFFFAF7EF);
const Color _gold = Color(0xFFC99A35);
const Color _text = Color(0xFF26352D);
const Color _muted = Color(0xFF78847B);

class TeacherCoursesScreen extends StatefulWidget {
  const TeacherCoursesScreen({super.key});

  @override
  State<TeacherCoursesScreen> createState() =>
      _TeacherCoursesScreenState();
}

class _TeacherCoursesScreenState extends State<TeacherCoursesScreen> {
  final List<Map<String, dynamic>> _courses = [
    {
      'title': 'Quran Reading - Level 1',
      'category': 'Quran Reading',
      'students': 24,
      'progress': 0.75,
      'lessons': '15 of 20 lessons',
      'icon': Icons.menu_book_rounded,
      'color': const Color(0xFFE5EEDF),
      'description':
      'Help students improve Quran reading and pronunciation.',
    },
    {
      'title': 'Tajweed Fundamentals',
      'category': 'Tajweed',
      'students': 18,
      'progress': 0.60,
      'lessons': '12 of 20 lessons',
      'icon': Icons.record_voice_over_rounded,
      'color': const Color(0xFFF3E7C9),
      'description':
      'Teach the basic rules of Tajweed and Quran recitation.',
    },
    {
      'title': 'Hifz Practice',
      'category': 'Memorization',
      'students': 15,
      'progress': 0.88,
      'lessons': '22 of 25 lessons',
      'icon': Icons.auto_stories_rounded,
      'color': const Color(0xFFE8DDEC),
      'description':
      'Help students memorize and revise Quranic verses.',
    },
    {
      'title': 'Arabic for Beginners',
      'category': 'Arabic',
      'students': 20,
      'progress': 0.45,
      'lessons': '9 of 20 lessons',
      'icon': Icons.language_rounded,
      'color': const Color(0xFFDCE7F0),
      'description':
      'Introduce Arabic letters, vocabulary, and reading skills.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final totalStudents = _courses.fold<int>(
      0,
          (total, course) => total + (course['students'] as int),
    );

    return Scaffold(
      backgroundColor: _cream,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 900),
            child: Column(
              children: [
                _buildHeader(),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSummary(totalStudents),
                        const SizedBox(height: 25),
                        const Text(
                          'My Courses',
                          style: TextStyle(
                            color: _green,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          'Manage your classes and track progress.',
                          style: TextStyle(
                            color: _muted,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(height: 18),
                        Row(
                          children: [
                            const Text(
                              'Course directory',
                              style: TextStyle(
                                color: _text,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              '${_courses.length} courses',
                              style: const TextStyle(
                                color: _muted,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),
                        ..._courses.map(
                              (course) => _buildCourseCard(context, course),
                        ),
                        _buildInfoNote(),
                      ],
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

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: _green,
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.menu_book_rounded,
              color: Colors.white,
              size: 25,
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
                    color: _green,
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                    letterSpacing: 1,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Teacher Portal',
                  style: TextStyle(color: _muted, fontSize: 12),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFFE8EDE5),
              borderRadius: BorderRadius.circular(30),
            ),
            child: const Text(
              'COURSES',
              style: TextStyle(
                color: _green,
                fontSize: 10,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.8,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummary(int totalStudents) {
    final averageProgress = _courses.fold<double>(
      0,
          (sum, course) => sum + (course['progress'] as double),
    ) /
        _courses.length;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _green,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'YOUR TEACHING OVERVIEW',
            style: TextStyle(
              color: Color(0xFFE9D19A),
              fontSize: 11,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Knowledge shared is a lasting gift.',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _buildSummaryItem(
                  'Active courses',
                  '${_courses.length}',
                  Icons.menu_book_outlined,
                ),
              ),
              Container(
                width: 1,
                height: 55,
                color: Colors.white24,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildSummaryItem(
                  'Enrollments',
                  '$totalStudents',
                  Icons.groups_2_outlined,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            'Average course progress',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: averageProgress,
                    minHeight: 7,
                    backgroundColor: Colors.white24,
                    valueColor:
                    const AlwaysStoppedAnimation<Color>(_gold),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                '${(averageProgress * 100).round()}%',
                style: const TextStyle(
                  color: Color(0xFFE9D19A),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(
      String label,
      String value,
      IconData icon,
      ) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFFE9D19A), size: 23),
        const SizedBox(width: 9),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCourseCard(
      BuildContext context,
      Map<String, dynamic> course,
      ) {
    final progress = course['progress'] as double;

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFEAE6DA)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: course['color'] as Color,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  course['icon'] as IconData,
                  color: _green,
                  size: 25,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      course['category'] as String,
                      style: const TextStyle(
                        color: _gold,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      course['title'] as String,
                      style: const TextStyle(
                        color: _text,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              const Icon(
                Icons.groups_outlined,
                color: _muted,
                size: 18,
              ),
              const SizedBox(width: 7),
              Text(
                '${course['students']} enrolled students',
                style: const TextStyle(
                  color: _muted,
                  fontSize: 12,
                ),
              ),
              const Spacer(),
              Text(
                '${(progress * 100).round()}%',
                style: const TextStyle(
                  color: _green,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 9),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 7,
              backgroundColor: const Color(0xFFECEFE8),
              valueColor: AlwaysStoppedAnimation<Color>(
                progress >= 0.75 ? _green : _gold,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            course['lessons'] as String,
            style: const TextStyle(
              color: _muted,
              fontSize: 11,
            ),
          ),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () => _showCourseDetails(context, course),
              icon: const Icon(Icons.arrow_forward_rounded, size: 18),
              label: const Text('View course details'),
              style: OutlinedButton.styleFrom(
                foregroundColor: _green,
                side: const BorderSide(color: _green),
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoNote() {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFE8EDE5),
        borderRadius: BorderRadius.circular(15),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline_rounded, color: _green, size: 21),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              'Course details use sample data for this UI preview. '
                  'No database is connected.',
              style: TextStyle(
                color: _green,
                fontSize: 12,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showCourseDetails(
      BuildContext context,
      Map<String, dynamic> course,
      ) {
    final progress = course['progress'] as double;

    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: _cream,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Text(
          course['title'] as String,
          style: const TextStyle(
            color: _green,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                course['description'] as String,
                style: const TextStyle(
                  color: _text,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Enrolled students: ${course['students']}',
                style: const TextStyle(
                  color: _green,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Lessons: ${course['lessons']}',
                style: const TextStyle(
                  color: _muted,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Course progress: ${(progress * 100).round()}%',
                style: const TextStyle(
                  color: _green,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 7,
                  backgroundColor: const Color(0xFFE0E6DD),
                  valueColor:
                  const AlwaysStoppedAnimation<Color>(_green),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text(
              'Close',
              style: TextStyle(color: _green),
            ),
          ),
        ],
      ),
    );
  }
}