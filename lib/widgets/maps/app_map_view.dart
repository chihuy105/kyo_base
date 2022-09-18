import 'package:kyo_base/imports/base_component_import.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AppMapView extends StatefulWidget {
  const AppMapView({
    Key? key,
    this.location,
    this.markerId,
    this.title,
    this.onGetCurPosition,
    this.controller,
    this.showMyLocation = false,
    this.zoomLevel = 16,
    this.dragAble = false,
    this.markerList,
    this.onTap,
    this.onMapCreated,
    this.moveToCurrentPosition = true,
  }) : super(key: key);

  final Completer<GoogleMapController>? controller;

  final double zoomLevel;
  final bool showMyLocation;
  final LocationPoint? location;
  final String? title;
  final bool dragAble;
  final bool moveToCurrentPosition;

  // Event
  final void Function(Position position)? onGetCurPosition;
  final void Function(LatLng latLng)? onTap;
  final MapCreatedCallback? onMapCreated;

  // Markers
  final Set<Marker>? markerList;
  final String? markerId;

  @override
  State<AppMapView> createState() => _AppMapViewState();
}

class _AppMapViewState extends State<AppMapView> {
  late final LocationPoint _location;
  late final Completer<GoogleMapController> _controller;

  @override
  void initState() {
    try {
      _location =
          widget.location ?? LocationPoint(lat: 10.7820083, lng: 106.6905233);
      _controller = widget.controller ?? Completer();

      if (widget.moveToCurrentPosition && widget.location.isNullOrEmpty()) {
        AppMapUtils.getCurLocation().then((value) {
          setState(() {
            _location.lat = value.latitude;
            _location.lng = value.longitude;
            widget.onGetCurPosition?.call(value);
            _location.toCameraLocation(_controller);
          });
        });
      }
    } catch (e) {
      logger.e(e);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Set<Factory<OneSequenceGestureRecognizer>> gesture = {};
    if (widget.dragAble) {
      gesture.add(Factory<OneSequenceGestureRecognizer>(
        () => EagerGestureRecognizer(),
      ));
    }

    return GoogleMap(
      // liteModeEnabled: Platform.isAndroid ? true : false,
      mapType: MapType.normal,
      onTap: widget.onTap ??
          (latLng) {
            AppMapUtils.directionTo(_location);
          },
      initialCameraPosition: CameraPosition(
        target: _location.toLatLng(),
        zoom: widget.zoomLevel,
      ),
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
        widget.onMapCreated?.call(controller);
      },
      // liteModeEnabled: Platform.isAndroid ? !widget.dragAble : false,
      markers: _getMarkerList(context),
      mapToolbarEnabled: true,
      myLocationEnabled: widget.showMyLocation,
      myLocationButtonEnabled: widget.showMyLocation,
      gestureRecognizers: gesture,
    );
  }

  _getMarkerList(BuildContext context) {
    final makerListParam = widget.markerList
        ?.map((item) => item.copyWith(
            iconParam:
                AppMapUtils.defaultPinIc ?? BitmapDescriptor.defaultMarker))
        .toSet();
    if (makerListParam.isNotNullOrEmpty()) {
      return makerListParam;
    }

    var currentLocationMarker = Marker(
      icon: AppMapUtils.defaultPinIc ?? BitmapDescriptor.defaultMarker,
      markerId: MarkerId(widget.markerId ?? _location.getMarkerId()),
      position: _location.toLatLng(),
      infoWindow: InfoWindow(title: widget.title, snippet: ''),
    );

    return <Marker>{currentLocationMarker};
  }
}
