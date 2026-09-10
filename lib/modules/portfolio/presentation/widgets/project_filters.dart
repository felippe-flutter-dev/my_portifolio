import 'package:flutter/material.dart';

class ProjectFilters extends StatelessWidget {
  const ProjectFilters({
    required this.selected,
    required this.onSelected,
    super.key,
  });
  final String selected;
  final ValueChanged<String> onSelected;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 24),
    child: Wrap(
      spacing: 10,
      runSpacing: 8,
      children: ['Todos', 'Flutter', 'Web', 'Backend']
          .map(
            (category) => ChoiceChip(
              label: Text(category),
              selected: category == selected,
              onSelected: (_) => onSelected(category),
            ),
          )
          .toList(),
    ),
  );
}
