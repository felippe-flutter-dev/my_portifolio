import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../../../core/theme/portfolio_theme.dart';
import 'scrapbook.dart';

class Cassette extends StatefulWidget {
  const Cassette({required this.title, required this.playing, super.key});
  final String title;
  final bool playing;
  @override
  State<Cassette> createState() => _CassetteState();
}

class _CassetteState extends State<Cassette>
    with SingleTickerProviderStateMixin {
  late final AnimationController rotation = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 4),
  );
  void sync() {
    if (widget.playing && !MediaQuery.disableAnimationsOf(context)) {
      if (!rotation.isAnimating) rotation.repeat();
    } else {
      rotation.stop();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    sync();
  }

  @override
  void didUpdateWidget(Cassette oldWidget) {
    super.didUpdateWidget(oldWidget);
    sync();
  }

  @override
  void dispose() {
    rotation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AspectRatio(
    aspectRatio: 1.65,
    child: DecoratedBox(
      decoration: BoxDecoration(
        color: const Color(0xFF252821),
        borderRadius: BorderRadius.circular(13),
        border: Border.all(color: const Color(0xFF747363), width: 2),
        boxShadow: const [
          BoxShadow(
            color: Colors.black54,
            blurRadius: 14,
            offset: Offset(3, 7),
          ),
        ],
      ),
      child: Stack(
        children: [
          for (final alignment in [
            Alignment.topLeft,
            Alignment.topRight,
            Alignment.bottomLeft,
            Alignment.bottomRight,
          ])
            Align(
              alignment: alignment,
              child: const Padding(
                padding: EdgeInsets.all(7),
                child: Icon(
                  Icons.add_circle_outline,
                  size: 12,
                  color: Color(0xFF8B8E80),
                ),
              ),
            ),
          Positioned.fill(
            left: 19,
            right: 19,
            top: 19,
            bottom: 30,
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 7,
                  ),
                  color: paper,
                  child: Text(
                    'A / ${widget.title}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: ink,
                      fontFamily: 'Georgia',
                      fontStyle: FontStyle.italic,
                      fontSize: 17,
                    ),
                  ),
                ),
                Expanded(
                  child: AnimatedBuilder(
                    animation: rotation,
                    builder: (context, _) => CustomPaint(
                      painter: _Reels(rotation.value),
                      size: Size.infinite,
                    ),
                  ),
                ),
                const Text(
                  'FP  •  LETRAS & OUTRAS IDEIAS  •  VOL. 01',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    color: PortfolioTheme.muted,
                    fontSize: 8,
                  ),
                ),
              ],
            ),
          ),
          const Positioned(
            bottom: 6,
            left: 0,
            right: 0,
            child: Icon(
              Icons.horizontal_rule,
              size: 30,
              color: Color(0xFF747363),
            ),
          ),
        ],
      ),
    ),
  );
}

class _Reels extends CustomPainter {
  _Reels(this.turn);
  final double turn;
  @override
  void paint(Canvas canvas, Size size) {
    final radius = math.min(size.height * .36, size.width * .13);
    final centers = [
      Offset(size.width * .25, size.height / 2),
      Offset(size.width * .75, size.height / 2),
    ];
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTRB(
          size.width * .1,
          size.height * .08,
          size.width * .9,
          size.height * .92,
        ),
        const Radius.circular(12),
      ),
      Paint()..color = const Color(0xFF11140F),
    );
    canvas.drawLine(
      centers[0] + Offset(0, -radius),
      centers[1] + Offset(0, -radius),
      Paint()
        ..color = const Color(0xFF736346)
        ..strokeWidth = 3,
    );
    canvas.drawLine(
      centers[0] + Offset(0, radius),
      centers[1] + Offset(0, radius),
      Paint()
        ..color = const Color(0xFF736346)
        ..strokeWidth = 3,
    );
    for (final center in centers) {
      canvas.drawCircle(
        center,
        radius,
        Paint()
          ..color = PortfolioTheme.accent
          ..style = PaintingStyle.stroke
          ..strokeWidth = 3,
      );
      canvas.drawCircle(
        center,
        radius * .35,
        Paint()
          ..color = paper
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2,
      );
      for (var i = 0; i < 6; i++) {
        final angle = (turn + i / 6) * math.pi * 2;
        final direction = Offset(math.cos(angle), math.sin(angle));
        canvas.drawLine(
          center + direction * radius * .5,
          center + direction * radius * .85,
          Paint()
            ..color = paper
            ..strokeWidth = 3,
        );
      }
    }
  }

  @override
  bool shouldRepaint(_Reels oldDelegate) => turn != oldDelegate.turn;
}
