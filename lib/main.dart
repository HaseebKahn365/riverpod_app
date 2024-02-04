import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/buisness_logic/model.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

//creating an instance of the parent class

final parentProvider = ChangeNotifierProvider((ref) => Parent());

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

//creating consumer widget for the parent provider

class CategoryConsumer extends ConsumerWidget {
  const CategoryConsumer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final parent = ref.watch(parentProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riverpod Demo'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Text(
            'this is all about parent: ${parent.categoryList.length}',
            style: Theme.of(context).textTheme.headline6,
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: parent.categoryList.length,
              itemBuilder: (context, index) {
                return CategoryConsumerWidget(
                  category: parent.categoryList[index],
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(parentProvider.notifier).addToCategoryList(
                Category(
                  isCountBased: true,
                  name: 'Category Arooba: ${parent.categoryList.length + 1}',
                  ActivityConnectUID: 'Activity ${parent.categoryList.length + 1}',
                  createdOn: DateTime.now(),
                ),
              );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

//creating consumer widget for the category provider

class CategoryConsumerWidget extends ConsumerWidget {
  final Category category;

  const CategoryConsumerWidget({super.key, required this.category});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Category Arroba: ${category.activityList.length}',
            style: Theme.of(context).textTheme.headline6,
          ),
          const SizedBox(height: 20),
          ListView.builder(
            shrinkWrap: true,
            itemCount: category.activityList.length,
            itemBuilder: (context, index) {
              return ActivityConsumerWidget(
                activity: category.activityList[index],
              );
            },
          ),
          const SizedBox(height: 20),
          FloatingActionButton(
            onPressed: () {
              ref.read(parentProvider.notifier).addToCategoryList(
                    Category(
                      isCountBased: true,
                      name: 'Category ${category.activityList.length + 1}',
                      ActivityConnectUID: 'Activity ${category.activityList.length + 1}',
                      createdOn: DateTime.now(),
                    ),
                  );
            },
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}

//creating consumer widget for the activity provider

class ActivityConsumerWidget extends ConsumerWidget {
  final Activity activity;

  const ActivityConsumerWidget({super.key, required this.activity});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Activity: ${activity.name}',
            style: Theme.of(context).textTheme.headline6,
          ),
          const SizedBox(height: 20),
          Text(
            'Tags: ${activity.tags.length}',
            style: Theme.of(context).textTheme.subtitle1,
          ),
          const SizedBox(height: 20),
          Text(
            'Count Map: ${activity.countMap.length}',
            style: Theme.of(context).textTheme.subtitle1,
          ),
          const SizedBox(height: 20),
          FloatingActionButton(
            onPressed: () {
              ref.read(parentProvider.notifier).addToCategoryList(
                    Category(
                      isCountBased: true,
                      name: 'Category ${activity.countMap.length + 1}',
                      ActivityConnectUID: 'Activity ${activity.countMap.length + 1}',
                      createdOn: DateTime.now(),
                    ),
                  );
            },
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
