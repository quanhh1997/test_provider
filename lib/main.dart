import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_abc/manager.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Manager(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late ChangeNotifierProvider changeNotifierProvider;

  Future<void> _showFilterList() {
    return showModalBottomSheet(
        context: context,
        isScrollControlled: false,
        enableDrag: false,
        isDismissible: true,
        backgroundColor: Colors.transparent,
        barrierColor: Colors.transparent,
        builder: (context) {
          return const Beauty();
        });
  }

  @override
  void initState() {
    Provider.of<Manager>(context, listen: false).genarateData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<Manager>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: List.generate(
              provider.listModel.length,
              (index) => Text(
                  "${provider.listModel[index].title} : ${provider.listModel[index].value}")),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showFilterList,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class Beauty extends StatelessWidget {
  const Beauty({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<Manager>(context);
    return SizedBox(
      height: 150,
      child: Column(
        children: [
          Slider(
              divisions: 50,
              value: provider
                  .listModel[Provider.of<Manager>(context).selected].value,
              onChanged: (value) {
                Provider.of<Manager>(context, listen: false).changeValue(value);
              }),
          Expanded(
            child: ListView.separated(
              itemCount: provider.listModel.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, index) => GestureDetector(
                onTap: () {
                  Provider.of<Manager>(context, listen: false)
                      .selectItem(index);
                },
                child: Opacity(
                  opacity: index == provider.selected ? 1 : 0.7,
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey,
                    ),
                    padding: const EdgeInsets.all(20.0),
                    child: Text(provider.listModel[index].title),
                  ),
                ),
              ),
              separatorBuilder: (_, index) => const SizedBox(
                width: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
