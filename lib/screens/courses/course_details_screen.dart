import 'package:flutter/material.dart';

import '../../widgets/course_card.dart';
import '../../widgets/section_title.dart';

class CourseDetailsScreen extends StatelessWidget {
  final Course course;

  const CourseDetailsScreen({
    super.key,
    required this.course,
  });

  void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          behavior: SnackBarBehavior.floating,
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appCream,
      appBar: AppBar(
        backgroundColor: appCream,
        foregroundColor: appInk,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: const Text(
          'Course Details',
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 850),
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
            children: [
              _buildHero(),
              const SizedBox(height: 28),
              const SectionTitle(
                title: 'Your Instructor',
                subtitle: 'Learn with guidance and consistency',
              ),
              const SizedBox(height: 14),
              _buildInstructor(),
              const SizedBox(height: 28),
              const SectionTitle(
                title: 'What You Will Learn',
                subtitle: 'Build your knowledge one lesson at a time',
              ),
              const SizedBox(height: 14),
              _buildOutcomes(),
              const SizedBox(height: 28),
              SectionTitle(
                title: 'Course Curriculum',
                subtitle: '${course.lessonCount} lessons to explore',
              ),
              const SizedBox(height: 14),
              _buildCurriculum(context),
              const SizedBox(height: 24),
              _buildLearningTip(),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: () => _showMessage(
                    context,
                    'Enrollment is a sample interaction. '
                        'Real enrollment will be connected later.',
                  ),
                  icon: const Icon(Icons.menu_book_rounded),
                  label: const Text('Enroll in This Course'),
                  style: FilledButton.styleFrom(
                    backgroundColor: appEmerald,
                    foregroundColor: Colors.white,
                    minimumSize: const Size.fromHeight(54),
                    textStyle: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Your learning journey starts with one lesson.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: appMuted,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHero() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            appEmerald,
            Color(0xFF194637),
          ],
        ),
        borderRadius: BorderRadius.circular(26),
        boxShadow: [
          BoxShadow(
            color: appEmerald.withValues(alpha: 0.14),
            blurRadius: 22,
            offset: const Offset(0, 9),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  color: appGold.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: appGold.withValues(alpha: 0.4),
                  ),
                ),
                child: Text(
                  course.category.toUpperCase(),
                  style: const TextStyle(
                    color: appGold,
                    fontSize: 10,
                    letterSpacing: 1,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const Spacer(),
              const Icon(
                Icons.auto_awesome_rounded,
                color: appGold,
              ),
            ],
          ),
          const SizedBox(height: 24),
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.09),
              borderRadius: BorderRadius.circular(22),
            ),
            child: Icon(
              course.icon,
              color: appGold,
              size: 40,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            course.title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 27,
              height: 1.3,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            course.description,
            style: const TextStyle(
              color: Color(0xFFE0EBE4),
              fontSize: 14,
              height: 1.7,
            ),
          ),
          const SizedBox(height: 22),
          Row(
            children: [
              Expanded(
                child: _HeroStat(
                  icon: Icons.play_lesson_rounded,
                  value: '${course.lessonCount} lessons',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _HeroStat(
                  icon: Icons.schedule_rounded,
                  value: course.duration,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInstructor() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFE8E5DA),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: const Color(0xFFE5EFE8),
              borderRadius: BorderRadius.circular(17),
            ),
            child: const Icon(
              Icons.person_rounded,
              color: appEmerald,
              size: 32,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  course.instructor,
                  style: const TextStyle(
                    color: appInk,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Guidance for your Quran learning journey.',
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

  Widget _buildOutcomes() {
    const outcomes = [
      'Build a regular Quran learning routine.',
      'Study topics through structured lessons.',
      'Review lessons as you progress.',
    ];

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFE8E5DA),
        ),
      ),
      child: Column(
        children: outcomes.map((outcome) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 9),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.check_circle_rounded,
                  color: appEmerald,
                  size: 21,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    outcome,
                    style: const TextStyle(
                      color: appInk,
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildCurriculum(BuildContext context) {
    if (course.lessons.isEmpty) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: const Color(0xFFE8E5DA),
          ),
        ),
        child: const Column(
          children: [
            Icon(
              Icons.menu_book_rounded,
              color: appEmerald,
              size: 34,
            ),
            SizedBox(height: 10),
            Text(
              'Lessons coming soon',
              style: TextStyle(
                color: appInk,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFE8E5DA),
        ),
      ),
      child: Column(
        children: List.generate(course.lessons.length, (index) {
          final lesson = course.lessons[index];

          return Column(
            children: [
              ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 7,
                ),
                leading: Container(
                  width: 42,
                  height: 42,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: lesson.isPreview
                        ? const Color(0xFFE5EFE8)
                        : appCream,
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: Text(
                    '${index + 1}'.padLeft(2, '0'),
                    style: const TextStyle(
                      color: appEmerald,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                title: Text(
                  lesson.title,
                  style: const TextStyle(
                    color: appInk,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.schedule_rounded,
                        size: 14,
                        color: appMuted,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        lesson.duration,
                        style: const TextStyle(
                          color: appMuted,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                trailing: Icon(
                  lesson.isPreview
                      ? Icons.play_circle_outline_rounded
                      : Icons.lock_outline_rounded,
                  color: appEmerald,
                ),
                onTap: () {
                  if (lesson.isPreview) {
                    _showMessage(
                      context,
                      'Sample lesson selected: ${lesson.title}. '
                          'Video playback will be added later.',
                    );
                  } else {
                    _showMessage(
                      context,
                      'Enrollment is not connected yet.',
                    );
                  }
                },
              ),
              if (index < course.lessons.length - 1)
                const Divider(
                  height: 1,
                  indent: 16,
                  endIndent: 16,
                  color: Color(0xFFEAE8DF),
                ),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildLearningTip() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFF0EBDD),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFE7DFC9),
        ),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.lightbulb_outline_rounded,
            color: appEmerald,
            size: 23,
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'A little consistency goes a long way',
                  style: TextStyle(
                    color: appInk,
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Set aside regular time for learning and review '
                      'each lesson before moving forward.',
                  style: TextStyle(
                    color: appMuted,
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
}

class _HeroStat extends StatelessWidget {
  final IconData icon;
  final String value;

  const _HeroStat({
    required this.icon,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: appGold,
          size: 19,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}