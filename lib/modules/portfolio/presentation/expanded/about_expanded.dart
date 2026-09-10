import 'package:flutter/material.dart';
import '../widgets/about_section.dart';
import '../widgets/music_player.dart';
import '../widgets/scrapbook.dart';
import '../widgets/scroll_reveal.dart';

class AboutExpanded extends StatelessWidget {
  const AboutExpanded({super.key});
  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      const Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(flex: 6, child: AboutSection()),
          SizedBox(width: 60),
          Expanded(
            flex: 4,
            child: Column(
              children: [
                SizedBox(
                  width: 290,
                  child: ScrapPhoto(
                    asset: 'assets/images/felippe-pinheiro.png',
                    caption: 'Felippe, em constante construção.',
                    portrait: true,
                  ),
                ),
                SizedBox(height: 22),
                PaperNote(
                  'Código, histórias, música.\nE um pouco de caos no processo.',
                ),
              ],
            ),
          ),
        ],
      ),
      const SizedBox(height: 65),
      const _ChapterRow(
        chapter: PersonalChapters.beginnings,
        visual: Row(
          children: [
            Expanded(
              child: ScrapPhoto(
                asset: 'assets/images/infancia.jpeg',
                caption: 'Desde cedo.',
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: 35),
                child: ScrapPhoto(
                  asset: 'assets/images/criatividade.jpeg',
                  caption: 'Sem muito roteiro.',
                  angle: .05,
                ),
              ),
            ),
          ],
        ),
      ),
      const _ChapterRow(
        chapter: PersonalChapters.rpg,
        visual: Padding(padding: EdgeInsets.all(22), child: WorldSketch()),
      ),
      const _ChapterRow(chapter: PersonalChapters.music, visual: MusicPlayer()),
      const _ChapterRow(
        chapter: PersonalChapters.cycles,
        visual: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: ScrapPhoto(
            asset: 'assets/images/novos-ciclos.jpeg',
            caption: 'Outros cabelos, a mesma essência.',
            angle: .035,
          ),
        ),
      ),
      const _ChapterRow(
        chapter: PersonalChapters.nextGeneration,
        visual: NextGenerationPhoto(),
      ),
      const Align(
        alignment: Alignment.centerLeft,
        child: PaperNote('Ainda tem muito chão. E eu continuo curioso.  // FP'),
      ),
    ],
  );
}

class _ChapterRow extends StatelessWidget {
  const _ChapterRow({required this.chapter, required this.visual});
  final Widget chapter, visual;
  @override
  Widget build(BuildContext context) => TimelineRail(
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 5, child: chapter),
        const SizedBox(width: 50),
        Expanded(flex: 6, child: ScrollReveal(child: visual)),
      ],
    ),
  );
}
