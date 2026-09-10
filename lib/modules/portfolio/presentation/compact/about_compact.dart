import 'package:flutter/material.dart';
import '../widgets/about_section.dart';
import '../widgets/music_player.dart';
import '../widgets/scrapbook.dart';
import '../widgets/scroll_reveal.dart';

class AboutCompact extends StatelessWidget {
  const AboutCompact({super.key});
  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      const AboutSection(),
      const SizedBox(height: 22),
      Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 285),
          child: const ScrapPhoto(
            asset: 'assets/images/felippe-pinheiro.png',
            caption: 'Felippe, em constante construção.',
            portrait: true,
          ),
        ),
      ),
      const SizedBox(height: 20),
      const PaperNote(
        'Código, histórias, música.\nE um pouco de caos no processo.',
      ),
      const SizedBox(height: 42),
      const TimelineRail(
        child: Column(
          children: [
            PersonalChapters.beginnings,
            SizedBox(height: 24),
            _PhotoPair(),
          ],
        ),
      ),
      const TimelineRail(
        child: Column(
          children: [
            PersonalChapters.rpg,
            SizedBox(height: 28),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 22),
              child: ScrollReveal(child: WorldSketch()),
            ),
          ],
        ),
      ),
      const TimelineRail(
        child: Column(
          children: [
            PersonalChapters.music,
            SizedBox(height: 24),
            Padding(padding: EdgeInsets.only(left: 20), child: MusicPlayer()),
          ],
        ),
      ),
      TimelineRail(
        child: Column(
          children: [
            PersonalChapters.cycles,
            const SizedBox(height: 24),
            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 320),
                child: const ScrollReveal(
                  child: ScrapPhoto(
                    asset: 'assets/images/novos-ciclos.jpeg',
                    caption: 'Outros cabelos, a mesma essência.',
                    angle: .035,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      const TimelineRail(
        child: Column(
          children: [
            PersonalChapters.nextGeneration,
            SizedBox(height: 24),
            ScrollReveal(child: NextGenerationPhoto()),
          ],
        ),
      ),
      const PaperNote('Ainda tem muito chão.\nE eu continuo curioso.  // FP'),
    ],
  );
}

class _PhotoPair extends StatelessWidget {
  const _PhotoPair();
  @override
  Widget build(BuildContext context) => const Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Expanded(
        child: ScrapPhoto(
          asset: 'assets/images/infancia.jpeg',
          caption: 'Desde cedo.',
        ),
      ),
      Expanded(
        child: ScrapPhoto(
          asset: 'assets/images/criatividade.jpeg',
          caption: 'Sem muito roteiro.',
          angle: .04,
        ),
      ),
    ],
  );
}
