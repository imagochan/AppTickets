import 'package:apptickets/modelos/modelo_categoria.dart';
import 'package:apptickets/pantallas/crear_o_actualizar_categorias/pantalla_crear_o_actualizar_categorias.dart';
import 'package:apptickets/pantallas/crear_o_actualizar_tickets/pantalla_crear_o_actualizar_ticket.dart';
import 'package:apptickets/pantallas/login/pantalla_registrar_usuario.dart';
import 'package:apptickets/pantallas/widget_home_button.dart';
import 'package:apptickets/pantallas/listar_categorias/pantalla_listar_categorias.dart';
import 'package:flutter/material.dart';
import 'package:apptickets/pantallas/listar_tickets/pantalla_listar_tickets.dart';

import '../modelos/modelo_ticket.dart';

//Pantalla de inicio que aloja los botones para crear, listar, actualizar y borrar tickets
//Utilizamos Navigator y Routes para mover al usuario entre pantallas

class PantallaInicio extends StatefulWidget {
  const PantallaInicio({super.key});

  @override
  State<PantallaInicio> createState() => _PantallaInicioState();
}

class _PantallaInicioState extends State<PantallaInicio> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("App para tickets en línea"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              HomeElevBtn(
                pageWidget: FormCrearEditarTicket(
                  esCrearOActualizar: true,
                  unTicket: Ticket.empty(),
                ),
                btnTitle: 'Crear Ticket',
              ),
              const HomeElevBtn(
                pageWidget: ListarTickets(),
                btnTitle: 'Listar Ticket',
              ),
              const HomeElevBtn(
                  pageWidget: PantallaListarCategorias(),
                  btnTitle: "Listar Categorias"),
              HomeElevBtn(
                  pageWidget: PantallaCrearOActualizarCategorias(
                      esCrearOActualizar: true,
                      unaCategoria: Categoria.empty()),
                  btnTitle: "Crear Categorias"),
              const HomeElevBtn(
                  pageWidget: PantallaRegistrarCliente(),
                  btnTitle: "Registrar usuario")
            ],
          ),
        ));
  }
}
