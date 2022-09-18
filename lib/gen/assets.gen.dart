/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import

import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/apple.svg
  SvgGenImage get apple => const SvgGenImage('assets/icons/apple.svg');

  /// File path: assets/icons/area_outline.svg
  SvgGenImage get areaOutline =>
      const SvgGenImage('assets/icons/area_outline.svg');

  /// File path: assets/icons/avatar_fill.svg
  SvgGenImage get avatarFill =>
      const SvgGenImage('assets/icons/avatar_fill.svg');

  /// File path: assets/icons/bathtub.svg
  SvgGenImage get bathtub => const SvgGenImage('assets/icons/bathtub.svg');

  /// File path: assets/icons/cart_outline.svg
  SvgGenImage get cartOutline =>
      const SvgGenImage('assets/icons/cart_outline.svg');

  /// File path: assets/icons/check.svg
  SvgGenImage get check => const SvgGenImage('assets/icons/check.svg');

  /// File path: assets/icons/compass.svg
  SvgGenImage get compass => const SvgGenImage('assets/icons/compass.svg');

  /// File path: assets/icons/dot.svg
  SvgGenImage get dot => const SvgGenImage('assets/icons/dot.svg');

  /// File path: assets/icons/double_down.svg
  SvgGenImage get doubleDown =>
      const SvgGenImage('assets/icons/double_down.svg');

  /// File path: assets/icons/exit_up.svg
  SvgGenImage get exitUp => const SvgGenImage('assets/icons/exit_up.svg');

  /// File path: assets/icons/facebook.svg
  SvgGenImage get facebook => const SvgGenImage('assets/icons/facebook.svg');

  /// File path: assets/icons/file_ic.svg
  SvgGenImage get fileIc => const SvgGenImage('assets/icons/file_ic.svg');

  /// File path: assets/icons/filter_line.svg
  SvgGenImage get filterLine =>
      const SvgGenImage('assets/icons/filter_line.svg');

  /// File path: assets/icons/filter_line_active.svg
  SvgGenImage get filterLineActive =>
      const SvgGenImage('assets/icons/filter_line_active.svg');

  /// File path: assets/icons/google.svg
  SvgGenImage get google => const SvgGenImage('assets/icons/google.svg');

  /// File path: assets/icons/like_thumb.svg
  SvgGenImage get likeThumb => const SvgGenImage('assets/icons/like_thumb.svg');

  /// File path: assets/icons/liked_thumb.svg
  SvgGenImage get likedThumb =>
      const SvgGenImage('assets/icons/liked_thumb.svg');

  /// File path: assets/icons/location_pin.svg
  SvgGenImage get locationPin =>
      const SvgGenImage('assets/icons/location_pin.svg');

  /// File path: assets/icons/near_me_outline.svg
  SvgGenImage get nearMeOutline =>
      const SvgGenImage('assets/icons/near_me_outline.svg');

  /// File path: assets/icons/news_paper.svg
  SvgGenImage get newsPaper => const SvgGenImage('assets/icons/news_paper.svg');

  /// File path: assets/icons/pin_left.svg
  SvgGenImage get pinLeft => const SvgGenImage('assets/icons/pin_left.svg');

  /// File path: assets/icons/radio_selected.svg
  SvgGenImage get radioSelected =>
      const SvgGenImage('assets/icons/radio_selected.svg');

  /// File path: assets/icons/radio_unselected.svg
  SvgGenImage get radioUnselected =>
      const SvgGenImage('assets/icons/radio_unselected.svg');

  /// File path: assets/icons/sntg_logo.svg
  SvgGenImage get sntgLogo => const SvgGenImage('assets/icons/sntg_logo.svg');

  /// File path: assets/icons/success_ic.svg
  SvgGenImage get successIc => const SvgGenImage('assets/icons/success_ic.svg');

  /// File path: assets/icons/toilet_seat_outline.svg
  SvgGenImage get toiletSeatOutline =>
      const SvgGenImage('assets/icons/toilet_seat_outline.svg');

  /// File path: assets/icons/vr_360.svg
  SvgGenImage get vr360 => const SvgGenImage('assets/icons/vr_360.svg');

  /// File path: assets/icons/warning_ic.svg
  SvgGenImage get warningIc => const SvgGenImage('assets/icons/warning_ic.svg');
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/no_image.png
  AssetGenImage get noImage =>
      const AssetGenImage('assets/images/no_image.png');
}

class Assets {
  Assets._();

  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class SvgGenImage {
  const SvgGenImage(this._assetName);

  final String _assetName;

  SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    Color? color,
    BlendMode colorBlendMode = BlendMode.srcIn,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    Clip clipBehavior = Clip.hardEdge,
    bool cacheColorFilter = false,
    SvgTheme? theme,
  }) {
    return SvgPicture.asset(
      _assetName,
      key: key,
      matchTextDirection: matchTextDirection,
      bundle: bundle,
      package: package,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      color: color,
      colorBlendMode: colorBlendMode,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
      theme: theme,
    );
  }

  String get path => _assetName;
}
