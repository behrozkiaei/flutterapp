import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class NetworkImageProvider extends ImageProvider<NetworkImageProvider> {
  final String url;
  final BaseCacheManager? cacheManager;

  const NetworkImageProvider(this.url, {required this.cacheManager});

  @override
  Future<NetworkImageProvider> obtainKey(ImageConfiguration configuration) {
    return SynchronousFuture<NetworkImageProvider>(this);
  }

  @override
  ImageStreamCompleter load(NetworkImageProvider key, DecoderCallback decode) {
    return MultiFrameImageStreamCompleter(
      codec: _loadAsync(key), // <-- specify the type of codec parameter as Future<ui.Codec>
      scale: 1.0,
      informationCollector: () sync* {
        yield DiagnosticsProperty<ImageProvider>('Image provider', this);
        yield DiagnosticsProperty<NetworkImageProvider>('NetworkImage provider', key);
      },
    );
  }

  Future<ui.Codec> _loadAsync(NetworkImageProvider key) async {
    var file = await cacheManager?.getSingleFile(url) ??
        await DefaultCacheManager().getSingleFile(url);
    final Uint8List bytes = await file.readAsBytes();
    if (bytes.lengthInBytes == 0) {
      throw Exception('Image not found: $url');
    }
    return await PaintingBinding.instance!.instantiateImageCodec(bytes);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is NetworkImageProvider && runtimeType == other.runtimeType && url == other.url;

  @override
  int get hashCode => url.hashCode;

  @override
  String toString() => '$runtimeType("$url")';
}
