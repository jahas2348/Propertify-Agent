import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:propertify_for_agents/resources/components/buttons/custombuttons.dart';
import 'package:propertify_for_agents/resources/constants/spaces%20&%20paddings/spaces.dart';
import 'package:propertify_for_agents/view_models/controllers/property_view_model.dart';
import 'package:propertify_for_agents/views/add_property_screen/add_property_screen.dart';

class SearchScreen extends StatefulWidget {
  final bool isPop;
  final TextEditingController? propertyLatitude;
  final TextEditingController? propertyLongitude;

  SearchScreen({
    super.key,
    this.propertyLatitude,
    this.propertyLongitude,
    this.isPop = false,
  });

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  LatLng currentLocation = LatLng(11.321720411521987, 75.99506049016709);
  TextEditingController _searchController = TextEditingController();
  Set<Marker> markers = {};
  final propertyController = Get.find<PropertyViewModel>();
  GoogleMapController? _controller; // Define GoogleMapController

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  Future<void> getLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      setState(() {
        currentLocation = LatLng(position.latitude, position.longitude);
        markers.add(Marker(
          markerId: MarkerId('current_location'),
          position: currentLocation,
        ));
      });
    } catch (e) {
      print("Error getting location: $e");
    }
  }

  void _handleMapTap(LatLng tappedPoint) {
    print(
        "Tapped Point Coordinates: ${tappedPoint.latitude}, ${tappedPoint.longitude}");
    setState(() {
      currentLocation = tappedPoint;
      markers.clear();
      markers.add(Marker(
        markerId: MarkerId('current_location'),
        position: tappedPoint,
      ));
    });
    widget.propertyLatitude?.text = tappedPoint.latitude.toString();
    widget.propertyLongitude?.text = tappedPoint.longitude.toString();
    propertyController.propertyLatitude.text = tappedPoint.latitude.toString();
    propertyController.propertyLongitude.text =
        tappedPoint.longitude.toString();
  }

  void _searchAndMoveToLocation(String query) async {
    print("Searching for location with query: $query");
    try {
      List<Location> locations = await locationFromAddress(query);
      print("Number of locations found: ${locations.length}");
      if (locations.isNotEmpty) {
        Location location = locations.first;
        LatLng searchedLocation = LatLng(location.latitude, location.longitude);

        print(
            "Searched Location Coordinates: ${searchedLocation.latitude}, ${searchedLocation.longitude}");

        setState(() {
          currentLocation = searchedLocation;
          markers.clear();
          markers.add(Marker(
            markerId: MarkerId('current_location'),
            position: searchedLocation,
          ));
        });

        _moveCamera(searchedLocation); // Move camera to the searched location
      } else {
        print("No location found for the given query");
      }
    } catch (e) {
      print("Error searching location: $e");
    }
  }

  void _moveCamera(LatLng position) {
    _controller!.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: position,
        zoom: 10.0,
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  GoogleMap(
                    onMapCreated: (controller) {
                      _controller =
                          controller; // Assign controller when map is created
                    },
                    initialCameraPosition: CameraPosition(
                      target: currentLocation,
                      zoom: 10.0,
                    ),
                    markers: markers,
                    onTap: _handleMapTap,
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      color: Colors.grey.shade50,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _searchController,
                                onChanged: (text) async {
                                  // _searchAndMoveToLocation(text);
                                },
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Enter Address',
                                    hintStyle:
                                        TextStyle(color: Colors.grey.shade600)),
                              ),
                            ),
                            CircleAvatar(
                              radius: 20,
                              child: IconButton(
                                icon: Icon(
                                  Icons.search,
                                  size: 20,
                                ),
                                onPressed: () {
                                  _searchAndMoveToLocation(
                                      _searchController.text);
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 20,
                    bottom: 0,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 20, bottom: 20, right: 40, left: 20),
                      child: Row(
                        children: [
                          Expanded(
                            child: PrimaryButton(
                                buttonFunction: () {
                                  if (widget.isPop) {
                                    Navigator.of(context).pop();
                                  } else {
                                    Get.to(() => AddPropertyScreen());
                                  }
                                },
                                buttonText: 'Confirm Location'),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
