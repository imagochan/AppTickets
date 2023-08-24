import 'package:flutter/material.dart';

class SubmitCategoryButton extends StatefulWidget {
  const SubmitCategoryButton({super.key});

  @override
  State<SubmitCategoryButton> createState() => _SubmitCategoryButtonState();
}

class _SubmitCategoryButtonState extends State<SubmitCategoryButton> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () {  },
          child: const Text("Crear categoria"),),
      )
    );
  }
}