// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onfly_flutter/presentation/presenters/getx_expense_presenter.dart';

import '../../../data/models/hive_model/expense_model_hive.dart';

class ExpensePage extends StatelessWidget {
  final ExpenseModelHive? initialExpense;
  final bool isEditing;

  const ExpensePage({super.key, this.initialExpense})
      : isEditing = initialExpense != null;

  @override
  Widget build(BuildContext context) {
    final presenter = Get.put(GetXExpensePresenter());
    final TextEditingController descriptionController =
        TextEditingController(text: initialExpense?.description ?? '');
    final TextEditingController expenseDateController =
        TextEditingController(text: initialExpense?.expenseDate ?? '');
    final TextEditingController amountController =
        TextEditingController(text: initialExpense?.amount.toString() ?? '');
    final TextEditingController latitudeController =
        TextEditingController(text: initialExpense?.latitude ?? '');
    final TextEditingController longitudeController =
        TextEditingController(text: initialExpense?.longitude ?? '');

    var random = Random();
    int randomInt = random.nextInt(100);
    presenter.navigateToStream.listen((page) {
      if (page?.isNotEmpty == true) {
        Get.offAllNamed(page!, arguments: presenter.navigationHomePage());
      }
    });
    bool _validateFields() {
      if (descriptionController.text.isEmpty ||
          expenseDateController.text.isEmpty ||
          amountController.text.isEmpty ||
          latitudeController.text.isEmpty ||
          longitudeController.text.isEmpty) {
        Get.snackbar(
          'Campos obrigatórios',
          'Preencha todos os campos obrigatórios',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return false;
      }
      return true;
    }

    void _saveExpense() {
      if (!_validateFields()) {
        return;
      }
      if (isEditing) {
        final expense = ExpenseModelHive(
            description: descriptionController.text,
            expenseDate: expenseDateController.text,
            amount: double.tryParse(amountController.text) ?? 0.0,
            latitude: latitudeController.text,
            longitude: longitudeController.text,
            indefier: initialExpense!.indefier,
            isSync: false);
        presenter.updateExpense(expense.indefier, expense);
      } else {
        final expense = ExpenseModelHive(
            description: descriptionController.text,
            expenseDate: expenseDateController.text,
            amount: double.tryParse(amountController.text) ?? 0.0,
            latitude: latitudeController.text,
            longitude: longitudeController.text,
            indefier: randomInt,
            isSync: false);
        presenter.addExpense(expense);
      }

      presenter.navigationHomePage();
    }

    Future<void> _deleteExpense(BuildContext context) async {
      if (isEditing) {
        final confirmed = await _showDeleteConfirmationDialog(context);
        if (confirmed) {
          final index = presenter.expenses.indexOf(initialExpense!);
          if (index != -1) {
            await presenter.deleteExpense(initialExpense!);
            presenter.navigationHomePage();
          }
        }
      } else {
        Navigator.of(context).pop();
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Editar Despesa' : 'Adicionar Despesa'),
        actions: [
          if (isEditing)
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => _deleteExpense(context),
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildTextField(descriptionController, 'Descrição'),
            const SizedBox(height: 8),
            _buildTextField(expenseDateController, 'Data da Despesa'),
            const SizedBox(height: 8),
            _buildTextField(amountController, 'Valor',
                keyboardType: TextInputType.number),
            const SizedBox(height: 8),
            _buildTextField(latitudeController, 'Latitude'),
            const SizedBox(height: 8),
            _buildTextField(longitudeController, 'Longitude'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _saveExpense,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                textStyle: const TextStyle(color: Colors.white),
              ),
              child: Text(isEditing ? 'Atualizar Despesa' : 'Salvar Despesa'),
            )
          ],
        ),
      ),
    );
  }

  _showDeleteConfirmationDialog(
    BuildContext context,
  ) async {
    return await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmar exclusão'),
          content: const Text('Você deseja mesmo excluir esta despesa?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Não'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: const Text('Sim'),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildTextField(TextEditingController controller, String labelText,
      {TextInputType keyboardType = TextInputType.text}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        border: const OutlineInputBorder(),
      ),
      keyboardType: keyboardType,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Campo obrigatório';
        }
        return null;
      },
    );
  }
}
