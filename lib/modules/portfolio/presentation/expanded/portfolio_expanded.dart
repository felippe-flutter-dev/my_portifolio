import 'package:flutter/material.dart';
import '../../../../core/theme/portfolio_theme.dart';
import '../../domain/entities/project.dart';
import '../widgets/hero_content.dart';
import '../widgets/project_card.dart';
import '../widgets/project_filters.dart';
import '../widgets/section_heading.dart';
import '../widgets/experience_section.dart';
import '../widgets/education_section.dart';
import 'about_expanded.dart';
import '../widgets/contact_section.dart';

class PortfolioExpanded extends StatefulWidget {
  const PortfolioExpanded({
    required this.projects,
    required this.category,
    required this.onCategory,
    super.key,
  });
  final List<Project> projects;
  final String category;
  final ValueChanged<String> onCategory;
  @override
  State<PortfolioExpanded> createState() => _PortfolioExpandedState();
}

class _PortfolioExpandedState extends State<PortfolioExpanded> {
  final projectsKey = GlobalKey();
  final aboutKey = GlobalKey();
  final contactKey = GlobalKey();
  void go(GlobalKey key) => Scrollable.ensureVisible(
    key.currentContext!,
    duration: MediaQuery.disableAnimationsOf(context)
        ? Duration.zero
        : const Duration(milliseconds: 500),
    curve: Curves.easeInOut,
  );
  @override
  Widget build(BuildContext context) => Scaffold(
    body: SelectionArea(
      child: SingleChildScrollView(
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 1240),
            padding: const EdgeInsets.symmetric(horizontal: 48),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 28),
                  child: Row(
                    children: [
                      const Text(
                        'felippe',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -1,
                        ),
                      ),
                      const Text(
                        '.',
                        style: TextStyle(
                          fontSize: 30,
                          color: PortfolioTheme.accent,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () => go(projectsKey),
                        child: const Text('Projetos'),
                      ),
                      TextButton(
                        onPressed: () => go(aboutKey),
                        child: const Text('Sobre mim'),
                      ),
                      const SizedBox(width: 20),
                      OutlinedButton(
                        onPressed: () => go(contactKey),
                        child: const Text('Vamos conversar ↗'),
                      ),
                    ],
                  ),
                ),
                const Divider(height: 1),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 76),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 6,
                        child: HeroContent(
                          titleSize: 60,
                          onProjects: () => go(projectsKey),
                        ),
                      ),
                      const SizedBox(width: 48),
                      const Expanded(flex: 4, child: _CreativeNote()),
                    ],
                  ),
                ),
                const Divider(),
                const SizedBox(height: 60),
                SectionHeading('01', 'Projetos selecionados', key: projectsKey),
                const Text(
                  'Ideias pessoais, problemas reais e engenharia na prática.',
                  style: TextStyle(color: PortfolioTheme.muted),
                ),
                const SizedBox(height: 22),
                ProjectFilters(
                  selected: widget.category,
                  onSelected: widget.onCategory,
                ),
                LayoutBuilder(
                  builder: (context, constraints) => Wrap(
                    spacing: 24,
                    runSpacing: 24,
                    children: widget.projects
                        .map(
                          (p) => SizedBox(
                            width: (constraints.maxWidth - 24) / 2,
                            child: ProjectCard(project: p),
                          ),
                        )
                        .toList(),
                  ),
                ),
                const SizedBox(height: 90),
                const Divider(),
                const SizedBox(height: 70),
                AboutExpanded(key: aboutKey),
                const SizedBox(height: 80),
                const ExperienceSection(),
                const SizedBox(height: 40),
                const EducationSection(),
                const SizedBox(height: 48),
                ContactSection(key: contactKey),
                const PortfolioFooter(),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

class _CreativeNote extends StatelessWidget {
  const _CreativeNote();
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(32),
    decoration: BoxDecoration(
      color: PortfolioTheme.surface,
      border: Border.all(color: PortfolioTheme.border),
      borderRadius: BorderRadius.circular(24),
    ),
    child: const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.data_object, color: PortfolioTheme.accent, size: 48),
        SizedBox(height: 48),
        Text(
          'DA IDEIA AO MUNDO',
          style: TextStyle(
            color: PortfolioTheme.accent,
            fontSize: 11,
            letterSpacing: 2,
          ),
        ),
        SizedBox(height: 16),
        Text(
          'Aplicações.\nMúsicas.\nUniversos.',
          style: TextStyle(
            fontSize: 34,
            height: 1.3,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 24),
        Text(
          'Diferentes formas de fazer uma ideia existir.',
          style: TextStyle(color: PortfolioTheme.muted),
        ),
      ],
    ),
  );
}
