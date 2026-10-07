import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: .center,
          children: [
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
Future<void> readJson() async {
  final String response = await rootBundle.loadString('assets/sample.json');
  final data = await json.decode(response);
// ... 
}
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'People',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const PeoplePage(),
    );
  }
}

class PeoplePage extends StatefulWidget {
  const PeoplePage({super.key});

  @override
  State<PeoplePage> createState() => _PeoplePageState();
}

class _PeoplePageState extends State<PeoplePage> {
  List<Map<String, dynamic>> people = [];

  bool isLoading = true;

  // Controllers for the add-person form
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();

  bool member = true;

  @override
  void initState() {
    super.initState();
    loadPeople();
  }

  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();
    super.dispose();
  }

  // ------------------------------------------------------------
  // JSON file
  // ------------------------------------------------------------

  Future<File> getJsonFile() async {
    final directory = await getApplicationDocumentsDirectory();

    return File('${directory.path}/people.json');
  }

  
  // Load JSON


  Future<void> loadPeople() async {
    try {
      final file = await getJsonFile();

      // If this is the first time the application runs,
      // copy the JSON from assets to the writable directory.
      if (!await file.exists()) {
        final initialJson =
            await rootBundle.loadString('assets/people.json');

        await file.writeAsString(initialJson);
      }

      // Read the editable JSON file
      final jsonString = await file.readAsString();

      final decoded = jsonDecode(jsonString);

      setState(() {
        people = List<Map<String, dynamic>>.from(decoded);
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });

      debugPrint('Error loading JSON: $e');
    }
  }

 
  // Save JSON


  Future<void> savePeople() async {
    try {
      final file = await getJsonFile();

      final jsonString = const JsonEncoder.withIndent('  ').convert(people);

      await file.writeAsString(jsonString);

      debugPrint('JSON saved successfully');
    } catch (e) {
      debugPrint('Error saving JSON: $e');
    }
  }

  // Add a new person
 

  Future<void> addPerson() async {
    final name = nameController.text.trim();
    final age = ageController.text.trim();

    if (name.isEmpty || age.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a name and age.'),
        ),
      );

      return;
    }

    final newPerson = <String, dynamic>{
      'nimi': name,
      'vanus': age,
      'member': member,
    };

    setState(() {
      people.add(newPerson);
    });

    // Automatically save the complete list
    await savePeople();

    // Clear the form
    nameController.clear();
    ageController.clear();

    setState(() {
      member = true;
    });

    if (mounted) {
      Navigator.of(context).pop();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Person added and saved.'),
        ),
      );
    }
  }

 
  // Show add-person form
 

  void showAddPersonDialog() {
    nameController.clear();
    ageController.clear();

    setState(() {
      member = true;
    });

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text('Add person'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        labelText: 'Name',
                        hintText: 'Joonas',
                        border: OutlineInputBorder(),
                      ),
                    ),

                    const SizedBox(height: 16),

                    TextField(
                      controller: ageController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Age',
                        hintText: '14',
                        border: OutlineInputBorder(),
                      ),
                    ),

                    const SizedBox(height: 16),

                    SwitchListTile(
                      title: const Text('Member'),
                      value: member,
                      onChanged: (value) {
                        setDialogState(() {
                          member = value;
                        });
                      },
                    ),
                  ],
                ),
              ),

              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),

                ElevatedButton(
                  onPressed: addPerson,
                  child: const Text('Add'),
                ),
              ],
            );
          },
        );
      },
    );
  }


  // Build UI
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('People'),
      ),

      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : people.isEmpty
              ? const Center(
                  child: Text('No people found.'),
                )
              : ListView.builder(
                  itemCount: people.length,
                  itemBuilder: (context, index) {
                    final person = people[index];

                    return Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),

                      child: ListTile(
                        leading: CircleAvatar(
                          child: Text(
                            person['nimi']
                                    ?.toString()
                                    .substring(0, 1)
                                    .toUpperCase() ??
                                '?',
                          ),
                        ),

                        title: Text(
                          person['nimi']?.toString() ?? '',
                        ),

                        subtitle: Text(
                          'Age: ${person['vanus']}',
                        ),

                        trailing: person['member'] == true
                            ? const Chip(
                                label: Text('Member'),
                              )
                            : const Chip(
                                label: Text('Not member'),
                              ),
                      ),
                    );
                  },
                ),

      // Add button
      floatingActionButton: FloatingActionButton(
        onPressed: showAddPersonDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
//-----------------------------------------------------------------
// Ülesanne 6
//-----------------------------------------------------------------
import 'package:http/http.dart' as http;
import 'package:material_ui/material_ui.dart';
Future<http.Response> fetchAlbum() {
  return http.get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));
}
class Album {
  final int userId;
  final int id;
  final String title;

  const Album({required this.userId, required this.id, required this.title});

  factory Album.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {'userId': int userId, 'id': int id, 'title': String title} => Album(
        userId: userId,
        id: id,
        title: title,
      ),
      _ => throw const FormatException('Failed to load album.'),
    };
  }
}
Future<Album> fetchAlbum() async {
  final response = await http.get(
    Uri.parse('http://192.168.42.160:3001/people'),
    headers: {'Accept': 'application/json'},
  );

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Album.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}
class _MyAppState extends State<MyApp> {
  late Future<Album> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
  }
  // ···
}

