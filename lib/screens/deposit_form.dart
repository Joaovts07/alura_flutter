import 'package:bytebank/componentes/editor.dart';
import 'package:bytebank/models/saldo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const _tituloAppBar = 'Criando Deposito';

const _rotuloCampoValor = 'Valor';
const _dicaCampoValor = '0.00';

const _rotuloCampoNumeroConta = 'Número da conta';
const _dicaCampoNumeroConta = '0000';

const _textoBotaoConfirmar = 'Confirmar';

class DepositForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DepositFormState();
  }
}

class DepositFormState extends State<DepositForm> {

  final TextEditingController _controladorCampoValor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(_tituloAppBar),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Editor(
                dica: _dicaCampoNumeroConta,
                rotulo: _rotuloCampoNumeroConta,
              ),
              Editor(
                dica: _dicaCampoValor,
                controlador: _controladorCampoValor,
                rotulo: _rotuloCampoValor,
                icone: Icons.monetization_on,
              ),
              ElevatedButton(
                child: Text(_textoBotaoConfirmar),
                onPressed: () => _criaDeposit(context),
              ),
            ],
          ),
        ));
  }

  void _criaDeposit(BuildContext context) {
    final double value = double.tryParse(_controladorCampoValor.text);
    if (value != null) {
      Provider.of<Saldo>(context,listen: false ).add(value);
      Navigator.pop(context);
    }
  }
}
