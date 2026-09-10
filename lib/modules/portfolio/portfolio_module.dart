import 'package:flutter_modular/flutter_modular.dart';
import 'data/repositories/local_project_repository.dart';
import 'domain/repositories/project_repository.dart';
import 'domain/usecases/get_projects.dart';
import 'presentation/controllers/portfolio_cubit.dart';
import 'presentation/portfolio_presentation.dart';

final portfolioModule = createModule(
  register: (c) {
    c.addSingleton<ProjectRepository>(LocalProjectRepository.new);
    c.add<GetProjects>(GetProjects.new);
    c.route(
      '/',
      child: (context, state) => PortfolioPresentation(
        createController: () => PortfolioCubit(inject<GetProjects>()),
      ),
    );
  },
);
