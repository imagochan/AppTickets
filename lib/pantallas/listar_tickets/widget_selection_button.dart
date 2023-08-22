import 'package:apptickets/modelos/modelo_bundle_filtro.dart';
import 'package:flutter/material.dart';

import 'pantalla_selection_screen.dart';

class SelectionButton extends StatefulWidget {
  const SelectionButton({super.key, required this.unBundleFiltros});

  late final BundleFiltros? unBundleFiltros;

  @override
  State<SelectionButton> createState() => _SelectionButtonState();
}

class _SelectionButtonState extends State<SelectionButton> {
  late var miBundleFiltros = widget.unBundleFiltros;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        _navigateAndDisplaySelection(context, miBundleFiltros);
      },
      child: const Text('Escoger filtros'),
    );
  }

  // A method that launches the SelectionScreen and awaits the result from
  // Navigator.pop.
  Future<void> _navigateAndDisplaySelection(
      BuildContext context, BundleFiltros? unBundleFiltros) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SelectionScreen()),
    );

    // When a BuildContext is used from a StatefulWidget, the mounted property
    // must be checked after an asynchronous gap.
    if (!mounted) return;

    //pasamos el bundle data
    unBundleFiltros = result;

    // After the Selection Screen returns a result, hide any previous snackbars
    // and show the new result.
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text('$result')));
  }
}
