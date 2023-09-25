import 'package:flutter/material.dart';
import 'package:onfly_flutter/presentation/presenters/getx_home_page_presenter.dart';

class CardExpenseWidget extends StatelessWidget {
  const CardExpenseWidget({
    Key? key,
    required this.controller,
    required this.index,
  }) : super(key: key);

  final GetXHomePagePresenter controller;
  final int index;

  @override
  Widget build(BuildContext context) {
    final expense = controller.expenses[index];

    return InkWell(
      onTap: () {
        controller.navigateToExpenseDetails(controller.expenses[index]);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.airplane_ticket,
                    color: Color(0xFF267FFA),
                    size: 40,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    expense.description,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF267FFA),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '\$${expense.amount.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color(0xFF267FFA),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              Icon(
                Icons.sync,
                color: expense.isSync ? Colors.green : Colors.red,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
