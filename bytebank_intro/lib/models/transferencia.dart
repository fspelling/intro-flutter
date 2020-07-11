class Tranferencia {
  final double valor;
  final int numero;

  Tranferencia(this.valor, this.numero);

  @override
  String toString() {
    return 'Tranferencia(valor: ${this.valor}, numeroConta: ${this.numero})';
  }
}