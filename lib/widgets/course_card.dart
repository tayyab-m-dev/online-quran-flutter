
import 'package:flutter/material.dart';
import 'section_title.dart';

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

@override
Widget build(BuildContext context) {
return Card(
color: Colors.white,
elevation: 0,
margin: const EdgeInsets.only(bottom: 20),
shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(22),
side: const BorderSide(
color: Color(0xFFE8E5DA),
width: 1,
),
),
clipBehavior: Clip.antiAlias,
child: InkWell(
onTap: onTap,
borderRadius: BorderRadius.circular(22),
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
_buildCourseHeader(),
Padding(
padding: const EdgeInsets.fromLTRB(20, 18, 20, 18),
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Text(
course.description,
maxLines: 3,
overflow: TextOverflow.ellipsis,
style: const TextStyle(
color: appMuted,
fontSize: 14,
height: 1.6,
),
),
const SizedBox(height: 18),

// Instructor and lesson information.
Row(
children: [
Container(
width: 38,
height: 38,
decoration: BoxDecoration(
color: appCream,
borderRadius: BorderRadius.circular(13),
),
child: const Icon(
Icons.person_outline_rounded,
color: appEmerald,
size: 21,
),
),
const SizedBox(width: 11),
Expanded(
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
const Text(
'INSTRUCTOR',
style: TextStyle(
color: appMuted,
fontSize: 10,
letterSpacing: 1,
fontWeight: FontWeight.w700,
),
),
const SizedBox(height: 3),
Text(
course.instructor,
maxLines: 1,
overflow: TextOverflow.ellipsis,
style: const TextStyle(
color: appInk,
fontSize: 13,
fontWeight: FontWeight.w700,
),
),
],
),
),
const SizedBox(width: 8),
Container(
padding: const EdgeInsets.symmetric(
horizontal: 10,
vertical: 9,
),
decoration: BoxDecoration(
color: appCream,
borderRadius: BorderRadius.circular(12),
),
child: Row(
mainAxisSize: MainAxisSize.min,
children: [
const Icon(
Icons.play_lesson_rounded,
color: appEmerald,
size: 17,
),
const SizedBox(width: 5),
Text(
'${course.lessonCount} lessons',
style: const TextStyle(
color: appInk,
fontSize: 11,
fontWeight: FontWeight.w600,
),
),
],
),
),
],
),

const Padding(
padding: EdgeInsets.symmetric(vertical: 18),
child: Divider(
height: 1,
color: Color(0xFFEAE8DF),
),
),

// Course level, duration, and action.
Row(
children: [
const Icon(
Icons.signal_cellular_alt_rounded,
color: appEmerald,
size: 18,
),
const SizedBox(width: 6),
Flexible(
child: Text(
course.level,
maxLines: 1,
overflow: TextOverflow.ellipsis,
style: const TextStyle(
color: appMuted,
fontSize: 12,
fontWeight: FontWeight.w600,
),
),
),
const SizedBox(width: 14),
const Icon(
Icons.schedule_rounded,
color: appEmerald,
size: 17,
),
const SizedBox(width: 6),
Expanded(
child: Text(
course.duration,
maxLines: 1,
overflow: TextOverflow.ellipsis,
style: const TextStyle(
color: appMuted,
fontSize: 12,
fontWeight: FontWeight.w600,
),
),
),
const SizedBox(width: 8),
Container(
width: 38,
height: 38,
decoration: BoxDecoration(
color: appEmerald,
borderRadius: BorderRadius.circular(13),
),
child: const Icon(
Icons.arrow_forward_rounded,
color: Colors.white,
size: 20,
),
),
],
),
],
),
),
],
),
),
);
}

Widget _buildCourseHeader() {
return Container(
width: double.infinity,
constraints: const BoxConstraints(minHeight: 150),
padding: const EdgeInsets.all(22),
decoration: BoxDecoration(
gradient: LinearGradient(
begin: Alignment.topLeft,
end: Alignment.bottomRight,
colors: [
appEmerald,
appEmerald.withValues(alpha: 0.88),
const Color(0xFF164E40),
],
),
),
child: Stack(
children: [
Positioned(
right: -8,
top: -12,
child: Icon(
Icons.auto_awesome,
size: 105,
color: Colors.white.withValues(alpha: 0.055),
),
),
Row(
crossAxisAlignment: CrossAxisAlignment.center,
children: [
Expanded(
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
mainAxisSize: MainAxisSize.min,
children: [
Container(
padding: const EdgeInsets.symmetric(
horizontal: 11,
vertical: 6,
),
decoration: BoxDecoration(
color: appGold.withValues(alpha: 0.16),
borderRadius: BorderRadius.circular(30),
border: Border.all(
color: appGold.withValues(alpha: 0.42),
),
),
child: Text(
course.category.toUpperCase(),
style: const TextStyle(
color: appGold,
fontSize: 10,
letterSpacing: 1.1,
fontWeight: FontWeight.w800,
),
),
),
const SizedBox(height: 14),
Text(
course.title,
maxLines: 3,
overflow: TextOverflow.ellipsis,
style: const TextStyle(
color: Colors.white,
fontSize: 21,
height: 1.3,
fontWeight: FontWeight.w800,
letterSpacing: -0.3,
),
),
const SizedBox(height: 8),
const Text(
'Learn • Reflect • Grow',
style: TextStyle(
color: Color(0xFFD8E8DF),
fontSize: 12,
letterSpacing: 0.3,
),
),
],
),
),
const SizedBox(width: 14),
Container(
width: 68,
height: 68,
decoration: BoxDecoration(
color: Colors.white.withValues(alpha: 0.09),
borderRadius: BorderRadius.circular(22),
border: Border.all(
color: Colors.white.withValues(alpha: 0.15),
),
),
child: Icon(
course.icon,
size: 37,
color: appGold,
),
),
],
),
],
),
);
}
}
