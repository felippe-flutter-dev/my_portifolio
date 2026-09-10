import 'package:flutter/material.dart';
import '../../../../core/theme/portfolio_theme.dart';

class SectionHeading extends StatelessWidget {
  const SectionHeading(this.number, this.title, {super.key});
  final String number, title;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 28),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$number / $title'.toUpperCase(),
          style: const TextStyle(
            color: PortfolioTheme.accent,
            fontSize: 12,
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 14),
        Text(
          title,
          style: const TextStyle(
            fontSize: 34,
            fontWeight: FontWeight.w700,
            letterSpacing: -1,
          ),
        ),
      ],
    ),
  );
}
