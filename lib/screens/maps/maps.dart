import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  final double latitude;
  final double longitude;
  const MapScreen({
    Key? key,
    required this.latitude,
    required this.longitude,
  }) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(
            widget.latitude,
            widget.longitude,
          ),
          zoom: 14,
        ),
        myLocationEnabled: true,
        markers: {
          Marker(
              markerId: const MarkerId('Go'),
              position: LatLng(
                widget.latitude,
                widget.longitude,
              ),
              draggable: true,
              onDragEnd: (value) {},
              infoWindow: const InfoWindow(
                title: "Trip Start Point",
                snippet: "Start Point",
              )),
        },
      ),
    );
  }
}
