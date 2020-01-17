import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Text Styles
import 'package:sesale/text_styles/styles.dart';

// widgets

class DetailsPage extends StatefulWidget {
  final dynamic event;

  DetailsPage({Key key, this.event}) : super(key:key);

  @override
  DetailsPageState createState() => DetailsPageState();
}

// Every icon´s size
double iconSize = 45.0;

class DetailsPageState extends State<DetailsPage> {
  
  List<Widget> tagsBuilder(dynamic tags) {
    List<Widget> tagsList = [];

    for (int i = 0; i < tags.length; i++) {
      tagsList.add(
        Chip(
          label: Text(
            tags[i],
            style: chipsTextStyle(),
          ),
          labelPadding: EdgeInsets.all(10.0),
        )
      );
    }

    return tagsList;
  }

  @override
  Widget build(BuildContext context) {
    var margin = EdgeInsets.all(10.0);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.event["name"]),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(56, 142, 60, 90),
      ),
      body: ListView(
        padding: EdgeInsets.only(top: 10.0),
        children: <Widget>[
          Container(
            margin: margin,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Flexible(
                  flex: 2,
                  fit: FlexFit.tight,
                  child: Icon(Icons.calendar_today, size: iconSize),
                ),
                Flexible(
                  flex: 10,
                  fit: FlexFit.tight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Cuando", style: subtitlesStyle()),
                      Text(widget.event["when"], style: normalTextStyle(),),
                    ],
                  )
                ),
              ],
            ),
          ),
          Container(
            margin: margin,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Flexible(
                  flex: 2,
                  fit: FlexFit.tight,
                  child: Icon(Icons.location_on, size: 50.0),
                ),
                Flexible(
                  flex: 10,
                  fit: FlexFit.tight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Donde", style: subtitlesStyle()),
                      Text(widget.event["location"], style: normalTextStyle()),
                    ],
                  )
                ),
              ],
            ),
          ),
          Container(
            margin: margin,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Flexible(
                  flex: 2,
                  fit: FlexFit.tight,
                  child: Icon(Icons.monetization_on, size: iconSize),
                ),
                Flexible(
                  flex: 10,
                  fit: FlexFit.tight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      isFree(widget.event["free"]),
                    ],
                  )
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(10, 15, 10, 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: ageRestriction(widget.event["adults"]),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 45.0),
            margin: EdgeInsets.fromLTRB(15.0, 0, 15.0, 0),
            child: Column(
              children: <Widget>[
                Text(
                  "Descripcion", 
                  style: TitleStyle(),
                ),
                Text(
                  widget.event["description"], 
                  style: normalTextStyle(),
                  textAlign: TextAlign.justify,
                ),
              ],
            )
          ),
          Container(
            padding: EdgeInsets.only(left: 15.0, top: 10.0, bottom: 15.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: tagsBuilder(widget.event["tags"]),
            ),
          ),
        ],
      ),
    );
  }
}

Widget isFree(bool free) {
  Text text = Text("");

  if (free) {
    text = Text("Gratis", style: subtitlesStyle());
  } else {
    text = Text("Pago", style: subtitlesStyle());
  }

  return text;
}

List<Widget> ageRestriction(bool adults) {
  Icon icon = Icon(Icons.do_not_disturb_on, size: iconSize);
  Text text = Text("");
  List<Widget> widgets = [];

  if (adults) {
    icon = Icon(Icons.wc, size: iconSize);
    text = Text("Para adultos", style: subtitlesStyle());
  } else {
    icon = Icon(Icons.child_friendly, size: 50.0);
    text = Text("Para todas las edades", style: subtitlesStyle());
  }

  widgets.insert(
    0, 
    Flexible(
      child: icon,
      flex: 2,
      fit: FlexFit.tight,
    )
  );

  widgets.insert(
    1, 
    Flexible(
      child: text,
      flex: 10,
      fit: FlexFit.tight,
    )
  );

  return widgets;
}

// TODO abstraer el appbar de main.dart