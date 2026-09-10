import 'package:flutter/material.dart';
import '../../../../core/theme/portfolio_theme.dart';
import '../../domain/entities/project.dart';
import 'external_link.dart';

class ProjectCard extends StatefulWidget {
  const ProjectCard({required this.project, super.key});
  final Project project;
  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool hovered = false;
  @override
  Widget build(BuildContext context) {
    final p = widget.project;
    final color = switch (p.repository) {
      'volt_net' => PortfolioTheme.accent,
      'LARA_Ai_Chatbot' => const Color(0xFFC5B3FA),
      'mangabrhub' => const Color(0xFFF0B18B),
      _ => const Color(0xFF9FCBF5),
    };
    return MouseRegion(
      onEnter: (_) => setState(() => hovered = true),
      onExit: (_) => setState(() => hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        decoration: BoxDecoration(
          color: PortfolioTheme.surface,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: hovered ? color : PortfolioTheme.border),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () => _details(context, p),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 195,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      color.withValues(alpha: .15),
                      PortfolioTheme.surface,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: 20,
                      left: 22,
                      child: Text(
                        p.highlight,
                        style: TextStyle(
                          color: color,
                          fontSize: 10,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        switch (p.repository) {
                          'volt_net' => 'ϟ volt_net',
                          'LARA_Ai_Chatbot' => 'lara*',
                          'mangabrhub' => 'MANGA / BR',
                          _ => 'party:u',
                        },
                        style: TextStyle(
                          fontSize: 42,
                          color: color,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -2,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 18,
                      right: 22,
                      child: Icon(
                        switch (p.repository) {
                          'volt_net' => Icons.bolt,
                          'LARA_Ai_Chatbot' => Icons.auto_awesome,
                          'mangabrhub' => Icons.auto_stories_outlined,
                          _ => Icons.hub_outlined,
                        },
                        color: color.withValues(alpha: .45),
                        size: 28,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            p.name,
                            style: const TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        const Icon(Icons.north_east, size: 20),
                      ],
                    ),
                    const SizedBox(height: 9),
                    Text(
                      p.description,
                      style: const TextStyle(color: PortfolioTheme.muted),
                    ),
                    const SizedBox(height: 20),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: p.tags
                          .map(
                            (tag) => Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: PortfolioTheme.border,
                                ),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Text(
                                tag,
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: PortfolioTheme.muted,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _details(BuildContext context, Project p) => showDialog<void>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text(p.name),
      content: SizedBox(
        width: 490,
        child: SingleChildScrollView(child: Text(p.details)),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(ctx),
          child: const Text('Fechar'),
        ),
        FilledButton.icon(
          onPressed: () => openExternal(
            ctx,
            'https://github.com/felippe-flutter-dev/${p.repository}',
          ),
          icon: const Icon(Icons.north_east, size: 18),
          label: const Text('Ver repositório'),
        ),
      ],
    ),
  );
}
