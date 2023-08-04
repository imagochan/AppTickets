import 'package:flutter/material.dart';
import 'package:node_tutorials/create.dart';
import 'package:node_tutorials/fetch.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CreateData()));
                },
                child: Text("CREATE")),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => const FetchData())));
                },
                child: Text("READ")),
            ElevatedButton(onPressed: () {}, child: Text("UPDATE")),
            ElevatedButton(onPressed: () {}, child: Text("DELETE")),
          ],
        ));
  }
}
