import 'package:flutter/material.dart';

/// One-shot entrance; reduced motion always exposes the content immediately.
class ScrollReveal extends StatefulWidget {
  const ScrollReveal({required this.child, super.key});
  final Widget child;
  @override
  State<ScrollReveal> createState() => _ScrollRevealState();
}

class _ScrollRevealState extends State<ScrollReveal> {
  ScrollPosition? position;
  bool visible = false;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    position?.removeListener(check);
    position = Scrollable.maybeOf(context)?.position;
    position?.addListener(check);
    WidgetsBinding.instance.addPostFrameCallback((_) => check());
  }

  void check() {
    if (!mounted || visible) return;
    final box = context.findRenderObject();
    if (box is RenderBox &&
        box.hasSize &&
        box.localToGlobal(Offset.zero).dy < MediaQuery.sizeOf(context).height) {
      setState(() => visible = true);
    }
  }

  @override
  void dispose() {
    position?.removeListener(check);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final reduced = MediaQuery.disableAnimationsOf(context);
    final shown = reduced || visible;
    final duration = reduced
        ? Duration.zero
        : const Duration(milliseconds: 550);
    return AnimatedSlide(
      offset: shown ? Offset.zero : const Offset(0, .025),
      duration: duration,
      curve: Curves.easeOutCubic,
      child: AnimatedOpacity(
        opacity: shown ? 1 : 0,
        duration: duration,
        child: widget.child,
      ),
    );
  }
}
