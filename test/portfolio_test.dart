import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:felippe_portifolio/app/app_module.dart';
import 'package:felippe_portifolio/app/app_widget.dart';
import 'package:felippe_portifolio/core/theme/portfolio_theme.dart';
import 'package:felippe_portifolio/modules/portfolio/data/repositories/local_project_repository.dart';
import 'package:felippe_portifolio/modules/portfolio/domain/usecases/get_projects.dart';
import 'package:felippe_portifolio/modules/portfolio/presentation/controllers/portfolio_cubit.dart';
import 'package:felippe_portifolio/modules/portfolio/presentation/portfolio_presentation.dart';
import 'package:felippe_portifolio/modules/portfolio/presentation/expanded/portfolio_expanded.dart';
import 'package:felippe_portifolio/modules/portfolio/presentation/compact/portfolio_compact.dart';
import 'package:felippe_portifolio/modules/portfolio/presentation/widgets/project_card.dart';

void main() {
  testWidgets('Modular resolves the portfolio and its dependencies', (
    tester,
  ) async {
    await tester.pumpWidget(
      ModularApp(module: appModule, child: const PortfolioApp()),
    );
    await tester.pumpAndSettle();
    expect(find.byType(PortfolioPresentation), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  for (final width in [320.0, 393.0, 768.0, 900.0, 1440.0]) {
    testWidgets('Responsive layout and navigation at $width', (tester) async {
      tester.view.physicalSize = Size(width, 900);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      await tester.pumpWidget(
        MaterialApp(
          theme: PortfolioTheme.dark,
          home: PortfolioPresentation(
            createController: () =>
                PortfolioCubit(GetProjects(LocalProjectRepository())),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(
        find.byType(
          width >= 900 ? PortfolioExpanded : PortfolioCompact,
        ),
        findsOneWidget,
      );
      expect(tester.takeException(), isNull);
      await tester.ensureVisible(find.text('Explorar projetos'));
      await tester.tap(find.text('Explorar projetos'));
      await tester.pumpAndSettle();
      await tester.ensureVisible(find.widgetWithText(ChoiceChip, 'Backend'));
      await tester.tap(find.widgetWithText(ChoiceChip, 'Backend'));
      await tester.pumpAndSettle();
      expect(find.byType(ProjectCard), findsOneWidget);
      expect(find.text('PartyU'), findsOneWidget);
      await tester.ensureVisible(find.text('PartyU'));
      await tester.tap(find.text('PartyU'));
      await tester.pumpAndSettle();
      expect(find.text('Ver repositório'), findsOneWidget);
      await tester.tap(find.text('Fechar'));
      await tester.pumpAndSettle();
      expect(find.byType(AlertDialog), findsNothing);
      expect(tester.takeException(), isNull);
    });
  }
}
