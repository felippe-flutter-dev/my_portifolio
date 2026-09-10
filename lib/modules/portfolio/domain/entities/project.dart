class Project {
  const Project({
    required this.name,
    required this.category,
    required this.description,
    required this.tags,
    required this.repository,
    required this.highlight,
    required this.details,
    this.articleUrl,
  });
  final String name, category, description, repository, highlight, details;
  final List<String> tags;
  final String? articleUrl;
}
