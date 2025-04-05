// import 'package:flutter/material.dart'; 
// import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart' as mapbox; 
// import 'package:geolocator/geolocator.dart' as geo;  

// class CustomerLocationMap extends StatefulWidget {   
//   final String cusLatitude;   
//   final String cusLongitude;   
//   final String deliverPartner;  

//   const CustomerLocationMap({     
//     super.key,     
//     required this.cusLatitude,     
//     required this.cusLongitude,     
//     required this.deliverPartner,   
//   });  

//   @override   
//   State<CustomerLocationMap> createState() => _CustomerLocationMapState(); 
// }  

// class _CustomerLocationMapState extends State<CustomerLocationMap> {   
//   mapbox.MapboxMap? mapboxMap;   
//   double? currentLat;   
//   double? currentLng;   
//   late mapbox.PointAnnotationManager pointAnnotationManager;       

//   @override   
//   void initState() {     
//     super.initState();     
//     _getCurrentLocation();   
//   }  

//   // Fetch current location   
//   Future<void> _getCurrentLocation() async {     
//     try {       
//       bool serviceEnabled = await geo.Geolocator.isLocationServiceEnabled();       
//       if (!serviceEnabled) {         
//         ScaffoldMessenger.of(context).showSnackBar(           const SnackBar(content: Text('Location services are disabled.')),         );         
//         return;       
//       }        

//       geo.LocationPermission permission = await geo.Geolocator.checkPermission();       
//       if (permission == geo.LocationPermission.denied) {         
//         permission = await geo.Geolocator.requestPermission();         
//         if (permission == geo.LocationPermission.denied) {           
//           ScaffoldMessenger.of(context).showSnackBar(             const SnackBar(content: Text('Location permissions are denied.')),           );           
//           return;         
//         }       
//       }        

//       geo.Position position = await geo.Geolocator.getCurrentPosition(         desiredAccuracy: geo.LocationAccuracy.high,       );        
//       setState(() {         
//         currentLat = position.latitude;         
//         currentLng = position.longitude;       });        

//       // Move the camera to the current location      
//       mapboxMap?.flyTo(   
//         mapbox.CameraOptions(     
//           center: mapbox.Point(       
//             coordinates: mapbox.Position(currentLng!, currentLat!), // (longitude, latitude)     
//           ),     
//           zoom: 14.0,   
//         ),   
//         mapbox.MapAnimationOptions(duration: 1000, startDelay: 0), 
//       );       
//       _addMarkers();     
//     } catch (e) {       
//       ScaffoldMessenger.of(context).showSnackBar(         SnackBar(content: Text('Error: $e')),       );     
//     }   
//   }  

//   // Add markers for start (current) and end (customer) location   
//   Future<void> _addMarkers() async {     
//     if (mapboxMap == null) return; 

//     pointAnnotationManager = await mapboxMap!.annotations.createPointAnnotationManager();      

//     // Marker for current location (start point)     
//     pointAnnotationManager.create(       
//       mapbox.PointAnnotationOptions(         
//         geometry: mapbox.Point(           
//           coordinates: mapbox.Position(currentLng!, currentLat!),
//         ),
//         iconImage: "assets/images/icons/home.png", // Replace with your marker icon
//       ),     
//     );      

//     // Marker for customer location (end point)     
//     pointAnnotationManager.create(       
//       mapbox.PointAnnotationOptions(         
//         geometry: mapbox.Point(           
//           coordinates: mapbox.Position(             
//             double.parse(widget.cusLongitude),
//             double.parse(widget.cusLatitude),           
//           ),         
//         ), 
//         iconImage: "assets/icons/bill.png", // Replace with your marker icon
//       ),     
//     );   
//   }    

//   @override   
//   Widget build(BuildContext context) {     
//     return Scaffold(       
//       body: currentLat == null || currentLng == null
//           ? const Center(child: CircularProgressIndicator())
//           : mapbox.MapWidget(         
//               key: const ValueKey("mapWidget"),
              
//               onMapCreated: (mapbox.MapboxMap map) {                 
//                 mapboxMap = map;                 
//                 _addMarkers();   
                       
//               },             
//             ),     
//     );   
//   } 
// }
