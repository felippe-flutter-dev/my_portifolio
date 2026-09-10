import 'package:flutter_modular/flutter_modular.dart';
import '../modules/portfolio/portfolio_module.dart';

final appModule = createModule(
  register: (c) {
    c.module(portfolioModule, at: '/');
  },
);
