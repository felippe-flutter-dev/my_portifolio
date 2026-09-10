import 'package:flutter/material.dart';
import '../../../../core/theme/portfolio_theme.dart';
import 'section_heading.dart';
import 'external_link.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});
  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const SectionHeading('02', 'Sobre mim'),
      const Text(
        'Curioso por natureza. Criador por vontade.',
        style: TextStyle(
          fontSize: 26,
          height: 1.3,
          fontWeight: FontWeight.w600,
        ),
      ),
      const SizedBox(height: 20),
      const Text(
        'Sou Felippe: desenvolvedor, pai, compositor e alguém que gosta de entender como as coisas funcionam. Antes do código, vieram os brinquedos desmontados, a marcenaria com meu pai e a serralheria. Mudei de ferramentas, mas a vontade de construir ficou.\n\nHoje crio aplicações com Flutter e Android. Fora do editor, componho músicas, escrevo e invento mundos de fantasia. Gosto de dar forma às ideias — seja numa interface, numa história ou numa melodia.',
        style: TextStyle(color: PortfolioTheme.muted, height: 1.8),
      ),
      const SizedBox(height: 16),
      TextButton.icon(
        onPressed: () =>
            openExternal(context, 'https://medium.com/@felippehouse'),
        icon: const Icon(Icons.north_east, size: 16),
        label: const Text('Meus textos no Medium'),
      ),
    ],
  );
}
