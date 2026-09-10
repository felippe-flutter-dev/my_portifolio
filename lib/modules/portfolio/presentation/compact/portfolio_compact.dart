import 'package:flutter/material.dart';
import '../../../../core/theme/portfolio_theme.dart';
import '../../domain/entities/project.dart';
import '../widgets/hero_content.dart';
import '../widgets/project_card.dart';
import '../widgets/project_filters.dart';
import '../widgets/section_heading.dart';
import '../widgets/experience_section.dart';
import '../widgets/education_section.dart';
import 'about_compact.dart';
import '../widgets/contact_section.dart';

class PortfolioCompact extends StatefulWidget {
  const PortfolioCompact({
    required this.projects,
    required this.category,
    required this.onCategory,
    super.key,
  });
  final List<Project> projects;
  final String category;
  final ValueChanged<String> onCategory;
  @override
  State<PortfolioCompact> createState() => _PortfolioCompactState();
}

class _PortfolioCompactState extends State<PortfolioCompact> {
  final projectsKey = GlobalKey();
  final aboutKey = GlobalKey();
  final contactKey = GlobalKey();
  int destination = 0;
  void go(int index) {
    setState(() => destination = index);
    final key = [projectsKey, aboutKey, contactKey][index];
    Scrollable.ensureVisible(
      key.currentContext!,
      duration: MediaQuery.disableAnimationsOf(context)
          ? Duration.zero
          : const Duration(milliseconds: 450),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    bottomNavigationBar: NavigationBar(
      selectedIndex: destination,
      onDestinationSelected: go,
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.grid_view_outlined),
          label: 'Projetos',
        ),
        NavigationDestination(icon: Icon(Icons.person_outline), label: 'Sobre'),
        NavigationDestination(
          icon: Icon(Icons.chat_bubble_outline),
          label: 'Contato',
        ),
      ],
    ),
    body: SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 24),
                child: Row(
                  children: [
                    Text(
                      'felippe.',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Spacer(),
                    Icon(Icons.code, color: PortfolioTheme.accent),
                  ],
                ),
              ),
              const Divider(height: 1),
              const SizedBox(height: 42),
              HeroContent(titleSize: 43, onProjects: () => go(0)),
              const SizedBox(height: 60),
              SectionHeading('01', 'Projetos selecionados', key: projectsKey),
              ProjectFilters(
                selected: widget.category,
                onSelected: widget.onCategory,
              ),
              ...widget.projects.map(
                (p) => Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: ProjectCard(project: p),
                ),
              ),
              const SizedBox(height: 42),
              AboutCompact(key: aboutKey),
              const SizedBox(height: 54),
              const ExperienceSection(),
              const SizedBox(height: 40),
              const EducationSection(),
              const SizedBox(height: 30),
              ContactSection(key: contactKey),
              const PortfolioFooter(),
            ],
          ),
        ),
      ),
    ),
  );
}
