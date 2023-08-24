import 'package:apptickets/pantallas/crear_tickets/pantalla_crear_ticket.dart';
import 'package:flutter/material.dart';

import '../../modelos/modelo_ticket.dart';

//Al pulsar el botón de editar
//enviamos el índice del ticket a actualizar y
//redirigimos al usuario a la pantalla de edición de tickets

class UpdateButtonWidget extends StatefulWidget {
  const UpdateButtonWidget({super.key, required this.miTicket, required this.retorno});

  final Ticket miTicket;
  final Function() retorno;

  @override
  State<UpdateButtonWidget> createState() => _UpdateButtonWidgetState();
}

class _UpdateButtonWidgetState extends State<UpdateButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        _navigateAndDisplaySelection(context, widget.miTicket,widget.retorno);
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) =>
        //     FormCrearEditarTicket(
        //       unTicket: widget.miTicket,
        //       esCrearOActualizar: false,
        //     ),
        //   )
        // );
      },
      icon: const Icon(Icons.edit),
    );
  }

    // A method that launches the SelectionScreen and awaits the result from
  // Navigator.pop.
  Future<void> _navigateAndDisplaySelection(
      BuildContext context, Ticket miTicket, Function() retorno) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.

    //var result = await Navigator.push(
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FormCrearEditarTicket(
              unTicket: miTicket,
              esCrearOActualizar: false,
            ),
      ),
    );
    
    // result ??= BundleFiltros.empty();

    // When a BuildContext is used from a StatefulWidget, the mounted property
    // must be checked after an asynchronous gap.
    if (!mounted) return;// si no existe la otra pagina, la funcion se detiene

    //pasamos el bundle data
    
    // unBundleFiltros = result;

    //tirando el bundle hacia la lista de tickets
    
    // widget.retorno(result);
    widget.retorno();

    // After the Selection Screen returns a result, hide any previous snackbars
    // and show the new result.

    // ScaffoldMessenger.of(context)
    //   ..removeCurrentSnackBar()
    //   ..showSnackBar(SnackBar(content: Text('$result')));
  }
}