import 'package:flutter/material.dart';
import '../../../../core/theme/portfolio_theme.dart';
import 'section_heading.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});
  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const SectionHeading('02', 'Além da interface'),
      const Text(
        'O cuidado que você vê na tela começa na arquitetura.',
        style: TextStyle(
          fontSize: 26,
          height: 1.3,
          fontWeight: FontWeight.w600,
        ),
      ),
      const SizedBox(height: 20),
      const Text(
        'Atuo do desenho da solução à evolução de aplicações em produção. Minha especialidade é Flutter, com experiência em Kotlin, Android e Jetpack Compose. Gosto de construir sistemas que continuam funcionando quando a rede falha — e código que continua claro quando o produto cresce.',
        style: TextStyle(color: PortfolioTheme.muted, height: 1.8),
      ),
      const SizedBox(height: 24),
      Wrap(
        spacing: 10,
        runSpacing: 10,
        children:
            [
                  'Flutter & Dart',
                  'Kotlin & Compose',
                  'Clean Architecture',
                  'BLoC / Cubit',
                  'Offline-first',
                  'TDD & CI/CD',
                  'Mentoria técnica',
                ]
                .map(
                  (s) => Chip(
                    label: Text(s, style: const TextStyle(fontSize: 12)),
                    side: const BorderSide(color: PortfolioTheme.border),
                  ),
                )
                .toList(),
      ),
      const SizedBox(height: 28),
      const Divider(),
      const SizedBox(height: 20),
      const Text(
        'FORMAÇÃO',
        style: TextStyle(
          color: PortfolioTheme.accent,
          fontSize: 11,
          letterSpacing: 2,
        ),
      ),
      const SizedBox(height: 12),
      const Text(
        'Engenharia da Computação · UFBRA',
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
      const Text(
        '2025–2030 · Em andamento',
        style: TextStyle(color: PortfolioTheme.muted, fontSize: 13),
      ),
      const SizedBox(height: 12),
      const Text(
        'Técnico em Informática · FAETEC',
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
      const Text(
        '2019–2021',
        style: TextStyle(color: PortfolioTheme.muted, fontSize: 13),
      ),
      const SizedBox(height: 20),
      const Text(
        'Português nativo · Inglês B1 · Espanhol B1',
        style: TextStyle(color: PortfolioTheme.muted, fontSize: 12),
      ),
    ],
  );
}
