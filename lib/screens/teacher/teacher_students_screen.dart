
import 'package:flutter/material.dart';

const Color _green = Color(0xFF174D3A);
const Color _cream = Color(0xFFFAF7EF);
const Color _gold = Color(0xFFC99A35);
const Color _text = Color(0xFF26352D);
const Color _muted = Color(0xFF78847B);

class TeacherStudentsScreen extends StatefulWidget {
  const TeacherStudentsScreen({super.key});

  @override
  State<TeacherStudentsScreen> createState() =>
      _TeacherStudentsScreenState();
}

class _TeacherStudentsScreenState extends State<TeacherStudentsScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  final List<Map<String, dynamic>> _students = [
    {
      'name': 'Ayesha Khan',
      'course': 'Quran Reading - Level 1',
      'progress': 0.85,
      'lessons': '17 of 20 lessons',
      'color': const Color(0xFFE8D9C6),
    },
    {
      'name': 'Muhammad Ali',
      'course': 'Tajweed Fundamentals',
      'progress': 0.70,
      'lessons': '14 of 20 lessons',
      'color': const Color(0xFFD9E7D9),
    },
    {
      'name': 'Fatima Ahmed',
      'course': 'Hifz Practice',
      'progress': 0.92,
      'lessons': '23 of 25 lessons',
      'color': const Color(0xFFF0E1B9),
    },
    {
      'name': 'Omar Hassan',
      'course': 'Quran Reading - Level 1',
      'progress': 0.45,
      'lessons': '9 of 20 lessons',
      'color': const Color(0xFFDCE4EF),
    },
    {
      'name': 'Maryam Yusuf',
      'course': 'Arabic for Beginners',
      'progress': 0.60,
      'lessons': '12 of 20 lessons',
      'color': const Color(0xFFEADBEA),
    },
    {
      'name': 'Ibrahim Malik',
      'course': 'Tajweed Fundamentals',
      'progress': 0.30,
      'lessons': '6 of 20 lessons',
      'color': const Color(0xFFF0DAD1),
    },
    {
      'name': 'Zainab Noor',
      'course': 'Hifz Practice',
      'progress': 0.78,
      'lessons': '19 of 25 lessons',
      'color': const Color(0xFFD9E7D9),
    },
    {
      'name': 'Yusuf Abdullah',
      'course': 'Arabic for Beginners',
      'progress': 0.55,
      'lessons': '11 of 20 lessons',
      'color': const Color(0xFFE8D9C6),
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredStudents = _students.where((student) {
      final query = _searchQuery.toLowerCase();
      return (student['name'] as String).toLowerCase().contains(query) ||
          (student['course'] as String).toLowerCase().contains(query);
    }).toList();

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
                        _buildSummary(),
                        const SizedBox(height: 25),
                        const Text(
                          'All Students',
                          style: TextStyle(
                            color: _green,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          'Search learners and review their progress.',
                          style: TextStyle(color: _muted, fontSize: 13),
                        ),
                        const SizedBox(height: 17),
                        _buildSearchField(),
                        const SizedBox(height: 17),
                        Row(
                          children: [
                            const Text(
                              'Student directory',
                              style: TextStyle(
                                color: _text,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              '${filteredStudents.length} students',
                              style: const TextStyle(
                                color: _muted,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        if (filteredStudents.isEmpty)
                          _buildEmptyState()
                        else
                          ...filteredStudents.map(_buildStudentCard),
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
              Icons.groups_2_outlined,
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
              'STUDENTS',
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

  Widget _buildSummary() {
    final averageProgress = _students.fold<double>(
      0,
          (sum, student) => sum + (student['progress'] as double),
    ) /
        _students.length;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _green,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Your learners',
                  style: TextStyle(color: Colors.white70, fontSize: 13),
                ),
                const SizedBox(height: 8),
                Text(
                  '${_students.length}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                const Text(
                  'Sample enrolled students',
                  style: TextStyle(
                    color: Color(0xFFE2EADF),
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          Container(width: 1, height: 65, color: Colors.white24),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Average progress',
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
                const SizedBox(height: 8),
                Text(
                  '${(averageProgress * 100).round()}%',
                  style: const TextStyle(
                    color: Color(0xFFE9D19A),
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: averageProgress,
                    minHeight: 6,
                    backgroundColor: Colors.white24,
                    valueColor: const AlwaysStoppedAnimation<Color>(_gold),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchField() {
    return TextField(
      controller: _searchController,
      onChanged: (value) {
        setState(() => _searchQuery = value.trim());
      },
      decoration: InputDecoration(
        hintText: 'Search by student or course...',
        hintStyle: const TextStyle(color: _muted, fontSize: 13),
        prefixIcon: const Icon(Icons.search_rounded, color: _green),
        suffixIcon: _searchQuery.isEmpty
            ? null
            : IconButton(
          tooltip: 'Clear search',
          onPressed: () {
            _searchController.clear();
            setState(() => _searchQuery = '');
          },
          icon: const Icon(Icons.close_rounded),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 15),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFFEAE6DA)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFFEAE6DA)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: _green, width: 1.5),
        ),
      ),
    );
  }

  Widget _buildStudentCard(Map<String, dynamic> student) {
    final progress = student['progress'] as double;
    final name = student['name'] as String;
    final course = student['course'] as String;
    final initials = name
        .split(' ')
        .map((part) => part[0])
        .take(2)
        .join();

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFEAE6DA)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: student['color'] as Color,
                child: Text(
                  initials,
                  style: const TextStyle(
                    color: _green,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        color: _text,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      course,
                      style: const TextStyle(color: _muted, fontSize: 11),
                    ),
                  ],
                ),
              ),
              IconButton(
                tooltip: 'View student details',
                onPressed: () => _showStudentDetails(student),
                icon: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: _green,
                  size: 17,
                ),
              ),
            ],
          ),
          const SizedBox(height: 17),
          Row(
            children: [
              const Text(
                'Learning progress',
                style: TextStyle(color: _muted, fontSize: 11),
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
          const SizedBox(height: 8),
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
          const SizedBox(height: 9),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              student['lessons'] as String,
              style: const TextStyle(color: _muted, fontSize: 11),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFEAE6DA)),
      ),
      child: const Column(
        children: [
          Icon(Icons.search_off_rounded, color: _muted, size: 45),
          SizedBox(height: 12),
          Text(
            'No students found',
            style: TextStyle(
              color: _green,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 6),
          Text(
            'Try a different name or course.',
            textAlign: TextAlign.center,
            style: TextStyle(color: _muted, fontSize: 12),
          ),
        ],
      ),
    );
  }

  void _showStudentDetails(Map<String, dynamic> student) {
    final progress = student['progress'] as double;

    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: _cream,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            student['name'] as String,
            style: const TextStyle(
              color: _green,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Enrolled course',
                style: TextStyle(color: _muted, fontSize: 12),
              ),
              const SizedBox(height: 5),
              Text(
                student['course'] as String,
                style: const TextStyle(
                  color: _text,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 18),
              const Text(
                'Lessons completed',
                style: TextStyle(color: _muted, fontSize: 12),
              ),
              const SizedBox(height: 5),
              Text(
                student['lessons'] as String,
                style: const TextStyle(
                  color: _text,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 18),
              Text(
                'Overall progress: ${(progress * 100).round()}%',
                style: const TextStyle(
                  color: _green,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              LinearProgressIndicator(
                value: progress,
                minHeight: 7,
                backgroundColor: const Color(0xFFE0E6DD),
                valueColor: const AlwaysStoppedAnimation<Color>(_green),
              ),
            ],
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
        );
      },
    );
  }
}
