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
          future: fetchEvents,
          builder: (context, snapshot) {
            List<Event> events;
            List<Widget> list;

            if (snapshot.hasData) {
              print(snapshot.data);
              events = snapshot.data;
              list = <Widget>[
                ListView.builder(
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
                )
              ];
            }
            
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: list,
              ),
            );
          },
        ),
      ),
    );
  }
}

/* class EventList extends StatefulWidget {
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
} */

class EventList extends StatefulWidget {
  final List<Event> events;

  EventList({Key key, this.events}) : super(key:key);

  @override
  EventListState createState() => EventListState();
}

class EventListState extends State<EventList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return Column(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              child: Card(
                child: Column(
                  children: <Widget>[
                    ListTile(
                      title: Text(widget.events[index].name),
                      subtitle: Text(widget.events[index].description),
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

// Opcion: Stateless
/* 
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
 */
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

List<Event> parseEvents(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Event>((json) => Event.fromJson(json)).toList();
}

Future<List<Event>> returnEvents() async {
  final response =
    await http.get('https://c4b5da97-0954-4717-ae66-be7376616509.mock.pstmn.io/events');

    // https://c4b5da97-0954-4717-ae66-be7376616509.mock.pstmn.io

  return compute(parseEvents, response.body);
}

Future<List<Event>> fetchEvents = Future<List<Event>>.delayed(
  Duration(seconds: 2),
  () => returnEvents(),
);

// TODO Funciona, pero no devuelve los datos del JSON, puede ser un error en el parseo