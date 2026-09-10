import 'package:flutter/material.dart';
import '../../../../core/theme/portfolio_theme.dart';
import 'external_link.dart';

class HeroContent extends StatelessWidget {
  const HeroContent({
    required this.titleSize,
    required this.onProjects,
    super.key,
  });
  final double titleSize;
  final VoidCallback onProjects;
  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        'FLUTTER DEVELOPER  /  RIO DE JANEIRO',
        style: TextStyle(
          color: PortfolioTheme.accent,
          fontSize: 11,
          letterSpacing: 2,
        ),
      ),
      const SizedBox(height: 28),
      Text(
        'Código sólido.\nExperiências',
        style: TextStyle(
          fontSize: titleSize,
          height: 1.06,
          fontWeight: FontWeight.w800,
          letterSpacing: -2.6,
        ),
      ),
      Text(
        'memoráveis.',
        style: TextStyle(
          fontSize: titleSize,
          height: 1.1,
          fontWeight: FontWeight.w800,
          letterSpacing: -2.6,
          color: PortfolioTheme.accent,
        ),
      ),
      const SizedBox(height: 28),
      const Text(
        'Sou Felippe Pinheiro, desenvolvedor Flutter sênior. Transformo desafios complexos em aplicações fluidas, resilientes e feitas para evoluir.',
        style: TextStyle(
          color: PortfolioTheme.muted,
          fontSize: 17,
          height: 1.7,
        ),
      ),
      const SizedBox(height: 30),
      Wrap(
        spacing: 12,
        runSpacing: 12,
        children: [
          FilledButton.icon(
            onPressed: onProjects,
            label: const Text('Explorar projetos'),
            icon: const Icon(Icons.arrow_downward, size: 18),
          ),
          OutlinedButton(
            onPressed: () =>
                openExternal(context, 'mailto:felippehouse@gmail.com'),
            child: const Text('Vamos conversar ↗'),
          ),
        ],
      ),
      const SizedBox(height: 34),
      const Text(
        'FLUTTER  ·  KOTLIN  ·  CLEAN ARCHITECTURE',
        style: TextStyle(
          fontSize: 10,
          letterSpacing: 1.5,
          color: PortfolioTheme.muted,
        ),
      ),
    ],
  );
}

class IdentityArtwork extends StatelessWidget {
  const IdentityArtwork({super.key});
  @override
  Widget build(BuildContext context) => AspectRatio(
    aspectRatio: 1.04,
    child: Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: const Color(0xFF222B1C),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: PortfolioTheme.border),
      ),
      child: Stack(
        children: [
          Positioned.fill(child: CustomPaint(painter: _GridPainter())),
          Positioned(
            top: 24,
            left: 24,
            child: Text(
              'FP / ENGINEERING',
              style: TextStyle(
                color: PortfolioTheme.accent.withValues(alpha: .7),
                letterSpacing: 3,
                fontSize: 10,
              ),
            ),
          ),
          Center(
            child: Transform.rotate(
              angle: -.10,
              child: Container(
                width: 210,
                height: 240,
                padding: const EdgeInsets.all(23),
                decoration: BoxDecoration(
                  color: PortfolioTheme.background,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: const Color(0xFF5B7047)),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black38,
                      blurRadius: 40,
                      offset: Offset(15, 25),
                    ),
                  ],
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.circle,
                          size: 7,
                          color: PortfolioTheme.accent,
                        ),
                        SizedBox(width: 6),
                        Icon(
                          Icons.circle,
                          size: 7,
                          color: PortfolioTheme.border,
                        ),
                        SizedBox(width: 6),
                        Icon(
                          Icons.circle,
                          size: 7,
                          color: PortfolioTheme.border,
                        ),
                      ],
                    ),
                    Spacer(),
                    FittedBox(
                      child: Text(
                        '<fp/>',
                        style: TextStyle(
                          fontSize: 57,
                          fontWeight: FontWeight.w900,
                          color: PortfolioTheme.accent,
                          letterSpacing: -5,
                        ),
                      ),
                    ),
                    Spacer(),
                    FittedBox(
                      child: Text(
                        'CRAFTED WITH FLUTTER',
                        style: TextStyle(
                          fontSize: 9,
                          letterSpacing: 1.5,
                          color: PortfolioTheme.muted,
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    LinearProgressIndicator(value: .72, minHeight: 2),
                  ],
                ),
              ),
            ),
          ),
          const Positioned(
            bottom: 24,
            left: 24,
            right: 24,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    'ARQUITETURA + EXPERIÊNCIA',
                    style: TextStyle(
                      fontSize: 9,
                      letterSpacing: 1,
                      color: PortfolioTheme.muted,
                    ),
                  ),
                ),
                Icon(Icons.north_east, color: PortfolioTheme.accent),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF35412C)
      ..strokeWidth = .6;
    for (double x = 0; x < size.width; x += 32) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += 32) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      size.width * .43,
      Paint()
        ..color = const Color(0xFF566E3C)
        ..style = PaintingStyle.stroke,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
