import 'package:flutter/material.dart';
import 'empleado.dart';
import 'empleadoBloc.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {

  final EmpleadoBloc _empleadoBloc = new EmpleadoBloc();

  @override
  void dispose() {
    _empleadoBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: new AppBar(
      title: new Text('App Empleado'),
    ),
    body: new Container(
      child: new StreamBuilder<List<Empleado>>(
        stream: _empleadoBloc.empleadoListStream,
        builder: (BuildContext context, AsyncSnapshot<List<Empleado>> snapshot) {
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) => Card(
              elevation: 10.0,
              margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
              child: new Row(
                children: [
                  Text('${snapshot.data[index].id}.', style: Theme.of(context).textTheme.headline6),
                  SizedBox(width: 20.0),
                  Column(
                    children: [
                      Text('${snapshot.data[index].nombre}', style: Theme.of(context).textTheme.subtitle1),
                      SizedBox(height: 16.0),
                      Text('${snapshot.data[index].salario}', style: Theme.of(context).textTheme.bodyText1)
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    ),
  );
}