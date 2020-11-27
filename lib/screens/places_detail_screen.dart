import 'package:flutter/material.dart';
import 'package:great_places_app/models/places.dart';
import 'package:great_places_app/providers/great_places.dart';
import 'package:provider/provider.dart';

class PlaceDetail extends StatelessWidget {
  static const routeName = 'placeDetailRoute';
  const PlaceDetail({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments;
    final selected = Provider.of<GreatPlaces>(context, listen: false);
    // final selectedPlace =
    //     selected.items.firstWhere((element) => element.id == args);
    // print(args);

    return Scaffold(
      body: Center(
        child: RaisedButton(
          onPressed: () async {
            await selected.deletePlace(args);
            Navigator.of(context).pop();
          },
          child: Text('Delete place'),
        ),
      ),
    );
  }
}
