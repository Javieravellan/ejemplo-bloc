import 'dart:async';
import 'empleado.dart';

class EmpleadoBloc {
  List<Empleado> _empleadoList = [
    new Empleado(1, "Javier Chiquito", 702.0),
    new Empleado(2, "Ernesto Avellán", 1000.0),
    new Empleado(3, "Yadira Villamar Gómez", 1500.0),
    new Empleado(4, "Ashley Carola Cárdenas", 1200.0),
    new Empleado(5, "Tammy Cárdenas", 950.0)
  ];

  // este stream espera una lista de datos de tipo Empleado para cargarla
  final _empleadoListStreamController = new StreamController<List<Empleado>>();

  // Este stream espera un objeto Empleado para incrementar el salario
  final _empleadoSalarioIncrementStreamController = new StreamController<Empleado>();

  // Este stream espera también un objeto Empleado para decrementar el salario
  final _empleadoSalarioDecrementStreamController = new StreamController<Empleado>();

  //Getters: streams
  // Este getter menejará la lista de empleados y retornará un stream
  // del objeto _empleadoListStreamController.
  Stream<List<Empleado>> get empleadoListStream => this._empleadoListStreamController.stream;

  // Este stream es un sink del objeto _empleadoListStreamController perimite la entrada de datos
  StreamSink<List<Empleado>> get empleadoListSink => _empleadoListStreamController.sink;

  // Estos «Sink» son de tipo _empleadoSalarioIncrementStreamController y
  // _empleadoSalarioDecrementStreamController respectivamente, para permitir el incremento
  // y decremento del salario del empleado.
  StreamSink<Empleado> get empeladoSalarioIncrement => _empleadoSalarioIncrementStreamController.sink;
  StreamSink<Empleado> get empleadoSalarioDecrement => _empleadoSalarioDecrementStreamController.sink;

  // Constructor
  EmpleadoBloc() {
    // Este Stream añade los datos que son especificamente una lista de tipo Empleado
    _empleadoListStreamController.add(_empleadoList);

    // Estos StreamController, que reciben un objeto Empleado,
    // escuchan los cambios que están ocurriendo.
    // y según el caso solicitado, se incrementará o decrementará en un 20% el salario del empleado.
    _empleadoSalarioIncrementStreamController.stream.listen(_incrementSalario);
    _empleadoSalarioDecrementStreamController.stream.listen(_decrementSalario);
  }

  // funciones principales (Core Functions)
  _incrementSalario(Empleado empleado) {
    double salarioActual = empleado.salario;
    double salarioNuevo = salarioActual * 20/100;
    this._empleadoList[empleado.id - 1].salario = salarioActual + salarioNuevo;
    // agregamos los datos actualizados devuelta a l Sink(entrada)
    empleadoListSink.add(this._empleadoList);
  }

  _decrementSalario(Empleado empleado) {
    double salarioActual = empleado.salario;
    double salarioNuevo = salarioActual * 20/100;
    this._empleadoList[empleado.id - 1].salario = salarioActual - salarioNuevo;
    // agregamos los datos actualizados devuelta a l Sink(entrada)
    empleadoListSink.add(this._empleadoList);
  }

  void dispose() {
    _empleadoListStreamController.close();
    _empleadoSalarioIncrementStreamController.close();
    _empleadoSalarioDecrementStreamController.close();
  }
}