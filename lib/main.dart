import 'package:flutter/material.dart';

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
      body: EventList(),
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
    // TODO: implement build
    return null;
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
  final Set tags = new Set();

  Event({
    this.name,
    this.description,
    this.when,
    this.free,
    this.adults,
    this.location,
  });

  // TODO Crear factory .fromjson
}