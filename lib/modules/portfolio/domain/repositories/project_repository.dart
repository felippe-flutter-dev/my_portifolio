import '../entities/project.dart';

abstract interface class ProjectRepository {
  List<Project> getProjects();
}
