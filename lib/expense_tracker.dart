import 'package:flutter/material.dart';

class ExpenseTracker extends StatefulWidget {
  @override
  _ExpenseTrackerState createState() => _ExpenseTrackerState();
}

class _ExpenseTrackerState extends State<ExpenseTracker> {
  final incomeController = TextEditingController();
  final expenditureController = TextEditingController();
  List<ExpenseEntry> entries = [];

  double totalIncome = 0.0;
  double totalExpenditure = 0.0;

  void _submitEntry() {
    double income = double.tryParse(incomeController.text) ?? 0.0;
    double expenditure = double.tryParse(expenditureController.text) ?? 0.0;

    setState(() {
      totalIncome += income;
      totalExpenditure += expenditure;
      entries.add(ExpenseEntry(
        income: income,
        expenditure: expenditure,
        timestamp: DateTime.now(),
      ));
    });

    incomeController.clear();
    expenditureController.clear();
  }

  void _deleteEntry(int index) {
    setState(() {
      totalIncome -= entries[index].income;
      totalExpenditure -= entries[index].expenditure;
      entries.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker'),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset('assets/images/logo.png'), // Add your logo asset here
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: incomeController,
              decoration: const InputDecoration(
                labelText: 'Income',
                border: OutlineInputBorder(),
              ),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: expenditureController,
              decoration: const InputDecoration(
                labelText: 'Expenditure',
                border: OutlineInputBorder(),
              ),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitEntry,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green, // Change button color to green
              ),
              child: const Text('Submit',style: TextStyle(color: Colors.white),),
            ),

            const SizedBox(height: 20),
            Text(
              'Total Income: $totalIncome',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'Total Expenditure: $totalExpenditure',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            const Text(
              'Entries:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: entries.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 3,
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: ListTile(
                      title: Text(
                        'Income: ${entries[index].income}, Expenditure: ${entries[index].expenditure}',
                      ),
                      subtitle: Text('Timestamp: ${entries[index].timestamp}'),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => _deleteEntry(index),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ExpenseEntry {
  final double income;
  final double expenditure;
  final DateTime timestamp;

  ExpenseEntry({required this.income, required this.expenditure, required this.timestamp});
}
