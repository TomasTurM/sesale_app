import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import 'event_details/event_details.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SeSale',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Home(),
    );
  }
}

// Widgets

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Inicio',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(56, 142, 60, 90),
      ),
      body: Container(
        child: FutureBuilder<dynamic>(
          future: getJsonData(),
          // Puede que este haciendo peticiones por cada objeto que tiene la lista
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            return snapshot.hasData
              ? EventList(events: snapshot.data)
              : Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}

class EventList extends StatefulWidget {
  final List<dynamic> events;

  EventList({Key key, this.events}) : super(key:key);

  @override
  EventListState createState() => EventListState();
}

class EventListState extends State<EventList> {
  Widget moneyIcon(int index) {
    var icon = Icon(Icons.error_outline);
    if (widget.events[index]["price"] == null) {
      icon = Icon(Icons.money_off);
    } else {
      icon = Icon(Icons.attach_money);
    }

    return icon;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.events.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          child: InkResponse(
            child: Container(
              child: ListTile(
                title: Text(
                  widget.events[index]["name"], textScaleFactor: 1.3,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(widget.events[index]["when"]),
                trailing: moneyIcon(index),
                contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                isThreeLine: true,
              ),
            ),
            onTap: () {
              Navigator.push(
                context, 
                MaterialPageRoute(builder: (context) => DetailsPage(
                  event: widget.events[index]
                )),
              );
            },
          ),
        );
      },
    );
  }
}

// Clases

class Event {
  final String name;
  final String description;
  String when;
  final String location;
  final int price;
  final bool adults;
  Set tags = new Set();

  Event({
    this.name,
    this.description,
    this.when,
    this.price,
    this.adults,
    this.location,
    this.tags,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      name: json['name'] as String,
      description: json['description'] as String,
      when: json['when'] as String,
      price: json['price'] as int,
      adults: json['adults'] as bool,
      location: json['location'] as String,
      tags: json['tags'] as Set,
    );
  }
}

// fetch

int compareWhen(DateTime a, DateTime b) {
  int i;

  if (a.compareTo(b) == 0) {
    i = 0;
  }

  if (a.isBefore(b)) {
    i = -1;
  } else if (a.isAfter(b)) {
    i = 1;
  }

  return i;
}

Future getJsonData() async {
  var response = await Dio().get('https://c4b5da97-0954-4717-ae66-be7376616509.mock.pstmn.io/events');

  List<dynamic> list = response.data;

  list.sort((a, b) => compareWhen(DateTime.parse(a['when']), DateTime.parse(b['when'])));

  return list;
}