import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../../../core/theme/portfolio_theme.dart';

const paper = Color(0xFFDFD4BC);
const ink = Color(0xFF292B24);

class ScrapPhoto extends StatelessWidget {
  const ScrapPhoto({
    required this.asset,
    required this.caption,
    this.angle = -.035,
    this.portrait = false,
    this.aspectRatio,
    super.key,
  });
  final String asset, caption;
  final double angle;
  final bool portrait;
  final double? aspectRatio;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(12),
    child: Transform.rotate(
      angle: angle,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 16),
            decoration: const BoxDecoration(
              color: paper,
              boxShadow: [
                BoxShadow(
                  color: Colors.black45,
                  blurRadius: 18,
                  offset: Offset(3, 9),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AspectRatio(
                  aspectRatio: aspectRatio ?? (portrait ? .95 : 1.35),
                  child: Image.asset(
                    asset,
                    fit: BoxFit.cover,
                    alignment: portrait
                        ? const Alignment(.15, .5)
                        : Alignment.center,
                    semanticLabel: caption,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  caption,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: ink,
                    fontStyle: FontStyle.italic,
                    fontSize: 15,
                    fontFamily: 'Georgia',
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: -9,
            child: Transform.rotate(
              angle: -.08,
              child: Container(
                width: 82,
                height: 25,
                color: const Color(0xBCB9AC87),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

class PaperNote extends StatelessWidget {
  const PaperNote(this.text, {super.key});
  final String text;
  @override
  Widget build(BuildContext context) => Transform.rotate(
    angle: .025,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 18),
      color: paper,
      child: Text(
        text,
        style: const TextStyle(
          color: ink,
          fontSize: 18,
          fontFamily: 'Georgia',
          fontStyle: FontStyle.italic,
          height: 1.45,
        ),
      ),
    ),
  );
}

class StoryChapter extends StatelessWidget {
  const StoryChapter(this.year, this.title, this.body, {super.key});
  final String year, title, body;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(left: 24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          year,
          style: const TextStyle(
            color: PortfolioTheme.accent,
            fontFamily: 'monospace',
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          title,
          style: const TextStyle(
            fontSize: 25,
            height: 1.2,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 14),
        Text(
          body,
          style: const TextStyle(color: PortfolioTheme.muted, height: 1.8),
        ),
      ],
    ),
  );
}

class TimelineRail extends StatelessWidget {
  const TimelineRail({required this.child, super.key});
  final Widget child;
  @override
  Widget build(BuildContext context) => Stack(
    children: [
      const Positioned(
        left: 5,
        top: 0,
        bottom: 0,
        child: VerticalDivider(width: 1, color: Color(0xFF596F39)),
      ),
      Positioned(
        left: 0,
        top: 7,
        child: Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: PortfolioTheme.accent,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: PortfolioTheme.accent.withValues(alpha: .2),
                blurRadius: 12,
                spreadRadius: 3,
              ),
            ],
          ),
        ),
      ),
      Padding(padding: const EdgeInsets.only(bottom: 38), child: child),
    ],
  );
}

class WorldSketch extends StatelessWidget {
  const WorldSketch({super.key});
  @override
  Widget build(BuildContext context) => Transform.rotate(
    angle: .035,
    child: Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: paper,
        boxShadow: [
          BoxShadow(
            color: Colors.black38,
            blurRadius: 16,
            offset: Offset(2, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          SizedBox(
            height: 155,
            width: double.infinity,
            child: CustomPaint(painter: _MapPainter()),
          ),
          const Text(
            'um mundo inteiro na cabeça',
            style: TextStyle(
              color: ink,
              fontFamily: 'Georgia',
              fontStyle: FontStyle.italic,
              fontSize: 17,
            ),
          ),
        ],
      ),
    ),
  );
}

class _MapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final stroke = Paint()
      ..color = ink.withValues(alpha: .65)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;
    for (var i = 0; i < 7; i++) {
      final x = size.width * (i + 1) / 9;
      final y = 60 + math.sin(i * 1.8) * 30;
      canvas.drawPath(
        Path()
          ..moveTo(x - 22, y + 34)
          ..lineTo(x, y)
          ..lineTo(x + 27, y + 34)
          ..moveTo(x, y)
          ..lineTo(x + 5, y + 23),
        stroke,
      );
    }
    canvas.drawPath(
      Path()
        ..moveTo(0, 120)
        ..cubicTo(size.width * .4, 70, size.width * .45, 160, size.width, 105),
      stroke,
    );
    final center = Offset(size.width - 30, 30);
    canvas.drawCircle(center, 19, stroke);
    canvas.drawLine(
      center - const Offset(0, 26),
      center + const Offset(0, 26),
      stroke,
    );
    canvas.drawLine(
      center - const Offset(26, 0),
      center + const Offset(26, 0),
      stroke,
    );
  }

  @override
  bool shouldRepaint(_MapPainter oldDelegate) => false;
}

class PersonalChapters {
  static const nextGeneration = StoryChapter(
    'DESDE 2022',
    'A nova geração do caos.',
    'Em 2022, minha filha chegou e começou um capítulo inteiramente novo. Herdeira desse caos todo desde pequena, ela já tem sua própria trilha sonora: microfone na mão, guitarra e muita personalidade. Agora o show é dela — e eu sigo na primeira fila.',
  );
  static const beginnings = StoryChapter(
    'ANTES DO CÓDIGO',
    'Aprender fazendo.',
    'Brinquedos desmontados, marcenaria com meu pai, serralheria. A vontade de entender as coisas veio antes de eu encontrar a programação.',
  );
  static const rpg = StoryChapter(
    '2016 → 2018',
    'Outros mundos. Outras possibilidades.',
    'Entrei no RPG em 2016 e criei meu primeiro mundo em 2018. Ele continua crescendo: personagens, histórias e a vontade de transformar tudo isso em um livro.',
  );
  static const music = StoryChapter(
    '2023 → AGORA',
    'Tem coisa que eu escrevo para ouvir.',
    'Descobri o Suno e comecei a escrever letras por hobby. Cerca de 40 músicas depois, continuo encontrando novas formas de colocar ideias e sentimentos para fora.',
  );
  static const cycles = StoryChapter(
    'ENTRE UMA FASE E OUTRA',
    'Mudo o cabelo. Continuo curioso.',
    'Já fui cabeludo três vezes e estou na quarta. Corto em grandes mudanças e deixo crescer em outras. Até o cabelo acaba contando um pedaço da história.',
  );
}

class NextGenerationPhoto extends StatelessWidget {
  const NextGenerationPhoto({super.key});
  @override
  Widget build(BuildContext context) => Center(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 310),
      child: const ScrapPhoto(
        asset: 'assets/images/nova-geracao.jpeg',
        caption: 'A nova geração já é do rock.',
        aspectRatio: 720 / 1280,
        angle: -.025,
      ),
    ),
  );
}
