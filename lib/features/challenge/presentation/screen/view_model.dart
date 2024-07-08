import 'dart:async';
import 'dart:io';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapViewModel implements MapViewModelInput, MapViewModelOutput {
  final StreamController<bool> _isFormValidStreamController =
      StreamController<bool>.broadcast();
  final StreamController<File> _imageOrderController =
      StreamController<File>.broadcast();
  final StreamController<String> _addressOrderController =
      StreamController<String>.broadcast();
  final StreamController<Position> _currentPositionController =
      StreamController<Position>.broadcast();
  final StreamController<List<Marker>> _markersController =
      StreamController<List<Marker>>.broadcast();
  final StreamController<List<Polyline>> _polyLinesController =
      StreamController<List<Polyline>>.broadcast();
  LatLng? _currentLatLng;
  LatLng? _sourceLatLng;
  LatLng? _destinationLatLng;
  List<Marker> markers = [];
  List<Polyline> polyLines = [];
  List<LatLng> polyLineCoordinates = [];

  MapModel mapModel = MapModel();

  void start() {
    _bind();
  }

  void dispose() {
    _isFormValidStreamController.close();
    _imageOrderController.close();
    _addressOrderController.close();
    _currentPositionController.close();
    _markersController.close();
    _polyLinesController.close();
  }

  @override
  Stream<bool> get outIsFormValid => _isFormValidStreamController.stream;

  @override
  Stream<File> get outLocationImage => _imageOrderController.stream;

  @override
  Stream<List<Polyline>> get outPolyLines => _polyLinesController.stream;

  @override
  Sink get inputLocationImage => _imageOrderController.sink;

  @override
  Stream<String> get outLocationAddress => _addressOrderController.stream;

  @override
  Stream<Position> get outCurrentPosition => _currentPositionController.stream;

  @override
  Stream<List<Marker>> get outMarkers => _markersController.stream;

  @override
  Sink get inputCurrentPosition => _currentPositionController.sink;

  @override
  Sink get inputLocationAddress => _addressOrderController.sink;

  @override
  Sink get inputMarkers => _markersController.sink;

  @override
  Sink get inputPolyLines => _polyLinesController.sink;



  Future<void> _bind() async {
    await _requestPermissionAndGetLocation();
    await getPosition();
  }

  Future<void> getPosition() async {
    final Position pos = await Geolocator.getCurrentPosition();
    _currentLatLng = LatLng(pos.latitude, pos.longitude);
    inputCurrentPosition.add(pos);
    // setMarker(_currentLatLng!);
  }

  Future<void> _requestPermissionAndGetLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return;
    }
  }

  void setSourceMarker(LatLng latLng) {
    _sourceLatLng = latLng;
    print('${_sourceLatLng!.latitude} ${_sourceLatLng!.longitude}');
    mapModel.sourceLatLng = latLng;
    _updateMarkers();
    _isFormValidStreamController.add(true);
  }

  void _updateMarkers() {
    markers.clear();
    if (_sourceLatLng != null) {
      print('source');
      markers.add(
        Marker(
          markerId: const MarkerId('source'),
          position: _sourceLatLng!,
        ),
      );
    }
    if (_destinationLatLng != null) {
      print('desnation');
      markers.add(Marker(
        markerId: const MarkerId('destination'),
        position: _destinationLatLng!,
      ));
    }
    inputMarkers.add(markers);
  }

}

abstract class MapViewModelInput {

  Sink get inputMarkers;

  Sink get inputLocationImage;

  Sink get inputLocationAddress;

  Sink get inputCurrentPosition;

  Sink get inputPolyLines;
}

abstract class MapViewModelOutput {
  Stream<bool> get outIsFormValid;

  Stream<File> get outLocationImage;

  Stream<String> get outLocationAddress;

  Stream<Position> get outCurrentPosition;

  Stream<List<Marker>> get outMarkers;

  Stream<List<Polyline>> get outPolyLines;
}

class MapModel {
  LatLng? sourceLatLng;
  LatLng? destinationLatLng;
  String? sourceAddress;
  String? destinationAddress;
  File? image;

  MapModel(
      {this.sourceLatLng,
      this.destinationLatLng,
      this.sourceAddress,
      this.destinationAddress,
      this.image});
}

