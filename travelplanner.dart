import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class Destination {
  final String name;
  final List<String> activities;

  Destination(this.name, this.activities);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Travel Planner',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TravelPlanner(),
    );
  }
}

class TravelPlanner extends StatefulWidget {
  @override
  _TravelPlannerState createState() => _TravelPlannerState();
}

class _TravelPlannerState extends State<TravelPlanner> {
  List<Destination> destinations = [];

  void _addDestination(String name, List<String> activities) {
    setState(() {
      destinations.add(Destination(name, activities));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Travel Planner'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: destinations.length,
              itemBuilder: (context, index) {
                return DestinationCard(destinations[index]);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                _showAddDestinationDialog(context);
              },
              child: Text('Add Destination'),
            ),
          ),
        ],
      ),
    );
  }

  void _showAddDestinationDialog(BuildContext context) {
    String destinationName = '';
    List<String> activities = [];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Destination'),
          content: Column(
            children: <Widget>[
              TextField(
                onChanged: (value) {
                  destinationName = value;
                },
                decoration: InputDecoration(labelText: 'Destination Name'),
              ),
              TextField(
                onChanged: (value) {
                  activities = value.split(',').map((e) => e.trim()).toList();
                },
                decoration: InputDecoration(labelText: 'Activities (comma-separated)'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Add'),
              onPressed: () {
                _addDestination(destinationName, activities);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

class DestinationCard extends StatelessWidget {
  final Destination destination;

  DestinationCard(this.destination);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              destination.name,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Activities: ${destination.activities.join(", ")}',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
