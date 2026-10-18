
import 'package:flutter/material.dart';
import '../../widgets/course_card.dart';
import 'course_details_screen.dart';

class CoursesScreen extends StatefulWidget {
  const CoursesScreen({
    super.key,
    required this.onNavigate,
  });

  final ValueChanged<int> onNavigate;

  @override
  State<CoursesScreen> createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen> {
  static const Color cream = Color(0xFFFFFBF3);
  static const Color primary = Color(0xFF136B54);
  static const Color primaryDark = Color(0xFF0E5340);
  static const Color gold = Color(0xFFE3BF73);
  static const Color ink = Color(0xFF1B2B26);
  static const Color muted = Color(0xFF5F6F69);
  static const Color border = Color(0xFFE8E2D3);

  final TextEditingController _searchController =
  TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  String _selectedCategory = 'All';
  String _sortBy = 'Recommended';

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
      lessons: const [
        CourseLesson(
          title: 'Introduction to Tajweed',
          duration: '12 min',
          isPreview: true,
        ),
        CourseLesson(
          title: 'Arabic Alphabet',
          duration: '15 min',
        ),
        CourseLesson(
          title: 'Makharij of Letters',
          duration: '18 min',
        ),
        CourseLesson(
          title: 'Characteristics of Letters',
          duration: '20 min',
        ),
        CourseLesson(
          title: 'Basic Tajweed Rules',
          duration: '16 min',
        ),
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
      lessons: const [
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
        CourseLesson(
          title: 'Revision Strategies',
          duration: '15 min',
        ),
        CourseLesson(
          title: 'Staying Consistent',
          duration: '12 min',
        ),
      ],
    ),
  ];

  List<Course> get _filteredCourses {
    final query = _searchController.text.trim().toLowerCase();

    final results = _courses.where((course) {
      final matchesCategory = _selectedCategory == 'All' ||
          course.category == _selectedCategory;

      final matchesSearch = query.isEmpty ||
          course.title.toLowerCase().contains(query) ||
          course.description.toLowerCase().contains(query) ||
          course.instructor.toLowerCase().contains(query) ||
          course.category.toLowerCase().contains(query);

      return matchesCategory && matchesSearch;
    }).toList();

    if (_sortBy == 'Title A–Z') {
      results.sort((a, b) => a.title.compareTo(b.title));
    } else if (_sortBy == 'Duration') {
      results.sort((a, b) => a.duration.compareTo(b.duration));
    }

    return results;
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth >= 768;
        final courses = _filteredCourses;

        return Scaffold(
          backgroundColor: cream,
          appBar: isDesktop
              ? null
              : AppBar(
            backgroundColor: Colors.white,
            foregroundColor: ink,
            elevation: 0,
            centerTitle: false,
            title: const Text(
              'Courses',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            ),
            actions: [
              IconButton(
                tooltip: 'Search courses',
                onPressed: () {
                  _searchFocusNode.requestFocus();
                },
                icon: const Icon(Icons.search_rounded),
              ),
              const SizedBox(width: 8),
            ],
            bottom: const PreferredSize(
              preferredSize: Size.fromHeight(1),
              child: Divider(
                height: 1,
                color: border,
              ),
            ),
          ),
          body: SafeArea(
            top: isDesktop,
            bottom: false,
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1120),
                child: ListView(
                  padding: EdgeInsets.fromLTRB(
                    isDesktop ? 20 : 16,
                    isDesktop ? 20 : 16,
                    isDesktop ? 20 : 16,
                    32,
                  ),
                  children: [
                    if (isDesktop) ...[
                      _buildDesktopNavbar(),
                      const SizedBox(height: 22),
                    ],
                    _buildHero(isDesktop: isDesktop),
                    SizedBox(height: isDesktop ? 18 : 20),
                    _buildToolbar(isDesktop: isDesktop),
                    SizedBox(height: isDesktop ? 26 : 22),
                    Row(
                      children: [
                        Container(
                          width: 3,
                          height: 25,
                          decoration: BoxDecoration(
                            color: gold,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Expanded(
                          child: Text(
                            'Available courses',
                            style: TextStyle(
                              color: ink,
                              fontSize: 23,
                              fontWeight: FontWeight.w800,
                              letterSpacing: -0.5,
                            ),
                          ),
                        ),
                        Text(
                          '${courses.length} courses',
                          style: const TextStyle(
                            color: muted,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    if (courses.isEmpty)
                      _buildEmptyState()
                    else
                      _buildCourseGrid(
                        courses,
                        isDesktop: isDesktop,
                      ),
                    const SizedBox(height: 16),
                    _buildComingSoon(),
                    const SizedBox(height: 18),
                    _buildFooter(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildDesktopNavbar() {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: border),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.menu_book_rounded,
            color: primary,
            size: 28,
          ),
          const SizedBox(width: 10),
          const Text(
            'Online Quran',
            style: TextStyle(
              color: ink,
              fontSize: 17,
              fontWeight: FontWeight.w800,
            ),
          ),
          const Spacer(),
          _navItem('Home', 0),
          _navItem('Quran', 1),
          _navItem('Courses', 2),
          _navItem('Profile', 3),
          const SizedBox(width: 18),
          IconButton(
            tooltip: 'Notifications',
            onPressed: () =>
                _showMessage('No new notifications.'),
            icon: const Icon(
              Icons.notifications_none_rounded,
              color: primaryDark,
            ),
          ),
          const CircleAvatar(
            radius: 18,
            backgroundColor: Color(0xFFE7F2EE),
            child: Text(
              'TA',
              style: TextStyle(
                color: primaryDark,
                fontWeight: FontWeight.w800,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _navItem(String label, int index) {
    final selected = index == 2;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      child: TextButton(
        onPressed: () => widget.onNavigate(index),
        style: TextButton.styleFrom(
          minimumSize: const Size(58, 44),
          backgroundColor: selected
              ? const Color(0xFFE7F2EE)
              : Colors.transparent,
          foregroundColor: selected ? primary : ink,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight:
            selected ? FontWeight.w800 : FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildHero({required bool isDesktop}) {
    return Container(
      constraints: BoxConstraints(
        minHeight: isDesktop ? 180 : 120,
      ),
      padding: EdgeInsets.all(isDesktop ? 28 : 18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(isDesktop ? 20 : 16),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [primary, primaryDark],
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Assalamu Alaikum',
                  style: TextStyle(
                    color: gold,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Grow your connection with the Holy Quran',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isDesktop ? 34 : 22,
                    height: 1.2,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.5,
                  ),
                ),
                if (isDesktop) ...[
                  const SizedBox(height: 8),
                  Text(
                    'Choose a course and begin your learning journey.',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.88),
                      fontSize: 15,
                    ),
                  ),
                ],
              ],
            ),
          ),
          SizedBox(width: isDesktop ? 24 : 8),
          Icon(
            Icons.menu_book_rounded,
            color: gold,
            size: isDesktop ? 82 : 46,
          ),
        ],
      ),
    );
  }

  Widget _buildToolbar({required bool isDesktop}) {
    final search = TextField(
      controller: _searchController,
      focusNode: _searchFocusNode,
      onChanged: (_) => setState(() {}),
      style: const TextStyle(color: ink, fontSize: 14),
      decoration: InputDecoration(
        hintText: 'Search courses or instructors',
        hintStyle: const TextStyle(color: muted, fontSize: 13),
        prefixIcon: const Icon(
          Icons.search_rounded,
          color: primary,
          size: 21,
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: const BorderSide(color: border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: const BorderSide(color: border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: const BorderSide(
            color: primary,
            width: 1.5,
          ),
        ),
      ),
    );

    if (!isDesktop) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 48, child: search),
          const SizedBox(height: 12),
          _buildCategoryFilters(),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerLeft,
            child: _buildSortMenu(),
          ),
        ],
      );
    }

    return Row(
      children: [
        SizedBox(width: 360, height: 48, child: search),
        const SizedBox(width: 12),
        Expanded(child: _buildCategoryFilters()),
        const SizedBox(width: 12),
        _buildSortMenu(),
      ],
    );
  }

  Widget _buildCategoryFilters() {
    const categories = ['All', 'Tajweed', 'Memorization'];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: categories.map((category) {
          final selected = category == _selectedCategory;

          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ChoiceChip(
              label: Text(category),
              selected: selected,
              onSelected: (_) {
                setState(() => _selectedCategory = category);
              },
              showCheckmark: false,
              labelStyle: TextStyle(
                color: selected ? Colors.white : ink,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
              selectedColor: primary,
              backgroundColor: Colors.white,
              side: BorderSide(
                color: selected ? primary : border,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 6,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSortMenu() {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: border),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _sortBy,
          borderRadius: BorderRadius.circular(12),
          style: const TextStyle(color: ink, fontSize: 13),
          items: const [
            DropdownMenuItem(
              value: 'Recommended',
              child: Text('Sort: Recommended'),
            ),
            DropdownMenuItem(
              value: 'Title A–Z',
              child: Text('Sort: Title A–Z'),
            ),
            DropdownMenuItem(
              value: 'Duration',
              child: Text('Sort: Duration'),
            ),
          ],
          onChanged: (value) {
            if (value != null) {
              setState(() => _sortBy = value);
            }
          },
        ),
      ),
    );
  }

  Widget _buildCourseGrid(
      List<Course> courses, {
        required bool isDesktop,
      }) {
    if (!isDesktop) {
      return Column(
        children: courses.map((course) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: CourseCard(
              course: course,
              onTap: () => _openCourse(course),
            ),
          );
        }).toList(),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final cardWidth = (constraints.maxWidth - 24) / 2;

        return Wrap(
          spacing: 24,
          runSpacing: 16,
          children: courses.map((course) {
            return SizedBox(
              width: cardWidth,
              child: CourseCard(
                course: course,
                onTap: () => _openCourse(course),
              ),
            );
          }).toList(),
        );
      },
    );
  }

  void _openCourse(Course course) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CourseDetailsScreen(course: course),
      ),
    );
  }

  Widget _buildComingSoon() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 22,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFFAF6EA),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFD9D0BA)),
      ),
      child: const Column(
        children: [
          Icon(
            Icons.auto_stories_outlined,
            size: 30,
            color: primary,
          ),
          SizedBox(height: 10),
          Text(
            'More courses coming soon',
            style: TextStyle(
              color: ink,
              fontSize: 16,
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(height: 5),
          Text(
            "We're adding new courses regularly.",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: muted,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: border),
      ),
      child: const Column(
        children: [
          Icon(
            Icons.search_off_rounded,
            size: 42,
            color: muted,
          ),
          SizedBox(height: 12),
          Text(
            'No courses found',
            style: TextStyle(
              color: ink,
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(height: 6),
          Text(
            'Try another search or choose a different category.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: muted,
              fontSize: 13,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(
            child: Text(
              'Online Quran  •  Learn  •  Grow',
              style: TextStyle(color: muted, fontSize: 12),
            ),
          ),
          Text(
            'Learn with purpose',
            style: TextStyle(color: muted, fontSize: 12),
          ),
        ],
      ),
    );
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
