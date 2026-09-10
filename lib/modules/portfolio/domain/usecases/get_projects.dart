import '../entities/project.dart';
import '../repositories/project_repository.dart';

class GetProjects {
  const GetProjects(this.repository);
  final ProjectRepository repository;
  List<Project> call() => repository.getProjects();
}
