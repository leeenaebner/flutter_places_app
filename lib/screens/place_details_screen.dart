import 'package:flutter/material.dart';
import 'package:places_app/helpers/location_helper.dart';
import 'package:places_app/providers/great_places.dart';
import 'package:provider/provider.dart';

class PlaceDetailScreen extends StatelessWidget {
  static const routeName = "/place-details";
  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments as String;

    final _selectedPlace =
        Provider.of<GreatPlaces>(context, listen: false).findById(id);

    return Scaffold(
      appBar: AppBar(
        title: Text("Place Details"),
      ),
      body: Column(
        children: [
          Container(
            height: 250,
            width: double.infinity,
            child: Image.file(
              _selectedPlace.image,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              _selectedPlace.location!.address!,
              style: TextStyle(fontSize: 20, color: Colors.grey),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Column(
            children: [
              Text("Where to find on map"),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 200,
                width: double.infinity,
                child: Image.network(
                  LocationHelper.generateLocatonPreviewImage(
                      _selectedPlace.location!.latitude,
                      _selectedPlace.location!.longitude),
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
