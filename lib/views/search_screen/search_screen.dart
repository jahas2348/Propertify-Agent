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
import 'package:geocoding/geocoding.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  LatLng currentLocation = LatLng(11, 11);
  TextEditingController _searchController = TextEditingController();
  List<Placemark> _suggestions = [];

  Future<void> onSearchChanged() async {
    final query = _searchController.text;
    if (query.isNotEmpty) {
      final locations = await locationFromAddress(query);
      if (locations != null && locations.isNotEmpty) {
        final placemarks = await placemarkFromCoordinates(
          locations[0].latitude,
          locations[0].longitude,
        );
        setState(() {
          _suggestions = placemarks;
        });
      } else {
        setState(() {
          _suggestions = [];
        });
      }
    } else {
      setState(() {
        _suggestions = [];
      });
    }
  }

  void selectLocation(Placemark placemark) {
    final locationName = placemark.name;
    locationFromAddress(locationName!).then((locations) {
      if (locations != null && locations.isNotEmpty) {
        final latitude = locations[0].latitude;
        final longitude = locations[0].longitude;

        setState(() {
          currentLocation = LatLng(latitude, longitude);
          _searchController.clear();
          _suggestions.clear();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Screen'),
      ),
      body: FutureBuilder(
        future: Future.value(currentLocation),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final LatLng? location = snapshot.data;
            return Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: CameraPosition(target: location!, zoom: 16.0),
                  markers: {
                    Marker(
                      markerId: MarkerId('current_location'),
                      position: location,
                    ),
                  },
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      controller: _searchController,
                      onChanged: (text) => onSearchChanged(),
                      decoration: InputDecoration(
                        hintText: 'Enter Address',
                        suffixIcon: IconButton(
                          icon: Icon(Icons.search),
                          onPressed: () {
                            // Handle search and show suggestions here
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 80,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: ListView.builder(
                    itemCount: _suggestions.length,
                    itemBuilder: (context, index) {
                      final suggestion = _suggestions[index];
                      return ListTile(
                        title: Text(suggestion.name ?? ''),
                        subtitle: Text(suggestion.street ?? ''),
                        onTap: () {
                          selectLocation(suggestion);
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}