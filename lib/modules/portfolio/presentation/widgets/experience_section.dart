import 'package:flutter/material.dart';
import '../../../../core/theme/portfolio_theme.dart';
import 'section_heading.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});
  @override
  Widget build(BuildContext context) => const Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SectionHeading('03', 'Trajetória'),
      _Experience(
        'DEZ 2025 — PRESENTE',
        'Founding Mobile Engineer',
        'EcoEnergiza',
        'Desenvolvimento da aplicação mobile desde a concepção, com definição de arquitetura, componentes nativos Android e integração com APIs de monitoramento energético. Atuação no roadmap tecnológico, automação de deploy, mentoria e definição de padrões técnicos.',
      ),
      _Experience(
        'FEV 2025 — AGO 2025',
        'Desenvolvedor Flutter Sênior',
        'Eyecare Health',
        'Desenvolvimento dos apps EyecareBI e Oculli em Flutter. Migração do EyecareBI de Next.js para Flutter e construção do Oculli do zero. Foco em acessibilidade e confiabilidade, com evolução de arquitetura, testes automatizados, revisão de código e mentoria.',
      ),
      _Experience(
        'FEV 2021 — DEZ 2024',
        'Desenvolvedor Flutter Pleno',
        'SRM Asset',
        'Desenvolvimento de app de fintech em Flutter, com transferências TED, assinatura digital via certificado digital e face scan. Integrações REST, componentes Android em Kotlin, refatoração e testes com Mockito.',
      ),
    ],
  );
}

class _Experience extends StatelessWidget {
  const _Experience(this.date, this.role, this.company, this.description);
  final String date, role, company, description;
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.only(left: 23, bottom: 34),
    decoration: const BoxDecoration(
      border: Border(left: BorderSide(color: PortfolioTheme.border)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          date,
          style: const TextStyle(
            color: PortfolioTheme.accent,
            fontSize: 10,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          role,
          style: const TextStyle(fontSize: 21, fontWeight: FontWeight.w600),
        ),
        Text(company, style: const TextStyle(color: PortfolioTheme.muted)),
        const SizedBox(height: 14),
        Text(
          description,
          style: const TextStyle(
            color: PortfolioTheme.muted,
            fontSize: 14,
            height: 1.7,
          ),
        ),
      ],
    ),
  );
}
