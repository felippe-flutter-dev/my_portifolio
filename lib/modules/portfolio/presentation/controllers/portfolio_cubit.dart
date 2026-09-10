import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/project.dart';
import '../../domain/usecases/get_projects.dart';

class PortfolioState {
  const PortfolioState(this.projects, {this.category = 'Todos'});
  final List<Project> projects;
  final String category;
  List<Project> get visibleProjects => category == 'Todos'
      ? projects
      : projects.where((p) => p.category == category).toList();
}

class PortfolioCubit extends Cubit<PortfolioState> {
  PortfolioCubit(GetProjects getProjects)
    : super(PortfolioState(getProjects()));
  void selectCategory(String category) =>
      emit(PortfolioState(state.projects, category: category));
}
