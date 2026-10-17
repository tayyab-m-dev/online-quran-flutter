import 'package:flutter/material.dart';
import '../../widgets/course_card.dart';
import '../../widgets/section_title.dart';
import 'course_details_screen.dart';

class CoursesScreen extends StatefulWidget {
  const CoursesScreen({super.key});

  @override
  State<CoursesScreen> createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedCategory = 'All';

  final List<Course> _courses = [
    Course(
      title: 'Quran with Tajweed',
      description:
      'Learn Quran recitation with correct pronunciation and Tajweed rules.',
      instructor: 'Ustadh Ahmed',
      instructorBio:
      'An experienced Quran teacher dedicated to helping students learn Tajweed with confidence.',
      category: 'Tajweed',
      level: 'Beginner',
      duration: '6 weeks',
      students: 1200,
      icon: Icons.menu_book_rounded,
      lessons: [
        CourseLesson(
          title: 'Introduction to Tajweed',
          duration: '12 min',
          isPreview: true,
        ),
        CourseLesson(title: 'Arabic Alphabet', duration: '15 min'),
        CourseLesson(title: 'Makharij of Letters', duration: '18 min'),
        CourseLesson(
          title: 'Characteristics of Letters',
          duration: '20 min',
        ),
        CourseLesson(title: 'Basic Tajweed Rules', duration: '16 min'),
      ],
    ),
    Course(
      title: 'Quran Memorization',
      description:
      'Build a consistent memorization routine with practical revision techniques.',
      instructor: 'Ustadh Yusuf',
      instructorBio:
      'A supportive Quran instructor focused on effective memorization and revision habits.',
      category: 'Memorization',
      level: 'All levels',
      duration: '8 weeks',
      students: 980,
      icon: Icons.auto_stories_rounded,
      lessons: [
        CourseLesson(
          title: 'Getting Started with Hifz',
          duration: '10 min',
          isPreview: true,
        ),
        CourseLesson(
          title: 'Building a Daily Routine',
          duration: '14 min',
        ),
        CourseLesson(
          title: 'Memorization Techniques',
          duration: '17 min',
        ),
        CourseLesson(title: 'Revision Strategies', duration: '15 min'),
        CourseLesson(title: 'Staying Consistent', duration: '12 min'),
      ],
    ),
  ];

  final List<String> _categories = [
    'All',
    'Tajweed',
    'Memorization',
  ];

  List<Course> get _filteredCourses {
    final query = _searchController.text.trim().toLowerCase();

    return _courses.where((course) {
      final matchesCategory = _selectedCategory == 'All' ||
          course.category == _selectedCategory;

      final matchesSearch = query.isEmpty ||
          course.title.toLowerCase().contains(query) ||
          course.description.toLowerCase().contains(query) ||
          course.instructor.toLowerCase().contains(query);

      return matchesCategory && matchesSearch;
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final courses = _filteredCourses;

    return Scaffold(
      backgroundColor: appCream,
      appBar: AppBar(
        backgroundColor: appCream,
        foregroundColor: appInk,
        elevation: 0,
        title: const Text(
          'Explore Courses',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1040),
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                _buildWelcomeBanner(),
                const SizedBox(height: 26),
                const SectionTitle(
                  title: 'Find your next lesson',
                  subtitle: 'Learn at your own pace, one step at a time.',
                ),
                const SizedBox(height: 16),
                _buildSearchField(),
                const SizedBox(height: 16),
                _buildCategoryFilters(),
                const SizedBox(height: 22),
                SectionTitle(
                  title: 'Available courses',
                  subtitle: '${courses.length} courses to explore',
                ),
                const SizedBox(height: 14),
                if (courses.isEmpty)
                  _buildEmptyState()
                else
                  ...courses.map(
                        (course) => Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: CourseCard(
                        course: course,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => CourseDetailsScreen(
                                course: course,
                              ),
                            ),
                          );
                        },
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

  Widget _buildWelcomeBanner() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: appEmerald,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Assalamu Alaikum',
                  style: TextStyle(
                    color: appGold,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Grow your connection\nwith the Holy Quran',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                    height: 1.3,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Choose a course and begin your learning journey.',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.85),
                    fontSize: 13,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          const Icon(
            Icons.menu_book_rounded,
            color: appGold,
            size: 58,
          ),
        ],
      ),
    );
  }

  Widget _buildSearchField() {
    return TextField(
      controller: _searchController,
      onChanged: (_) => setState(() {}),
      decoration: InputDecoration(
        hintText: 'Search courses or instructors...',
        prefixIcon: const Icon(
          Icons.search_rounded,
          color: appEmerald,
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFFEAE8DF)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFFEAE8DF)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: appEmerald,
            width: 1.5,
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryFilters() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: _categories.map((category) {
          final isSelected = category == _selectedCategory;

          return Padding(
            padding: const EdgeInsets.only(right: 10),
            child: ChoiceChip(
              label: Text(category),
              selected: isSelected,
              onSelected: (_) {
                setState(() {
                  _selectedCategory = category;
                });
              },
              selectedColor: appEmerald,
              backgroundColor: Colors.white,
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : appInk,
                fontWeight: FontWeight.w600,
              ),
              side: BorderSide(
                color: isSelected
                    ? appEmerald
                    : const Color(0xFFEAE8DF),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              showCheckmark: false,
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFEAE8DF)),
      ),
      child: const Column(
        children: [
          Icon(
            Icons.search_off_rounded,
            size: 46,
            color: appMuted,
          ),
          SizedBox(height: 12),
          Text(
            'No courses found',
            style: TextStyle(
              color: appInk,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 6),
          Text(
            'Try another search or choose a different category.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: appMuted,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}