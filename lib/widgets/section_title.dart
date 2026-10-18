import 'package:flutter/material.dart';

const Color appEmerald = Color(0xFF126B50);
const Color appCream = Color(0xFFFFFCF5);
const Color appGold = Color(0xFFE4C477);
const Color appInk = Color(0xFF24352D);
const Color appMuted = Color(0xFF778078);

class SectionTitle extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String? actionText;
  final VoidCallback? onActionTap;

  const SectionTitle({
    super.key,
    required this.title,
    this.subtitle,
    this.actionText,
    this.onActionTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 4,
          constraints: const BoxConstraints(minHeight: 30),
          margin: const EdgeInsets.only(top: 3, right: 12),
          decoration: BoxDecoration(
            color: appGold,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: appInk,
                  fontSize: 21,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.4,
                  height: 1.3,
                ),
              ),
              if (subtitle != null && subtitle!.trim().isNotEmpty) ...[
                const SizedBox(height: 6),
                Text(
                  subtitle!,
                  style: const TextStyle(
                    color: appMuted,
                    fontSize: 13,
                    height: 1.55,
                  ),
                ),
              ],
            ],
          ),
        ),
        if (actionText != null && actionText!.trim().isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: TextButton(
              onPressed: onActionTap,
              style: TextButton.styleFrom(
                foregroundColor: appEmerald,
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 8,
                ),
                minimumSize: const Size(44, 44),
                tapTargetSize: MaterialTapTargetSize.padded,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                actionText!,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
      ],
    );
  }
}