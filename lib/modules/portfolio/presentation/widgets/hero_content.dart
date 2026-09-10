import 'package:flutter/material.dart';
import '../../../../core/theme/portfolio_theme.dart';
import 'external_link.dart';

class HeroContent extends StatelessWidget {
  const HeroContent({
    required this.titleSize,
    required this.onProjects,
    super.key,
  });
  final double titleSize;
  final VoidCallback onProjects;
  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        'FLUTTER DEVELOPER  /  RIO DE JANEIRO',
        style: TextStyle(
          color: PortfolioTheme.accent,
          fontSize: 11,
          letterSpacing: 2,
        ),
      ),
      const SizedBox(height: 28),
      Text(
        'Código sólido.\nExperiências',
        style: TextStyle(
          fontSize: titleSize,
          height: 1.06,
          fontWeight: FontWeight.w800,
          letterSpacing: -2.6,
        ),
      ),
      Text(
        'memoráveis.',
        style: TextStyle(
          fontSize: titleSize,
          height: 1.1,
          fontWeight: FontWeight.w800,
          letterSpacing: -2.6,
          color: PortfolioTheme.accent,
        ),
      ),
      const SizedBox(height: 28),
      const Text(
        'Sou Felippe Pinheiro, desenvolvedor Flutter sênior. Transformo desafios complexos em aplicações fluidas, resilientes e feitas para evoluir.',
        style: TextStyle(
          color: PortfolioTheme.muted,
          fontSize: 17,
          height: 1.7,
        ),
      ),
      const SizedBox(height: 30),
      Wrap(
        spacing: 12,
        runSpacing: 12,
        children: [
          FilledButton.icon(
            onPressed: onProjects,
            label: const Text('Explorar projetos'),
            icon: const Icon(Icons.arrow_downward, size: 18),
          ),
          OutlinedButton(
            onPressed: () =>
                openExternal(context, 'mailto:felippehouse@gmail.com'),
            child: const Text('Vamos conversar ↗'),
          ),
        ],
      ),
      const SizedBox(height: 34),
      const Text(
        'FLUTTER  ·  KOTLIN  ·  CLEAN ARCHITECTURE',
        style: TextStyle(
          fontSize: 10,
          letterSpacing: 1.5,
          color: PortfolioTheme.muted,
        ),
      ),
    ],
  );
}
