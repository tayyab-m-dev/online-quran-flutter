import 'package:flutter/material.dart';

const Color _green = Color(0xFF174D3A);
const Color _cream = Color(0xFFFAF7EF);
const Color _text = Color(0xFF26352D);
const Color _muted = Color(0xFF78847B);
const Color _gold = Color(0xFFC99A35);

class TeacherAssignmentsScreen extends StatefulWidget {
  const TeacherAssignmentsScreen({super.key});

  @override
  State<TeacherAssignmentsScreen> createState() =>
      _TeacherAssignmentsScreenState();
}

class _TeacherAssignmentsScreenState
    extends State<TeacherAssignmentsScreen> {
  String _selectedFilter = 'All';

  final List<Map<String, dynamic>> _assignments = [
    {
      'title': 'Surah Al-Fatiha Recitation',
      'course': 'Quran Reading - Level 1',
      'dueDate': '20 Oct 2026',
      'students': 18,
      'status': 'Pending',
      'icon': Icons.menu_book_rounded,
    },
    {
      'title': 'Tajweed Rules Practice',
      'course': 'Tajweed Fundamentals',
      'dueDate': '22 Oct 2026',
      'students': 15,
      'status': 'Submitted',
      'icon': Icons.record_voice_over_rounded,
    },
    {
      'title': 'Memorize Surah Al-Ikhlas',
      'course': 'Hifz Practice',
      'dueDate': '24 Oct 2026',
      'students': 12,
      'status': 'Pending',
      'icon': Icons.auto_stories_rounded,
    },
    {
      'title': 'Arabic Letters Worksheet',
      'course': 'Arabic for Beginners',
      'dueDate': '26 Oct 2026',
      'students': 20,
      'status': 'Pending',
      'icon': Icons.edit_note_rounded,
    },
    {
      'title': 'Daily Revision Exercise',
      'course': 'Quran Reading - Level 1',
      'dueDate': '18 Oct 2026',
      'students': 18,
      'status': 'Submitted',
      'icon': Icons.task_alt_rounded,
    },
  ];

  int get _pendingCount => _assignments
      .where((assignment) => assignment['status'] == 'Pending')
      .length;

  int get _submittedCount => _assignments
      .where((assignment) => assignment['status'] == 'Submitted')
      .length;

  List<Map<String, dynamic>> get _filteredAssignments {
    if (_selectedFilter == 'All') {
      return _assignments;
    }

    return _assignments
        .where((assignment) => assignment['status'] == _selectedFilter)
        .toList();
  }

  void _toggleStatus(int index) {
    final assignment = _filteredAssignments[index];
    final originalIndex = _assignments.indexOf(assignment);

    setState(() {
      _assignments[originalIndex]['status'] =
      assignment['status'] == 'Pending' ? 'Submitted' : 'Pending';
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '${assignment['title']} status updated.',
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showAssignmentDetails(Map<String, dynamic> assignment) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        final isSubmitted = assignment['status'] == 'Submitted';

        return AlertDialog(
          backgroundColor: _cream,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            assignment['title'] as String,
            style: const TextStyle(
              color: _green,
              fontWeight: FontWeight.bold,
              fontSize: 19,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _detailRow(
                Icons.menu_book_rounded,
                'Course',
                assignment['course'] as String,
              ),
              const SizedBox(height: 14),
              _detailRow(
                Icons.calendar_month_rounded,
                'Due date',
                assignment['dueDate'] as String,
              ),
              const SizedBox(height: 14),
              _detailRow(
                Icons.people_alt_rounded,
                'Enrolled students',
                '${assignment['students']} students',
              ),
              const SizedBox(height: 14),
              _detailRow(
                Icons.info_outline_rounded,
                'Status',
                assignment['status'] as String,
              ),
              const SizedBox(height: 16),
              const Text(
                'This is sample assignment data. Changes are temporary.',
                style: TextStyle(
                  color: _muted,
                  fontSize: 12,
                ),
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
            ElevatedButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                final index = _assignments.indexOf(assignment);
                setState(() {
                  _assignments[index]['status'] =
                  isSubmitted ? 'Pending' : 'Submitted';
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: _green,
                foregroundColor: Colors.white,
              ),
              child: Text(
                isSubmitted ? 'Mark Pending' : 'Mark Submitted',
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _detailRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: _green, size: 19),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  color: _muted,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                value,
                style: const TextStyle(
                  color: _text,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ],
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
                    padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildWelcomeCard(),
                        const SizedBox(height: 24),
                        const Text(
                          'Assignments',
                          style: TextStyle(
                            color: _green,
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          'Create a clear learning path for every student.',
                          style: TextStyle(
                            color: _muted,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(height: 20),
                        _buildSummaryCards(),
                        const SizedBox(height: 24),
                        _buildFilter(),
                        const SizedBox(height: 16),
                        if (_filteredAssignments.isEmpty)
                          _buildEmptyState()
                        else
                          ..._filteredAssignments.map(_buildAssignmentCard),
                        const SizedBox(height: 20),
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
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Color(0xFFE9E8DF)),
        ),
      ),
      child: Row(
        children: [
          Container(
            height: 44,
            width: 44,
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
                  'Noor Academy',
                  style: TextStyle(
                    color: _green,
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  'TEACHER PORTAL',
                  style: TextStyle(
                    color: _muted,
                    fontSize: 10,
                    letterSpacing: 1.4,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 11,
              vertical: 7,
            ),
            decoration: BoxDecoration(
              color: _cream,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              'ASSIGNMENTS',
              style: TextStyle(
                color: _green,
                fontSize: 10,
                fontWeight: FontWeight.bold,
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
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Learning through practice',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Review tasks and track assignment progress.',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.82),
                    fontSize: 13,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Container(
            height: 58,
            width: 58,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Icon(
              Icons.assignment_rounded,
              color: _gold,
              size: 31,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCards() {
    return Row(
      children: [
        Expanded(
          child: _buildSummaryCard(
            'Total',
            _assignments.length.toString(),
            Icons.assignment_outlined,
            _green,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _buildSummaryCard(
            'Pending',
            _pendingCount.toString(),
            Icons.pending_actions_rounded,
            _gold,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _buildSummaryCard(
            'Submitted',
            _submittedCount.toString(),
            Icons.task_alt_rounded,
            const Color(0xFF47856A),
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryCard(
      String label,
      String value,
      IconData icon,
      Color color,
      ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 15,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17),
        border: Border.all(color: const Color(0xFFECE9DF)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 21),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(
              color: _text,
              fontSize: 23,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: _muted,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Filter assignments',
          style: TextStyle(
            color: _text,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: ['All', 'Pending', 'Submitted'].map((filter) {
            final isSelected = _selectedFilter == filter;

            return ChoiceChip(
              label: Text(filter),
              selected: isSelected,
              onSelected: (_) {
                setState(() {
                  _selectedFilter = filter;
                });
              },
              selectedColor: _green,
              backgroundColor: Colors.white,
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : _text,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
              side: BorderSide(
                color: isSelected ? _green : const Color(0xFFE4E2D8),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(22),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildAssignmentCard(Map<String, dynamic> assignment) {
    final isSubmitted = assignment['status'] == 'Submitted';

    return Container(
      margin: const EdgeInsets.only(bottom: 13),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: const Color(0xFFECE9DF)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 46,
                width: 46,
                decoration: BoxDecoration(
                  color: _cream,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  assignment['icon'] as IconData,
                  color: _green,
                  size: 23,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      assignment['title'] as String,
                      style: const TextStyle(
                        color: _text,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      assignment['course'] as String,
                      style: const TextStyle(
                        color: _muted,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 6),
              _buildStatusBadge(isSubmitted),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(height: 1, color: Color(0xFFECE9DF)),
          const SizedBox(height: 14),
          Wrap(
            spacing: 18,
            runSpacing: 8,
            children: [
              _buildMeta(
                Icons.calendar_today_rounded,
                'Due ${assignment['dueDate']}',
              ),
              _buildMeta(
                Icons.people_alt_outlined,
                '${assignment['students']} students',
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => _showAssignmentDetails(assignment),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: _green,
                    side: const BorderSide(color: _green),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('View details'),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => _toggleStatus(
                    _filteredAssignments.indexOf(assignment),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _green,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    isSubmitted ? 'Mark Pending' : 'Mark Submitted',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(bool isSubmitted) {
    final color = isSubmitted ? const Color(0xFF347653) : _gold;
    final background =
    isSubmitted ? const Color(0xFFE7F3EA) : const Color(0xFFFFF3D8);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        isSubmitted ? 'Submitted' : 'Pending',
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildMeta(IconData icon, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: _muted, size: 15),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(
            color: _muted,
            fontSize: 11,
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFECE9DF)),
      ),
      child: const Column(
        children: [
          Icon(
            Icons.assignment_turned_in_outlined,
            color: _muted,
            size: 42,
          ),
          SizedBox(height: 12),
          Text(
            'No assignments found',
            style: TextStyle(
              color: _text,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 6),
          Text(
            'Try selecting a different status filter.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: _muted,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoNote() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFFF0EEE4),
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.info_outline_rounded,
            color: _green,
            size: 20,
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              'Demo mode: assignment statuses are stored only while this screen remains active. No database or server is connected.',
              style: TextStyle(
                color: _text,
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