import 'package:flutter/material.dart';

const Color _green = Color(0xFF174D3A);
const Color _cream = Color(0xFFFAF7EF);
const Color _gold = Color(0xFFC99A35);
const Color _text = Color(0xFF26352D);
const Color _muted = Color(0xFF78847B);

class TeacherProfileScreen extends StatefulWidget {
  const TeacherProfileScreen({super.key});

  @override
  State<TeacherProfileScreen> createState() =>
      _TeacherProfileScreenState();
}

class _TeacherProfileScreenState extends State<TeacherProfileScreen> {
  String _name = 'Muhammad Tayyab';
  String _email = 'teacher@nooracademy.com';
  String _phone = '+92 300 1234567';
  String _qualification = 'M.A. Islamic Studies';
  String _experience = '5 years';
  String _bio =
      'Dedicated Quran teacher helping students improve recitation, '
      'understand Tajweed, and build a consistent connection with the Quran.';

  final List<String> _subjects = [
    'Quran Reading',
    'Tajweed',
    'Hifz',
    'Arabic Basics',
  ];

  Future<void> _editProfile() async {
    final nameController = TextEditingController(text: _name);
    final emailController = TextEditingController(text: _email);
    final phoneController = TextEditingController(text: _phone);
    final qualificationController =
    TextEditingController(text: _qualification);
    final experienceController =
    TextEditingController(text: _experience);
    final bioController = TextEditingController(text: _bio);

    final formKey = GlobalKey<FormState>();

    final result = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: _cream,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
          title: const Text(
            'Edit Teacher Profile',
            style: TextStyle(
              color: _green,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: SizedBox(
            width: 420,
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildTextField(
                      controller: nameController,
                      label: 'Full name',
                      icon: Icons.person_outline_rounded,
                    ),
                    _buildTextField(
                      controller: emailController,
                      label: 'Email address',
                      icon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null ||
                            !value.contains('@') ||
                            !value.contains('.')) {
                          return 'Enter a valid email address';
                        }
                        return null;
                      },
                    ),
                    _buildTextField(
                      controller: phoneController,
                      label: 'Phone number',
                      icon: Icons.phone_outlined,
                      keyboardType: TextInputType.phone,
                    ),
                    _buildTextField(
                      controller: qualificationController,
                      label: 'Qualification',
                      icon: Icons.school_outlined,
                    ),
                    _buildTextField(
                      controller: experienceController,
                      label: 'Teaching experience',
                      icon: Icons.workspace_premium_outlined,
                    ),
                    _buildTextField(
                      controller: bioController,
                      label: 'Short introduction',
                      icon: Icons.notes_rounded,
                      maxLines: 3,
                    ),
                  ],
                ),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, false),
              child: const Text(
                'Cancel',
                style: TextStyle(color: _muted),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate() &&
                    nameController.text.trim().isNotEmpty) {
                  Navigator.pop(dialogContext, true);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: _green,
                foregroundColor: Colors.white,
              ),
              child: const Text('Save changes'),
            ),
          ],
        );
      },
    );

    if (!mounted) {
      nameController.dispose();
      emailController.dispose();
      phoneController.dispose();
      qualificationController.dispose();
      experienceController.dispose();
      bioController.dispose();
      return;
    }

    if (result == true) {
      setState(() {
        _name = nameController.text.trim();
        _email = emailController.text.trim();
        _phone = phoneController.text.trim();
        _qualification = qualificationController.text.trim();
        _experience = experienceController.text.trim();
        _bio = bioController.text.trim();
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Profile updated successfully.'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }

    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    qualificationController.dispose();
    experienceController.dispose();
    bioController.dispose();
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        validator: validator ??
                (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter $label';
              }
              return null;
            },
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: _green, size: 20),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(13),
            borderSide: const BorderSide(color: Color(0xFFE4E2D8)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(13),
            borderSide: const BorderSide(color: Color(0xFFE4E2D8)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(13),
            borderSide: const BorderSide(color: _green, width: 1.5),
          ),
        ),
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
                    padding: const EdgeInsets.fromLTRB(20, 18, 20, 28),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildProfileHero(),
                        const SizedBox(height: 25),
                        _buildSectionHeading(
                          'Personal Information',
                          'Your teacher account details',
                        ),
                        const SizedBox(height: 14),
                        _buildPersonalInfo(),
                        const SizedBox(height: 25),
                        _buildSectionHeading(
                          'Teaching Subjects',
                          'Areas you teach at Noor Academy',
                        ),
                        const SizedBox(height: 14),
                        _buildSubjects(),
                        const SizedBox(height: 25),
                        _buildSectionHeading(
                          'Teaching Overview',
                          'A snapshot of your teaching activity',
                        ),
                        const SizedBox(height: 14),
                        _buildTeachingOverview(),
                        const SizedBox(height: 25),
                        _buildSectionHeading(
                          'About Me',
                          'Your teaching philosophy',
                        ),
                        const SizedBox(height: 14),
                        _buildBioCard(),
                        const SizedBox(height: 24),
                        _buildEditButton(),
                        const SizedBox(height: 18),
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
              'MY PROFILE',
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

  Widget _buildProfileHero() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: _green,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          Container(
            height: 94,
            width: 94,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: _gold, width: 3),
            ),
            child: const Icon(
              Icons.person_rounded,
              color: _green,
              size: 55,
            ),
          ),
          const SizedBox(height: 15),
          Text(
            _name,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 23,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Quran & Islamic Studies Teacher',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.85),
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(22),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.18),
              ),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.verified_rounded,
                  color: _gold,
                  size: 17,
                ),
                SizedBox(width: 7),
                Text(
                  'Teacher Account',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeading(String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: _green,
            fontSize: 19,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: const TextStyle(
            color: _muted,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildPersonalInfo() {
    return Container(
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: const Color(0xFFECE9DF)),
      ),
      child: Column(
        children: [
          _buildInfoRow(
            Icons.email_outlined,
            'Email address',
            _email,
          ),
          const Divider(height: 25, color: Color(0xFFECE9DF)),
          _buildInfoRow(
            Icons.phone_outlined,
            'Phone number',
            _phone,
          ),
          const Divider(height: 25, color: Color(0xFFECE9DF)),
          _buildInfoRow(
            Icons.school_outlined,
            'Qualification',
            _qualification,
          ),
          const Divider(height: 25, color: Color(0xFFECE9DF)),
          _buildInfoRow(
            Icons.workspace_premium_outlined,
            'Experience',
            _experience,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(
      IconData icon,
      String label,
      String value,
      ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            color: _cream,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: _green, size: 20),
        ),
        const SizedBox(width: 12),
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
              const SizedBox(height: 5),
              Text(
                value,
                style: const TextStyle(
                  color: _text,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSubjects() {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: _subjects.map((subject) {
        return Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 11,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(13),
            border: Border.all(color: const Color(0xFFE5E2D7)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.check_circle_rounded,
                color: _green,
                size: 17,
              ),
              const SizedBox(width: 7),
              Text(
                subject,
                style: const TextStyle(
                  color: _text,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildTeachingOverview() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = constraints.maxWidth < 400 ? 2 : 3;
        const spacing = 10.0;
        final cardWidth =
            (constraints.maxWidth - spacing * (columns - 1)) / columns;

        final stats = [
          {
            'label': 'Students',
            'value': '48',
            'icon': Icons.people_alt_rounded,
          },
          {
            'label': 'Courses',
            'value': '4',
            'icon': Icons.menu_book_rounded,
          },
          {
            'label': 'Experience',
            'value': _experience,
            'icon': Icons.workspace_premium_rounded,
          },
        ];

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: stats.map((stat) {
            return Container(
              width: cardWidth,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(17),
                border: Border.all(color: const Color(0xFFECE9DF)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    stat['icon'] as IconData,
                    color: _green,
                    size: 22,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    stat['value'] as String,
                    style: const TextStyle(
                      color: _text,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    stat['label'] as String,
                    style: const TextStyle(
                      color: _muted,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        );
      },
    );
  }

  Widget _buildBioCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: const Color(0xFFECE9DF)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.format_quote_rounded,
            color: _gold,
            size: 28,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              _bio,
              style: const TextStyle(
                color: _text,
                fontSize: 13,
                height: 1.7,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEditButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: _editProfile,
        icon: const Icon(Icons.edit_rounded),
        label: const Text('Edit Profile'),
        style: ElevatedButton.styleFrom(
          backgroundColor: _green,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
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
              'Demo mode: profile edits are temporary and remain only in this screen state. Authentication and database storage are not connected.',
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