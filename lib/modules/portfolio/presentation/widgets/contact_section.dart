import 'package:flutter/material.dart';
import '../../../../core/theme/portfolio_theme.dart';
import 'external_link.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});
  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    padding: const EdgeInsets.all(32),
    decoration: BoxDecoration(
      color: const Color(0xFF232D1A),
      borderRadius: BorderRadius.circular(18),
      border: Border.all(color: const Color(0xFF455734)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '05 / VAMOS CONSTRUIR ALGO',
          style: TextStyle(
            color: PortfolioTheme.accent,
            letterSpacing: 2,
            fontSize: 10,
          ),
        ),
        const SizedBox(height: 18),
        const Text(
          'Uma boa conversa pode ser\no começo de um grande projeto.',
          style: TextStyle(
            fontSize: 30,
            height: 1.2,
            fontWeight: FontWeight.w700,
            letterSpacing: -.6,
          ),
        ),
        const SizedBox(height: 24),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            FilledButton.icon(
              onPressed: () =>
                  openExternal(context, 'mailto:felippehouse@gmail.com'),
              icon: const Icon(Icons.north_east, size: 18),
              label: const Text('Entrar em contato'),
            ),
            OutlinedButton(
              onPressed: () => openExternal(
                context,
                'https://github.com/felippe-flutter-dev',
              ),
              child: const Text('GitHub ↗'),
            ),
            OutlinedButton(
              onPressed: () => openExternal(
                context,
                'https://www.linkedin.com/in/felippe-pinheiro-dev-flutter/',
              ),
              child: const Text('LinkedIn ↗'),
            ),
          ],
        ),
      ],
    ),
  );
}

class PortfolioFooter extends StatelessWidget {
  const PortfolioFooter({super.key});
  @override
  Widget build(BuildContext context) => const Padding(
    padding: EdgeInsets.symmetric(vertical: 32),
    child: Wrap(
      spacing: 30,
      runSpacing: 12,
      children: [
        Text(
          '© Felippe Pinheiro',
          style: TextStyle(color: PortfolioTheme.muted, fontSize: 12),
        ),
        Text(
          'Feito com Flutter. Pensado em cada detalhe.',
          style: TextStyle(color: PortfolioTheme.muted, fontSize: 12),
        ),
      ],
    ),
  );
}
