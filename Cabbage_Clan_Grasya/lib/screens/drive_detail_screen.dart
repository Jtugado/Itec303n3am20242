import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DriveDetailScreen extends StatefulWidget {
  static const routeName = '/drive-detail';

  const DriveDetailScreen({Key? key}) : super(key: key);

  @override
  State<DriveDetailScreen> createState() => _DriveDetailScreenState();
}

class _DriveDetailScreenState extends State<DriveDetailScreen> {
  final Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(13.6210, 123.2008), 
    zoom: 15,
  );

  @override
  Widget build(BuildContext context) {
    // drive data passed from HomeScreen
    final driveData = ModalRoute.of(context)?.settings.arguments as Map<String, String>?;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          driveData?['title'] ?? 'Drive Detail',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 4,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Map Section with rounded corners
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: SizedBox(
                  height: 220,
                  width: double.infinity,
                  child: GoogleMap(
                    onMapCreated: (controller) {
                      _controller.complete(controller);
                    },
                    initialCameraPosition: _initialPosition,
                    markers: {
                      const Marker(
                        markerId: MarkerId('driveMarker'),
                        position: LatLng(13.1391, 123.7438),
                        infoWindow: InfoWindow(title: 'Drive Location'),
                      ),
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Title
              Text(
                driveData?['title'] ?? '',
                style: Theme.of(context).textTheme.displayLarge,
              ),
              const SizedBox(height: 8),
              const SizedBox(height: 8),
              // Subtitle
              Text(
                driveData?['subtitle'] ?? '',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
              ),
              const SizedBox(height: 20),
              const Divider(),
              const SizedBox(height: 12),
              // Items Needed Section
              const Text(
                "Items Needed:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 6),
              const Text(
                "• School equipment\n• Shoes\n• Clothing\n• Books",
                style: TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 20),
              // Volunteers Needed Section
              const Text(
                "Volunteers Needed:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 6),
              const Text(
                "5 Volunteers",
                style: TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 20),
              const Divider(),
              const SizedBox(height: 12),
              // About Section
              const Text(
                "About Angat Buhay:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 6),
              const Text(
                "Angat Buhay, officially known as Angat Pinas, Inc., is a Philippine non-profit organization founded by former Vice President Leni Robredo on July 1, 2022. The organization aims to empower Filipinos by mobilizing a vast volunteer network to implement programs focused on key areas: Public Education, Health, Livelihoods, and Environment.",
                style: TextStyle(fontSize: 14),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
