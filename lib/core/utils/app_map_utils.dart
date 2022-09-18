import 'package:kyo_base/imports/base_component_import.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' hide MapType;
import 'dart:ui'
    as ui; // imported as ui to prevent conflict between ui.Image and the Image widget

extension LocationPointExtend on LocationPoint? {
  bool isNullOrEmpty() {
    if (this == null || this!.lat == null || this!.lng == null) return true;
    return false;
  }

  LatLng toLatLng() {
    if (isNullOrEmpty()) return const LatLng(0, 0);
    return LatLng(this!.lat!, this!.lng!);
  }

  Coords toCoords() {
    if (isNullOrEmpty()) return Coords(0, 0);
    return Coords(this!.lat!, this!.lng!);
  }

  String getMarkerId() {
    if (isNullOrEmpty()) return '';
    return '${this!.lat!},${this!.lng!}';
  }

  Future<void> toCameraLocation(
      Completer<GoogleMapController> controllerFuture) async {
    if (isNullOrEmpty()) return Future.error('Empty location');
    final GoogleMapController controller = await controllerFuture.future;
    AppMapUtils.controllerToLocation(toLatLng(), controller);
  }
}

extension LatLngBoundsExtension on LatLngBounds {
  static LatLngBounds fromLatLngList(List<LatLng> latLngList) {
    assert(latLngList.isNotEmpty);
    double? x0, x1, y0, y1;
    for (LatLng latLng in latLngList) {
      if (x0 == null) {
        x0 = x1 = latLng.latitude;
        y0 = y1 = latLng.longitude;
      } else {
        if (latLng.latitude > x1!) x1 = latLng.latitude;
        if (latLng.latitude < x0) x0 = latLng.latitude;
        if (latLng.longitude > y1!) y1 = latLng.longitude;
        if (latLng.longitude < y0!) y0 = latLng.longitude;
      }
    }
    return LatLngBounds(
      northeast: LatLng(x1!, y1!),
      southwest: LatLng(x0!, y0!),
    );
  }
}

class LocationPoint {
  double? lat;
  double? lng;

  factory LocationPoint.fromPosition(Position position) {
    return LocationPoint(
      lat: position.latitude,
      lng: position.longitude,
    );
  }

  factory LocationPoint.fromLatLng(LatLng position) {
    return LocationPoint(
      lat: position.latitude,
      lng: position.longitude,
    );
  }

  //<editor-fold desc="Data Methods">

  LocationPoint({
    this.lat,
    this.lng,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocationPoint &&
          runtimeType == other.runtimeType &&
          lat == other.lat &&
          lng == other.lng);

  @override
  int get hashCode => lat.hashCode ^ lng.hashCode;

  @override
  String toString() {
    return 'LocationPoint{' + ' lat: $lat,' + ' lng: $lng,' + '}';
  }

  LocationPoint copyWith({
    double? lat,
    double? lng,
  }) {
    return LocationPoint(
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'lat': this.lat,
      'lng': this.lng,
    };
  }

  factory LocationPoint.fromMap(Map<String, dynamic> map) {
    return LocationPoint(
      lat: map['lat'] as double,
      lng: map['lng'] as double,
    );
  }

//</editor-fold>
}

class AppMapUtils {
  static BitmapDescriptor? defaultPinIc;

  static void getDefaultPinIcon(BuildContext context,
      {required String pinAssetsPath}) {
    if (AppMapUtils.defaultPinIc == null) {
      AppMapUtils.bitmapDescriptorFromSvgAsset(
        context,
        pinAssetsPath,
      ).then((value) {
        AppMapUtils.defaultPinIc = value;
      });
    }
  }

  static Future<void> controllerToLocation(
      LatLng latLng, GoogleMapController controller) async {
    return controller
        .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: latLng,
      zoom: 15,
    )));
  }

  static Future<void> directionTo(
    LocationPoint location, {
    String? title,
    String? description,
  }) async {
    var availableGG = await MapLauncher.isMapAvailable(MapType.google);
    if (availableGG == true) {
      await MapLauncher.showDirections(
          mapType: MapType.google,
          destination: location.toCoords(),
          directionsMode: DirectionsMode.driving);
      return;
    }

    var availableApple = await MapLauncher.isMapAvailable(MapType.apple);
    if (availableApple == true) {
      await MapLauncher.showDirections(
          mapType: MapType.apple,
          destination: location.toCoords(),
          directionsMode: DirectionsMode.driving);
      return;
    }

    String googleUrl = Uri.parse(
            'https://www.google.com/maps?saddr=My+Location&daddr=${location.lat},${location.lng}')
        .toString();
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    }
  }

  // Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  static Future<Position> getCurLocation() async {
    try {
      bool serviceEnabled;

      await PermissionUtils.requestCurLocation();
      LocationPermission permission;
      // Test if location services are enabled.
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        // Location services are not enabled don't continue
        // accessing the position and request users of the
        // App to enable the location services.
        return Future.error('Location services are disabled.');
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          // Permissions are denied, next time you could try
          // requesting permissions again (this is also where
          // Android's shouldShowRequestPermissionRationale
          // returned true. According to Android guidelines
          // your App should show an explanatory UI now.
          return Future.error('Location permissions are denied');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        // Permissions are denied forever, handle appropriately.
        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      }

      // When we reach here, permissions are granted and we can
      // continue accessing the position of the device.
      return await Geolocator.getCurrentPosition();
    } catch (e) {
      logger.e(e);
      return Future.error(e);
    }
  }

  static Future<String> getAddressFromLatLng({required Position position, String? locale}) async {
    try {
      List<Placemark> placeMarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
        localeIdentifier: locale ?? 'vi_VN',
      );
      return Future.value(placeMarks.firstOrNull()?.name);
    } catch (e) {
      logger.e(e);
    }
    return Future.error('getAddressFromLatLng err');
  }

  static Future<BitmapDescriptor> bitmapDescriptorFromSvgAsset(
      BuildContext context, String assetName) async {
    MediaQueryData queryData = MediaQuery.of(context);
// Read SVG file as String
    String svgString =
        await DefaultAssetBundle.of(context).loadString(assetName);
    // Create DrawableRoot from SVG String
    DrawableRoot svgDrawableRoot = await svg.fromSvgString(svgString, '');

    // toPicture() and toImage() don't seem to be pixel ratio aware, so we calculate the actual sizes here
    double devicePixelRatio = queryData.devicePixelRatio;
    double width =
        32 * devicePixelRatio; // where 32 is your SVG's original width
    double height = 32 * devicePixelRatio; // same thing

    // Convert to ui.Picture
    ui.Picture picture = svgDrawableRoot.toPicture(size: Size(width, height));

    // Convert to ui.Image. toImage() takes width and height as parameters
    // you need to find the best size to suit your needs and take into account the
    // screen DPI
    ui.Image image = await picture.toImage(width.toInt(), height.toInt());
    ByteData? bytes = await image.toByteData(format: ui.ImageByteFormat.png);
    if (bytes == null) {
      logger.e('bytes == null');
      return Future.error('bytes == null');
    }

    return BitmapDescriptor.fromBytes(bytes.buffer.asUint8List());
  }
}
