import 'package:flutter/material.dart' show BuildContext, Key, State, StatefulWidget, Widget;
import 'package:google_maps_flutter/google_maps_flutter.dart' show CameraPosition, GoogleMap, GoogleMapController, LatLng, MapType;
import 'package:location/location.dart' show Location, LocationData, PermissionStatus;

class MyMap extends StatefulWidget {
  const MyMap({Key? key, required this.latitude, required this.longitude})
      : super(key: key);

  final double latitude;
  final double longitude;
  @override
  State<MyMap> createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
  late GoogleMapController mapController;
  Location location = new Location();

  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  late LocationData _locationData;

  // double latitude = 23.176890894138687;
  // double longitude = 80.0233220952035;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentLocator();
  }

  void getCurrentLocator() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
  }

  @override
  void dispose() {
    // _googleMapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    CameraPosition _kGooglePlex = CameraPosition(
      target: LatLng(widget.latitude, widget.longitude),
      zoom: 14,
    );
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: _kGooglePlex,
      onMapCreated: _onMapCreated,
      myLocationButtonEnabled: true,
      compassEnabled: true,
      zoomControlsEnabled: false,
    );
  }

  _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
  }
}
