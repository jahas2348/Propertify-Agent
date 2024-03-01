import 'package:flutter/material.dart';
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
  final TextEditingController? propertyCity;

  SearchScreen({
    Key? key,
    this.propertyLatitude,
    this.propertyLongitude,
    this.propertyCity,
    this.isPop = false,
  }) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  LatLng? currentLocation; // Nullable
  TextEditingController _searchController = TextEditingController();
  Set<Marker> markers = {};
  // final propertyController = Get.find<PropertyViewModel>();
  GoogleMapController? _controller;
  String? mapStyle;
  String placeName = '';
  String address = '';
  String latitude = '';
  String longitude = '';
  String city = '';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadMapStyle();
    getLocation();
  }

  void _loadMapStyle() async {
    String jsonString = await DefaultAssetBundle.of(context)
        .loadString('assets/map_style.json');
    setState(() {
      mapStyle = jsonString;
    });
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
          position: currentLocation!,
          icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueAzure), // Custom marker icon
        ));
        isLoading = false; // Set loading state to false
      });
    } catch (e) {
      print("Error getting location: $e");
      isLoading = false; // Set loading state to false
    }
  }

  void _handleMapTap(LatLng tappedPoint) async {
    print(
        "Tapped Point Coordinates: ${tappedPoint.latitude}, ${tappedPoint.longitude}");

    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          tappedPoint.latitude, tappedPoint.longitude);
      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks.first;
        placeName = placemark.name ?? '';
        address = placemark.street ?? '';
        city = placemark.locality ?? '';

        String locationName = '$placeName, $address, $city';
        print("Location Name: $locationName");

        city = placemark.locality ?? 'Unknown City';
        print("City Name: $city");
      } else {
        print("No placemarks found for the given coordinates");
      }
    } catch (e) {
      print("Error getting placemarks: $e");
    }

    setState(() {
      currentLocation = tappedPoint;
      markers.clear();
      markers.add(Marker(
        markerId: MarkerId('current_location'),
        position: tappedPoint,
        infoWindow:
            InfoWindow(title: 'Choose this Location'), // Custom info window
        icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueBlue), // Custom marker icon
      ));
    });

    widget.propertyLatitude?.text = tappedPoint.latitude.toString();
    widget.propertyLongitude?.text = tappedPoint.longitude.toString();
    widget.propertyCity?.text = city.toString();
    // propertyController.propertyLatitude.text = tappedPoint.latitude.toString();
    // propertyController.propertyLongitude.text =
    //     tappedPoint.longitude.toString();
    // propertyCity.text = city.toString();
    latitude = tappedPoint.latitude.toString();
    longitude = tappedPoint.longitude.toString();
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
            infoWindow:
                InfoWindow(title: 'Custom Marker'), // Custom info window
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueAzure), // Custom marker icon
          ));
        });

        _moveCamera(searchedLocation);
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
        zoom: 14.0,
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: SafeArea(
        child: Stack(
          children: [
            if (currentLocation != null)
              GoogleMap(
                onMapCreated: (controller) {
                  _controller = controller;
                  _controller!.setMapStyle(mapStyle!);
                },
                initialCameraPosition: CameraPosition(
                  target: currentLocation!,
                  zoom: 13,
                ),
                markers: markers,
                onTap: _handleMapTap,
              ),
            if (isLoading) // Show progress indicator while loading
              Center(
                child: CircularProgressIndicator(),
              ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        bottom: BorderSide(color: Colors.grey.shade300),
                      ),
                    ),
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
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Enter Address',
                                  hintStyle:
                                      TextStyle(color: Colors.grey.shade400)),
                            ),
                          ),
                          CircleAvatar(
                            radius: 20,
                            child: IconButton(
                              icon: Icon(
                                Icons.search,
                                size: 16,
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
                  Container(
                    color: Colors.grey.shade200,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.info_outline_rounded,
                          size: 16,
                        ),
                        customSpaces.horizontalspace10,
                        Text(
                          'Search loaction for adding a new property',
                          style: TextStyle(fontSize: 12),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              left: 0,
              right: 20,
              bottom: 0,
              child: isLoading
                  ? Container()
                  : Padding(
                      padding: const EdgeInsets.only(
                          top: 20, bottom: 20, right: 40, left: 10),
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Selected Area",
                                    style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.grey.shade800),
                                  ),
                                  customSpaces.verticalspace5,
                                  Text(
                                    "${city}",
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600),
                                    maxLines: 1,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                                width: 10), // Add space between text and button
                            PrimaryButton(
                              buttonFunction: () {
                                if (widget.isPop) {
                                  Navigator.of(context).pop();
                                } else {
                                  Get.to(() => AddPropertyScreen(
                                        latitude: latitude,
                                        longitude: longitude,
                                        city: city,
                                      ));
                                }
                              },
                              buttonText: 'Confirm',
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
