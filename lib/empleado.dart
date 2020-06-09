class Empleado {
  int _id;
  String _nombre;
  double _salario;

  Empleado(this._id, this._nombre, this._salario);

  int get id => this._id;

  set id(int value) {
    _id = value;
  }                       

  String get nombre => this._nombre;

  set nombre(String value) {
    _nombre = value;
  }

  double get salario => this._salario;

  set salario(double value) {
    _salario = value;
  }
}