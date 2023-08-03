import 'package:flutter/material.dart';

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
            ElevatedButton(onPressed: () {}, child: Text("CREATE")),
            ElevatedButton(onPressed: () {}, child: Text("READ")),
            ElevatedButton(onPressed: () {}, child: Text("UPDATE")),
            ElevatedButton(onPressed: () {}, child: Text("DELETE")),
          ],
        ));
  }
}
