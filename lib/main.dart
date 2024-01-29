import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/model.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

//creating a provider for the category class
final categoryProvider = ChangeNotifierProvider((ref) => Category(
      ActivityConnectUID: '1',
      activityList: [],
      createdOn: DateTime.now(),
      isCountBased: true,
      name: 'Study',
    ));

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Riverpod Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const CategoryConsumer(),
    );
  }
}

//creating consumer widget for category
class CategoryConsumer extends ConsumerWidget {
  const CategoryConsumer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final category = ref.watch(categoryProvider);
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.black,
        title: Text(category.name),
        elevation: 4,
      ),
      body: ListView.builder(
        itemCount: category.activityList.length,
        itemBuilder: (context, index) {
          final activity = category.activityList[index];
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListTile(
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.deepPurpleAccent, width: 2),
                borderRadius: BorderRadius.circular(20),
              ),
              splashColor: Colors.deepPurpleAccent,
              title: Text(activity.name),
              subtitle: Text(activity.tags.join(', ')),
              trailing: Text("Date: ${activity.createdOn.day}/${activity.createdOn.month}/${activity.createdOn.year}"), //display in form 28/1/2024
              onTap: () {
                //we should navigate to the activity screen using material route
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ActivityConsumer(
                      activity: activity,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(categoryProvider.notifier).addToActivityList(
                Activity(
                  countMap: {},
                  createdOn: DateTime.now(),
                  name: 'Study ${category.activityList.length + 1}',
                  tags: [],
                ),
              );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

//creating a consumer statefull widget for activity recieved from the category consumer in order to modify the Activity object in the list of activities in the category class
class ActivityConsumer extends ConsumerStatefulWidget {
  final Activity activity;

  const ActivityConsumer({super.key, required this.activity});

  @override
  _ActivityConsumerState createState() => _ActivityConsumerState();
}

class _ActivityConsumerState extends ConsumerState<ActivityConsumer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.activity.name),
      ),
      body: ListView.builder(
        itemCount: widget.activity.countMap.length,
        itemBuilder: (context, index) {
          final date = widget.activity.countMap.keys.elementAt(index);
          final count = widget.activity.countMap.values.elementAt(index);
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              elevation: 20,
              child: ListTile(
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.deepPurpleAccent, width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
                splashColor: Colors.deepPurpleAccent,
                title: Text("Date: ${date.day}/${date.month}/${date.year}"),
                subtitle: Text("Count: $count"),
                onTap: () => {
                  //navigate to the notes screen
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => NotesConsumer(
                        activity: widget.activity,
                      ),
                    ),
                  ),
                },
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            widget.activity.addToCountMap(DateTime.now(), widget.activity.countMap.length + 1);
          });

          //find the activity instance in the list of the activities in the category class and update it
          // ref.read(categoryProvider).activityList.firstWhere((element) => element.name == widget.activity.name).addToCountMap(DateTime.now(), widget.activity.countMap.length + 1);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

//consumer stateful widget for notes

class NotesConsumer extends ConsumerStatefulWidget {
  final Activity activity;

  const NotesConsumer({super.key, required this.activity});

  @override
  _NotesConsumerState createState() => _NotesConsumerState();
}

class _NotesConsumerState extends ConsumerState<NotesConsumer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.activity.name),
      ),
      body: ListView.builder(
        itemCount: widget.activity.notes.length,
        itemBuilder: (context, index) {
          final note = widget.activity.notes[index];
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              elevation: 20,
              child: ListTile(
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.deepPurpleAccent, width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
                splashColor: Colors.deepPurpleAccent,
                title: Text(note),
                onTap: () => {
                  //navigate to the notes screen
                },
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            widget.activity.notes.add('Note ${widget.activity.notes.length + 1}');
          });

          //find the activity instance in the list of the activities in the category class and update it
          // ref.read(categoryProvider).activityList.firstWhere((element) => element.name == widget.activity.name).addToCountMap(DateTime.now(), widget.activity.countMap.length + 1);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
