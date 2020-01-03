import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SeSale',
      theme: ThemeData(
        primarySwatch: Colors.blue,
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
        title: Text('Inicio'),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(110, 255, 105, 90),
      ),
      // body: EventList(),
      body: Container(
        child: FutureBuilder<List<Event>>(
          builder: (context, snapshot) {
            // TODO crear lista para probar los eventos mostrados en la app
          },
        ),
      ),
    );
  }
}

class EventList extends StatefulWidget {
  EventList({Key key}) : super(key:key);

  @override
  EventListState createState() => EventListState();
}

class EventListState extends State<EventList> {
  final List<String> prueba = <String>['Primero','Segundo'];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(8),
      itemBuilder: (BuildContext context, int index) {
        return Container(
          height: 50,
          child: Center(child: Text('${prueba[index]}'),),
        );
      },
      itemCount: prueba.length, 
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }
}

// Opcion: Stateless

class EventListStateless extends StatelessWidget {
  final List<Event> events;

  EventListStateless({Key key, this.events}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: events.length,
      itemBuilder: (BuildContext context, int index) {
        return Column(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              child: Card(
                child: Column(
                  children: <Widget>[
                    ListTile(
                      title: Text(events[index].name),
                      subtitle: Text(events[index].description),
                    )
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

// Clases

class Event {
  final String name;
  final String description;
  DateTime when;
  final String location;
  final bool free;
  final bool adults;
  Set tags = new Set();

  Event({
    this.name,
    this.description,
    this.when,
    this.free,
    this.adults,
    this.location,
    this.tags,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      name: json['name'] as String,
      description: json['description'] as String,
      when: json['when'] as DateTime,
      free: json['free'] as bool,
      adults: json['adults'] as bool,
      location: json['location'] as String,
      tags: json['tags'] as Set,
    );
  }
}

// fetch
Future<List<Event>> fetchEvents(http.Client client) async {
  final response =
    await client.get('');

  return compute(parseEvents, response.body);
}

List<Event> parseEvents(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Event>((json) => Event.fromJson(json)).toList();
}