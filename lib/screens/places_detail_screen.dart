import 'package:flutter/material.dart';
import 'package:great_places_app/providers/great_places.dart';
import 'package:provider/provider.dart';

class PlaceDetail extends StatefulWidget {
  static const routeName = 'placeDetailRoute';
  const PlaceDetail({Key key}) : super(key: key);

  @override
  _PlaceDetailState createState() => _PlaceDetailState();
}

class _PlaceDetailState extends State<PlaceDetail> {
  closePage(BuildContext context, bool page) {
    if (page) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map args = ModalRoute.of(context).settings.arguments as Map;
    final selected = Provider.of<GreatPlaces>(context, listen: false);
    bool leavePage = false;
    // final selectedPlace =
    //     selected.items.firstWhere((element) => element.id == args);
    // print(args);

    return Scaffold(
      appBar: AppBar(
        title: Text(args['title']),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              showDialog(
                barrierDismissible: true,
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Deleting a great place?'),
                  content: Text(
                      'Are you sure to delete ${args['title']} from great places'),
                  actions: <Widget>[
                    FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('No'),
                    ),
                    FlatButton(
                      onPressed: () {
                        selected.deletePlace(args['id']);
                        setState(() {
                          leavePage = true;
                          closePage(context, leavePage);
                        });
                        Navigator.of(context).pop();
                      },
                      child: Text('Yes'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 350,
            width: double.infinity,
            child: Image.file(
              args['image'],
              fit: BoxFit.fill,
            ),
          ),
        ],
      ),
    );
  }
}
