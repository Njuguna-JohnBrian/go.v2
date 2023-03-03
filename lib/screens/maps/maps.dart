import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go/theme/go_theme.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  final Size size;
  const MapScreen({
    Key? key,
    required this.size,
  }) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.size.height,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        extendBody: true,
        body: Stack(
          children: [
            GoogleMap(
              initialCameraPosition: const CameraPosition(
                target: LatLng(
                  -0.433815,
                  36.9588839,
                ),
                zoom: 14,
              ),
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              markers: {
                Marker(
                  markerId: const MarkerId('Go'),
                  position: const LatLng(
                    -0.433815,
                    36.9588839,
                  ),
                  draggable: true,
                  onDragEnd: (value) {},
                  infoWindow: const InfoWindow(
                    title: "Trip Start Point",
                    snippet: "Start Point",
                  ),
                ),
              },
            ),
            Positioned(
              bottom: 0,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    isExpanded = !isExpanded;
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: isExpanded ? widget.size.height * 0.6 : widget.size.height * 0.25,
                  width: widget.size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(
                          0.5,
                        ),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(
                          0,
                          3,
                        ),
                      )
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: widget.size.height * 0.04,
                        child: IconButton(
                          tooltip: 'Expand',
                          icon: Transform.rotate(
                            angle: isExpanded ? pi / 0.9 : 0.45,
                            child: const Icon(
                              Icons.swipe_up,
                              size: 30,
                              color: GoTheme.mainColor,
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              isExpanded = !isExpanded;
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: ListView.separated(
                          separatorBuilder: (
                            BuildContext context,
                            int index,
                          ) =>
                              SizedBox(
                            width: widget.size.width * 0.015,
                            height: isExpanded ? widget.size.height * 0.015 : 0,
                          ),
                          scrollDirection:
                              isExpanded ? Axis.vertical : Axis.horizontal,
                          itemCount: 10,
                          itemBuilder: (context, index) {
                            return CachedNetworkImage(
                              imageUrl: "https://tinyurl.com/msm6h9pd",
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
