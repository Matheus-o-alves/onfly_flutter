import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:onfly_flutter/ui/pages/home/components/card_expense_widget.dart';
import 'package:onfly_flutter/ui/pages/expense/expense_page.dart';

import '../../../presentation/presenters/getx_home_page_presenter.dart';

class HomePage extends StatelessWidget {
  final GetXHomePagePresenter controller = Get.put(GetXHomePagePresenter());

  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF267FFA),
        centerTitle: true,
        title: const Column(
          children: [
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.card_travel,
                  color: Colors.white,
                  size: 40,
                ),
                SizedBox(width: 10),
                Text(
                  'ONFLY',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                onChanged: (value) {
                  controller.searchQuery.value = value;
                  controller.syncExpenses();
                },
                decoration: const InputDecoration(
                  labelText: 'Pesquisar Despesa',
                  prefixIcon: Icon(
                    Icons.search,
                    color: Color(0xFF267FFA),
                  ),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Expanded(
              child: Obx(() {
                if (!controller.isSynced.value) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (controller.isLoading.value) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (controller.hasError.value) {
                  return Center(
                    child: Text(
                      controller.errorMessage.value,
                      style: const TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                } else {
                  final expenses = controller.expenses;
                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.2,
                    ),
                    itemCount: expenses.length + 1,
                    itemBuilder: (context, index) {
                      if (index == expenses.length) {
                        // Último item, adicione o botão de adicionar
                        return GestureDetector(
                          onTap: () {
                            // Navegue para a tela ShopPage
                            Get.to(() => const ExpensePage());
                          },
                          child: _buildAddExpenseCard(),
                        );
                      } else {
                        // Item da lista
                        return GestureDetector(
                          onTap: () {
                            controller
                                .navigateToExpenseDetails(expenses[index]);
                          },
                          child: CardExpenseWidget(
                            controller: controller,
                            index: index,
                          ),
                        );
                      }
                    },
                  );
                }
              }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await controller.syncExpensesToAPI();
          Get.snackbar(
            'Enviando as despesas',
            '',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.blue,
            colorText: Colors.white,
          );

          Future.delayed(Duration(microseconds: 100));
          await controller.syncGetExpensesToAPI();
          Get.snackbar(
            'Recebendo as despesas',
            '',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.blue,
            colorText: Colors.white,
          );
        },
        backgroundColor: const Color(0xFF267FFA),
        child: const Icon(Icons.sync, color: Colors.white),
      ),
    );
  }

  Widget _buildAddExpenseCard() {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: const Color(0xFF267FFA),
          width: 2.0,
        ),
      ),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.add,
            color: Color(0xFF267FFA),
            size: 32,
          ),
          SizedBox(height: 8),
          Text(
            'Adicionar',
            style: TextStyle(
              color: Color(0xFF267FFA),
            ),
          ),
        ],
      ),
    );
  }
}
