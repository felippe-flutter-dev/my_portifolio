import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/adaptive/app_breakpoints.dart';
import 'controllers/portfolio_cubit.dart';
import 'compact/portfolio_compact.dart';
import 'expanded/portfolio_expanded.dart';

class PortfolioPresentation extends StatelessWidget {
  const PortfolioPresentation({required this.createController, super.key});
  final PortfolioCubit Function() createController;
  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => createController(),
    child: BlocBuilder<PortfolioCubit, PortfolioState>(
      builder: (context, state) {
        final select = context.read<PortfolioCubit>().selectCategory;
        return LayoutBuilder(
          builder: (context, constraints) => constraints.maxWidth >= AppBreakpoints.expanded
              ? PortfolioExpanded(
                  projects: state.visibleProjects,
                  category: state.category,
                  onCategory: select,
                )
              : PortfolioCompact(
                  projects: state.visibleProjects,
                  category: state.category,
                  onCategory: select,
                ),
        );
      },
    ),
  );
}
