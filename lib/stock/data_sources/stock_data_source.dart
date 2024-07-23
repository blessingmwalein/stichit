import 'package:flutter/material.dart';
import 'package:stichit/app/const/colors.dart';
import 'package:stichit/stock/cubit/stock_cubit.dart';
import 'package:stichit/ui_commons/buttons/copy_text_button.dart';
import 'package:stichit/ui_commons/buttons/icon_drop_down_button.dart';
import 'package:stock_repository/stock_repository.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class StockDataSource extends DataGridSource {
  StockDataSource({
    required List<Stock> stockList,
    required this.onEdit,
  }) {
    _stockList = stockList
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(columnName: 'id', value: e.id),
              DataGridCell<String>(columnName: 'name', value: e.name),
              DataGridCell<String>(columnName: 'category', value: e.category),
              DataGridCell<String>(
                  columnName: 'quantity', value: e.quantity.toString()),
              DataGridCell<String>(
                  columnName: 'measureType', value: e.measureType),
              DataGridCell<String>(
                  columnName: 'measureValue', value: e.measureValue.toString()),
              DataGridCell<String>(columnName: 'color', value: e.color),
              DataGridCell<double>(columnName: 'price', value: e.price),
              DataGridCell<String>(
                  columnName: 'description', value: e.description),
            ]))
        .toList();
  }

  final Function(Stock) onEdit;

  List<DataGridRow> _stockList = [];

  @override
  List<DataGridRow> get rows => _stockList;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    //get stock from list
    final stockId = row.getCells()[0].value.toString();
    final stockName = row.getCells()[1].value.toString();
    final stockCategory = row.getCells()[2].value.toString();
    final stockQuantity = row.getCells()[3].value.toString();
    final stockMeasureValue = row.getCells()[5].value.toString();
    final stockMeasureType = row.getCells()[4].value.toString();
    final stockColor = row.getCells()[6].value.toString();
    final stockPrice = row.getCells()[7].value.toString();
    final stockDescription = row.getCells()[8].value.toString();

    // Assuming you have a way to get the selected stock
    Stock selectedStock = Stock(
      id: stockId,
      name: stockName,
      category: stockCategory,
      quantity: int.parse(stockQuantity),
      measureValue: double.parse(stockMeasureValue),
      measureType: stockMeasureType,
      color: stockColor,
      price: double.parse(stockPrice),
      description: stockDescription,
    );

    return DataGridRowAdapter(cells: <Widget>[
      Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8.0),
        child: CopyTextButton(text: stockId),
      ),
      Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(8.0),
        child: Text(stockName,
            style: const TextStyle(
                color: CustomColors.grey, fontWeight: FontWeight.normal)),
      ),
      Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(8.0),
        child: Text(stockCategory,
            style: const TextStyle(
                color: CustomColors.grey, fontWeight: FontWeight.normal)),
      ),
      Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(8.0),
        child: Text(
          stockQuantity,
          style: const TextStyle(
              color: CustomColors.grey, fontWeight: FontWeight.normal),
        ),
      ),
      Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(8.0),
        child: Text(
            style: const TextStyle(
                color: CustomColors.grey, fontWeight: FontWeight.normal),
            '$stockMeasureValue $stockMeasureType'),
      ),
      Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(8.0),
        child: Text(
          stockColor,
          style: const TextStyle(
              color: CustomColors.grey, fontWeight: FontWeight.normal),
        ),
      ),
      Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(8.0),
        child: Text(
          '\$${stockPrice}',
          style: const TextStyle(
              color: CustomColors.grey, fontWeight: FontWeight.normal),
        ),
      ),
      Container(
        alignment: Alignment.centerLeft,
        child: IconDropDownButton(
          items: const ['View', 'Edit', 'Delete'],
          onChanged: (String? newValue) {
            // Handle the selected value here
            print('Selected: $newValue');
            switch (newValue) {
              case 'View':
                print('View');
                break;
              case 'Edit':
                // Call the editStock method with the selected stock
                onEdit(selectedStock);
                break;
              case 'Delete':
                print('Delete');
                break;
            }
          },
          iconSize: 30.0,
          iconColor: CustomColors.white,
          backgroundColor: CustomColors.lightGrey,
        ),
      ),
    ]);
  }
}
