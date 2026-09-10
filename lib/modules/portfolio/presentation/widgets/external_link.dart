import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> openExternal(BuildContext context, String url) async {
  try {
    if (await launchUrl(Uri.parse(url))) return;
  } catch (_) {
    // Report platform failures without losing the visitor's place.
  }
  if (context.mounted) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Não foi possível abrir $url')));
  }
}
