import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../core/theme/portfolio_theme.dart';

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp.router(
    title: 'Felippe Pinheiro • Flutter Developer',
    debugShowCheckedModeBanner: false,
    theme: PortfolioTheme.dark,
    routerConfig: ModularApp.routerConfigOf(context),
  );
}
