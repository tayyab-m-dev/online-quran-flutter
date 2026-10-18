import 'package:flutter/material.dart';

const Color _green = Color(0xFF174D3A);
const Color _cream = Color(0xFFFAF7EF);
const Color _text = Color(0xFF26352D);
const Color _muted = Color(0xFF78847B);

class TeacherAttendanceScreen extends StatefulWidget {
  const TeacherAttendanceScreen({super.key});

  @override
  State<TeacherAttendanceScreen> createState() =>
      _TeacherAttendanceScreenState();
}

class _TeacherAttendanceScreenState
    extends State<TeacherAttendanceScreen> {
  String _selectedCourse = 'Quran Reading - Level 1';
  DateTime _selectedDate = DateTime.now();

  final List<String> _courses = [
    'Quran Reading - Level 1',
    'Tajweed Fundamentals',
    'Hifz Practice',
    'Arabic for Beginners',
  ];

  final List<Map<String, String>> _students = [
    {'name': 'Ayesha Khan', 'id': 'ST-001'},
    {'name': 'Muhammad Ali', 'id': 'ST-002'},
    {'name': 'Fatima Ahmed', 'id': 'ST-003'},
    {'name': 'Omar Hassan', 'id': 'ST-004'},
    {'name': 'Maryam Yusuf', 'id': 'ST-005'},
    {'name': 'Ibrahim Malik', 'id': 'ST-006'},
    {'name': 'Zainab Noor', 'id': 'ST-007'},
    {'name': 'Yusuf Abdullah', 'id': 'ST-008'},
  ];

  final Map<String, String> _attendance = {};

  int get _presentCount =>
      _attendance.values.where((status) => status == 'Present').length;

  int get _absentCount =>
      _attendance.values.where((status) => status == 'Absent').length;

  int get _unmarkedCount => _students.length - _attendance.length;

  String _formatDate(DateTime date) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];

    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  Future<void> _selectDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2035),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: _green,
              onPrimary: Colors.white,
              surface: _cream,
              onSurface: _text,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null && mounted) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  void _markAttendance(String studentId, String status) {
    setState(() {
      _attendance[studentId] = status;
    });
  }

  void _resetAttendance() {
    setState(() {
      _attendance.clear();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Attendance selections have been reset.'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                        _buildWelcomeCard(),
                        const SizedBox(height: 24),
                        const Text(
                          'Attendance Register',
                          style: TextStyle(
                            color: _green,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          'Mark attendance for your students.',
                          style: TextStyle(
                            color: _muted,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(height: 20),
                        _buildCourseSelector(),
                        const SizedBox(height: 14),
                        _buildDateSelector(),
                        const SizedBox(height: 20),
                        _buildAttendanceSummary(),
                        const SizedBox(height: 22),
                        Row(
                          children: [
                            const Expanded(
                              child: Text(
                                'Student list',
                                style: TextStyle(
                                  color: _text,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            TextButton.icon(
                              onPressed: _resetAttendance,
                              icon: const Icon(
                                Icons.refresh_rounded,
                                size: 17,
                              ),
                              label: const Text('Reset'),
                              style: TextButton.styleFrom(
                                foregroundColor: _green,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        ..._students.map(_buildStudentCard),
                        const SizedBox(height: 12),
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
              Icons.fact_check_outlined,
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
                  style: TextStyle(
                    color: _muted,
                    fontSize: 12,
                  ),
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
              'ATTENDANCE',
              style: TextStyle(
                color: _green,
                fontSize: 10,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWelcomeCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: _green,
        borderRadius: BorderRadius.circular(22),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.fact_check_rounded,
            color: Color(0xFFE9D19A),
            size: 30,
          ),
          SizedBox(height: 14),
          Text(
            'Every lesson counts.',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Keep track of attendance and support every learner.',
            style: TextStyle(
              color: Color(0xFFDDE7DF),
              fontSize: 12,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCourseSelector() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: const Color(0xFFEAE6DA)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedCourse,
          isExpanded: true,
          icon: const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: _green,
          ),
          style: const TextStyle(
            color: _text,
            fontSize: 13,
          ),
          items: _courses.map((course) {
            return DropdownMenuItem<String>(
              value: course,
              child: Text(
                course,
                overflow: TextOverflow.ellipsis,
              ),
            );
          }).toList(),
          onChanged: (value) {
            if (value != null) {
              setState(() {
                _selectedCourse = value;
                _attendance.clear();
              });
            }
          },
        ),
      ),
    );
  }

  Widget _buildDateSelector() {
    return InkWell(
      onTap: _selectDate,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: const Color(0xFFEAE6DA)),
        ),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: const Color(0xFFE8EDE5),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.calendar_month_rounded,
                color: _green,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Class date',
                    style: TextStyle(
                      color: _muted,
                      fontSize: 11,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    _formatDate(_selectedDate),
                    style: const TextStyle(
                      color: _text,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.edit_calendar_outlined,
              color: _green,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAttendanceSummary() {
    return Row(
      children: [
        Expanded(
          child: _buildSummaryCard(
            'Present',
            _presentCount,
            const Color(0xFFE0EFE3),
            _green,
            Icons.check_circle_outline_rounded,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _buildSummaryCard(
            'Absent',
            _absentCount,
            const Color(0xFFF5E1DE),
            const Color(0xFFB94A48),
            Icons.cancel_outlined,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _buildSummaryCard(
            'Unmarked',
            _unmarkedCount,
            const Color(0xFFF3E7C9),
            const Color(0xFF8B6914),
            Icons.pending_outlined,
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryCard(
      String label,
      int count,
      Color background,
      Color foreground,
      IconData icon,
      ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 15,
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: foreground, size: 21),
          const SizedBox(height: 10),
          Text(
            '$count',
            style: TextStyle(
              color: foreground,
              fontSize: 23,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            label,
            style: TextStyle(
              color: foreground,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStudentCard(Map<String, String> student) {
    final studentId = student['id']!;
    final name = student['name']!;
    final status = _attendance[studentId];

    final initials = name
        .split(' ')
        .map((part) => part[0])
        .take(2)
        .join();

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: status == 'Present'
              ? const Color(0xFFB8D8BF)
              : status == 'Absent'
              ? const Color(0xFFE8C2BD)
              : const Color(0xFFEAE6DA),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 23,
                backgroundColor: const Color(0xFFE8EDE5),
                child: Text(
                  initials,
                  style: const TextStyle(
                    color: _green,
                    fontSize: 13,
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
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Student ID: $studentId',
                      style: const TextStyle(
                        color: _muted,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
              if (status != null)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 9,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: status == 'Present'
                        ? const Color(0xFFE0EFE3)
                        : const Color(0xFFF5E1DE),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      color: status == 'Present'
                          ? _green
                          : const Color(0xFFB94A48),
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: _buildAttendanceButton(
                  label: 'Present',
                  icon: Icons.check_rounded,
                  selected: status == 'Present',
                  selectedColor: _green,
                  onPressed: () => _markAttendance(
                    studentId,
                    'Present',
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _buildAttendanceButton(
                  label: 'Absent',
                  icon: Icons.close_rounded,
                  selected: status == 'Absent',
                  selectedColor: const Color(0xFFB94A48),
                  onPressed: () => _markAttendance(
                    studentId,
                    'Absent',
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAttendanceButton({
    required String label,
    required IconData icon,
    required bool selected,
    required Color selectedColor,
    required VoidCallback onPressed,
  }) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 17),
      label: Text(label),
      style: OutlinedButton.styleFrom(
        foregroundColor: selected ? Colors.white : selectedColor,
        backgroundColor:
        selected ? selectedColor : Colors.transparent,
        side: BorderSide(color: selectedColor),
        padding: const EdgeInsets.symmetric(vertical: 11),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(11),
        ),
      ),
    );
  }

  Widget _buildInfoNote() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFE8EDE5),
        borderRadius: BorderRadius.circular(15),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.info_outline_rounded,
            color: _green,
            size: 21,
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              'Attendance is stored only in the current screen state. '
                  'It is not saved to a database.',
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
}