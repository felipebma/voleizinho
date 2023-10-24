import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class ShareService {
  static Future<void> shareWidgets(List<GlobalKey> globalKeys) async {
    final List<RenderRepaintBoundary> boundaries = globalKeys
        .map((e) =>
            e.currentContext!.findRenderObject() as RenderRepaintBoundary)
        .toList();

    List<XFile> files = [];

    for (RenderRepaintBoundary boundary in boundaries) {
      final image = await boundary.toImage(pixelRatio: 2.0);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      final file = File(
          '${(await getTemporaryDirectory()).path}/${DateTime.now().millisecondsSinceEpoch}.jpg');
      await file.writeAsBytes(byteData!.buffer.asUint8List());
      files.add(XFile(file.path));
    }
    Share.shareXFiles(
      files,
    );
  }
}
