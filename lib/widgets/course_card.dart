
import 'package:flutter/material.dart';


class CourseLesson {
  final String title;
  final String duration;
  final bool isPreview;

  const CourseLesson({
    required this.title,
    required this.duration,
    this.isPreview = false,
  });
}

class Course {
  final String title;
  final String instructor;
  final String level;
  final String duration;
  final String category;
  final String description;
  final String instructorBio;
  final int students;
  final IconData icon;
  final List<CourseLesson> lessons;

  const Course({
    required this.title,
    required this.instructor,
    required this.level,
    required this.duration,
    required this.category,
    required this.description,
    required this.instructorBio,
    required this.students,
    required this.icon,
    required this.lessons,
  });

  int get lessonCount => lessons.length;
}

class CourseCard extends StatelessWidget {
  final Course course;
  final VoidCallback onTap;

  const CourseCard({
    super.key,
    required this.course,
    required this.onTap,
  });

  static const Color _border = Color(0xFFE8E2D3);
  static const Color _cream = Color(0xFFFFFBF3);
  static const Color _primary = Color(0xFF136B54);
  static const Color _primaryDark = Color(0xFF0E5340);
  static const Color _gold = Color(0xFFE3BF73);
  static const Color _text = Color(0xFF1B2B26);
  static const Color _muted = Color(0xFF5F6F69);

  @override
  Widget build(BuildContext context) {
    final isTajweed = course.category == 'Tajweed';

    return LayoutBuilder(
      builder: (context, constraints) {
        final compact = constraints.maxWidth < 400;
        final headerHeight = compact ? 96.0 : 130.0;

        return Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(20),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: _border),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x080E5340),
                    blurRadius: 12,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(
                    height: headerHeight,
                    compact: compact,
                    isTajweed: isTajweed,
                  ),
                  Padding(
                    padding: EdgeInsets.all(compact ? 14 : 18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          course.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: _muted,
                            fontSize: 14,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 14),
                        _buildInstructor(),
                        const SizedBox(height: 14),
                        _buildMetadata(compact: compact),
                        const SizedBox(height: 16),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            constraints: BoxConstraints(
                              minHeight: 44,
                              minWidth: compact ? double.infinity : 132,
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 11,
                            ),
                            decoration: BoxDecoration(
                              color: _primary,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisSize: compact
                                  ? MainAxisSize.max
                                  : MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text(
                                  'View course',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(width: 8),
                                Icon(
                                  Icons.arrow_forward_rounded,
                                  color: Colors.white,
                                  size: 18,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader({
    required double height,
    required bool compact,
    required bool isTajweed,
  }) {
    final colors = isTajweed
        ? const [_primary, _primaryDark]
        : const [Color(0xFF217E68), Color(0xFF145B4B)];

    return Container(
      height: height,
      width: double.infinity,
      padding: EdgeInsets.all(compact ? 14 : 18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: colors,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -12,
            top: -20,
            child: Icon(
              Icons.auto_awesome,
              size: compact ? 78 : 100,
              color: Colors.white.withValues(alpha: 0.06),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 9,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.10),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: _gold.withValues(alpha: 0.5),
                        ),
                      ),
                      child: Text(
                        course.category.toUpperCase(),
                        style: const TextStyle(
                          color: _gold,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.4,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      course.title,
                      maxLines: compact ? 2 : 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: compact ? 17 : 21,
                        height: 1.2,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Container(
                width: compact ? 42 : 54,
                height: compact ? 42 : 54,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.15),
                  ),
                ),
                child: Icon(
                  course.icon,
                  color: _gold,
                  size: compact ? 25 : 31,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInstructor() {
    final initials = course.instructor
        .trim()
        .split(RegExp(r'\s+'))
        .where((part) => part.isNotEmpty)
        .take(2)
        .map((part) => part[0].toUpperCase())
        .join();

    return Row(
      children: [
        CircleAvatar(
          radius: 19,
          backgroundColor: const Color(0xFFE7F2EE),
          child: Text(
            initials,
            style: const TextStyle(
              color: _primaryDark,
              fontSize: 13,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Instructor',
                style: TextStyle(
                  color: _muted,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                course.instructor,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: _text,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMetadata({required bool compact}) {
    return Wrap(
      spacing: 7,
      runSpacing: 8,
      children: [
        _metadataChip(
          Icons.signal_cellular_alt_rounded,
          course.level,
        ),
        _metadataChip(
          Icons.calendar_month_outlined,
          course.duration,
        ),
        _metadataChip(
          Icons.menu_book_outlined,
          '${course.lessonCount} lessons',
        ),
      ],
    );
  }

  Widget _metadataChip(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 7,
      ),
      decoration: BoxDecoration(
        color: _cream,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: _primary, size: 15),
          const SizedBox(width: 5),
          Text(
            label,
            style: const TextStyle(
              color: _text,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

