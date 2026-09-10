import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import '../../../../core/theme/portfolio_theme.dart';
import 'cassette.dart';

class MusicPlayer extends StatefulWidget {
  const MusicPlayer({super.key});
  @override
  State<MusicPlayer> createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer> {
  static const tracks = ['Choked Apple', 'Flores Mortas', 'Serei só eu'];
  static const files = [
    'choked-apple.mp3',
    'flores-mortas.mp3',
    'serei-so-eu.mp3',
  ];
  AudioPlayer? player;
  final subscriptions = <StreamSubscription<dynamic>>[];
  int? selected;
  bool playing = false;
  bool busy = false;
  Duration position = Duration.zero;
  Duration duration = Duration.zero;
  String? error;

  AudioPlayer get audio {
    if (player != null) return player!;
    final value = player = AudioPlayer();
    subscriptions.add(
      value.onPlayerStateChanged.listen((state) {
        if (mounted) setState(() => playing = state == PlayerState.playing);
      }),
    );
    subscriptions.add(
      value.onPositionChanged.listen((value) {
        if (mounted) setState(() => position = value);
      }),
    );
    subscriptions.add(
      value.onDurationChanged.listen((value) {
        if (mounted) setState(() => duration = value);
      }),
    );
    return value;
  }

  Future<void> toggle(int index) async {
    if (busy) return;
    setState(() {
      busy = true;
      error = null;
    });
    try {
      final value = audio;
      if (selected == index && playing) {
        await value.pause();
      } else if (selected == index && value.state == PlayerState.paused) {
        await value.resume();
      } else {
        await value.stop();
        if (!mounted) return;
        setState(() {
          selected = index;
          position = Duration.zero;
          duration = Duration.zero;
        });
        await value.play(AssetSource('audio/${files[index]}'));
      }
    } catch (exception, stack) {
      debugPrint('Audio playback failed: $exception\n$stack');
      if (mounted) {
        setState(() => error = 'Não foi possível reproduzir. Tente novamente.');
      }
    } finally {
      if (mounted) setState(() => busy = false);
    }
  }

  String time(Duration value) =>
      '${value.inMinutes}:${(value.inSeconds % 60).toString().padLeft(2, '0')}';

  @override
  void dispose() {
    for (final subscription in subscriptions) {
      subscription.cancel();
    }
    player?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Center(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 340),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Cassette(title: tracks[selected ?? 0], playing: playing),
          const SizedBox(height: 16),
          Text(
            'Letras minhas · Produção com Suno',
            textAlign: TextAlign.center,
            style: const TextStyle(color: PortfolioTheme.muted, fontSize: 12),
          ),
          const SizedBox(height: 8),
          for (var index = 0; index < tracks.length; index++)
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: IconButton.filledTonal(
                tooltip: selected == index && playing
                    ? 'Pausar ${tracks[index]}'
                    : 'Ouvir ${tracks[index]}',
                onPressed: busy ? null : () => toggle(index),
                icon: Icon(
                  selected == index && playing ? Icons.pause : Icons.play_arrow,
                ),
              ),
              title: Text(tracks[index], style: const TextStyle(fontSize: 14)),
              subtitle: selected == index
                  ? Text(
                      busy
                          ? 'Carregando…'
                          : '${time(position)} / ${time(duration)}',
                    )
                  : null,
            ),
          if (duration > Duration.zero)
            Slider(
              value: position.inMilliseconds.toDouble().clamp(
                0,
                duration.inMilliseconds.toDouble(),
              ),
              max: duration.inMilliseconds.toDouble(),
              semanticFormatterCallback: (value) =>
                  time(Duration(milliseconds: value.round())),
              onChanged: busy
                  ? null
                  : (value) async {
                      try {
                        await audio.seek(Duration(milliseconds: value.round()));
                      } catch (_) {
                        if (mounted) {
                          setState(
                            () => error = 'Não foi possível avançar a faixa.',
                          );
                        }
                      }
                    },
            ),
          if (error != null)
            Text(
              error!,
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
        ],
      ),
    ),
  );
}
