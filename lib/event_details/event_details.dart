import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// widgets

class DetailsPage extends StatefulWidget {
  final dynamic event;

  DetailsPage({Key key, this.event}) : super(key:key);

  @override
  DetailsPageState createState() => DetailsPageState();
}

class DetailsPageState extends State<DetailsPage> {
  
  List<Widget> tagsBuilder(dynamic tags) {
    List<Widget> tagsList = [];

    for (int i = 0; i < tags.length; i++) {
      tagsList.add(
        Chip(
          label: Text(tags[i]),
        )
      );
    }

    return tagsList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.event["name"]),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(110, 255, 105, 90),
      ),
      body: ListView(
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.calendar_today),
              Column(
                children: <Widget>[
                  Text("Cuando"),
                  Text(widget.event["when"]),
                ],
              )
            ],
          ),
          Row(
            children: <Widget>[
              Icon(Icons.location_on),
              Column(
                children: <Widget>[
                  Text("Donde"),
                  Text(widget.event["location"]),
                ],
              )
            ],
          ),
          Row(
            children: <Widget>[
              Icon(Icons.monetization_on),
              Column(
                children: <Widget>[
                  isFree(widget.event["free"]),
                ],
              )
            ],
          ),
          Row(
            children: ageRestriction(widget.event["adults"]),
          ),
          Text("Descripcion"),
          Text(widget.event["description"]),
          Row(
            children: tagsBuilder(widget.event["tags"]),
          ),
        ],
      ),
    );
  }
}

Widget isFree(bool free) {
  Text text = Text("");

  if (free) {
    text = Text("Gratis");
  } else {
    text = Text("Pago");
  }

  return text;
}

List<Widget> ageRestriction(bool adults) {
  Icon icon = Icon(Icons.do_not_disturb_on);
  Text text = Text("");
  List<Widget> widgets = [];

  if (adults) {
    icon = Icon(Icons.wc);
    text = Text("Para adultos");
  } else {
    icon = Icon(Icons.child_friendly);
    text = Text("Para todas las edades");
  }

  widgets.insert(0, icon);
  widgets.insert(1, text);

  return widgets;
}

// TODO abstraer el appbar de main.dart