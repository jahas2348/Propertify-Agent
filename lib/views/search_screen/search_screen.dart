// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class SearchScreen extends StatelessWidget {
//    SearchScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(child: Column(
//         children: [
//           customSpaces.verticalspace20,
//           Padding(
//             padding: customPaddings.horizontalpadding20,
//             child: CustomInputField(fieldIcon: Icons.search, hintText: 'Serach for properties'),
//           )
//         ],
//       )),
//     );
//   }
// }

// class SearchScreen extends StatefulWidget {
//   @override
//   _SearchScreenState createState() => _SearchScreenState();
// }

// class _SearchScreenState extends State<SearchScreen> {
//   GoogleMapController? mapController;
//   LatLng? _selectedLocation;

//   void _onMapCreated(GoogleMapController controller) {
//     mapController = controller;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Google Maps Example'),
//       ),
//       body: Container(
//         child: GoogleMap(
//           onMapCreated: _onMapCreated,
//           onTap: (LatLng location) {
//             setState(() {
//               _selectedLocation = location;
//             });
//           },
//           markers: _selectedLocation != null
//               ? <Marker>{
//                   Marker(
//                     markerId: MarkerId('Selected Location'),
//                     position: _selectedLocation!,
//                     infoWindow: InfoWindow(title: 'Selected Location'),
//                   ),
//                 }
//               : <Marker>{},
//           initialCameraPosition: CameraPosition(
//             target: _selectedLocation ?? LatLng(11.228854081601188,76.05469208210707), // Use a default center if _selectedLocation is null
//             zoom: 15.0,
//           ),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           if (_selectedLocation != null) {
//             print("Latitude: ${_selectedLocation!.latitude}");
//             print("Longitude: ${_selectedLocation!.longitude}");
//           } else {
//             print("No location selected.");
//           }
//         },
//         child: Icon(Icons.location_on),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class SearchScreen extends StatefulWidget {

  final TextEditingController? propertyLatitude;
  final TextEditingController? propertyLongitude;

   SearchScreen({super.key,  this.propertyLatitude,  this.propertyLongitude});
  
  
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  LatLng currentLocation = LatLng(11.321720411521987, 75.99506049016709);
  TextEditingController _searchController = TextEditingController();
  Set<Marker> markers = {};

  @override
  void initState() {
    super.initState();
    getLocation(); // Get current location initially
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

    print("Tapped Point Coordinates: ${tappedPoint.latitude}, ${tappedPoint.longitude}");
    widget.propertyLatitude?.text = tappedPoint.latitude.toString();
    widget.propertyLongitude?.text = tappedPoint.longitude.toString();
    setState(() {
      currentLocation = tappedPoint;
      markers.clear();
      markers.add(Marker(
        markerId: MarkerId('current_location'),
        position: tappedPoint,
      ));
    });
  }

  Future<void> _searchAndMoveToLocation(String query) async {
    try {
      List<Location> locations = await locationFromAddress(query);
      if (locations.isNotEmpty) {
        Location location = locations.first;
        LatLng searchedLocation = LatLng(location.latitude, location.longitude);

        print("Searched Location Coordinates: ${searchedLocation.latitude}, ${searchedLocation.longitude}");

        setState(() {
          currentLocation = searchedLocation;
          markers.clear();
          markers.add(Marker(
            markerId: MarkerId('current_location'),
            position: searchedLocation,
          ));
        });
      } else {
        print("No location found for the given query");
      }
    } catch (e) {
      print("Error searching location: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(20.0),
          child: FloatingActionButton(
            
          child: Icon(Icons.check),
          onPressed: () {
          Navigator.of(context).pop();
          
              },),
        ),
        body: Stack(
          children: [
            GoogleMap(
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
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _searchController,
                            onChanged: (text) {},
                            decoration: InputDecoration(
                              hintText: 'Enter Address',
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.search),
                          onPressed: () {
                            _searchAndMoveToLocation(_searchController.text);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
