import 'package:flutter/material.dart';

class DataTableView extends StatelessWidget {
  const DataTableView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("data table view")),
      body: DataTable(
        columns: [
          DataColumn(label: Text("Tên")),
          DataColumn(label: Text("Tuổi")),
        ],
        rows: [
          DataRow(
            cells: [DataCell(Text('Nguyễn Văn A')), DataCell(Text('25'))],
          ),
          DataRow(
            cells: [DataCell(Text('Nguyễn Văn B')), DataCell(Text('25'))],
          ),
        ],
      ),
    );
  }
}
