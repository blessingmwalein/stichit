import 'package:flutter/material.dart';
import 'package:rugs_repository/rugs_repository.dart';
import 'package:stichit/app/const/colors.dart';
import 'package:stichit/stock/cubit/stock_cubit.dart';
import 'package:stichit/ui_commons/buttons/copy_text_button.dart';
import 'package:stichit/ui_commons/buttons/icon_drop_down_button.dart';
import 'package:stock_repository/stock_repository.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class RugsDataSource extends DataGridSource {
  RugsDataSource({
    required List<Rug> rugList,
    required this.onEdit,
  }) {
    _rugsList = rugList
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(columnName: 'id', value: e.id),
              DataGridCell<String>(columnName: 'name', value: e.name),
              DataGridCell<String>(
                  columnName: 'type', value: e.type.toString()),
              DataGridCell<String>(
                  columnName: 'shape', value: e.shape.toString()),
              DataGridCell<double>(
                  columnName: 'pricePerUnit', value: e.pricePerUnit),
              DataGridCell<String>(
                  columnName: 'measureType', value: e.measureType),
              DataGridCell<String>(
                  columnName: 'measureValue', value: e.measureValue.toString()),
              DataGridCell<String>(
                  columnName: 'description', value: e.description.toString()),
            ]))
        .toList();
  }

  final Function(Rug) onEdit;

  List<DataGridRow> _rugsList = [];

  @override
  List<DataGridRow> get rows => _rugsList;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    //get stock from list
    final rugId = row.getCells()[0].value.toString();
    final rugName = row.getCells()[1].value.toString();

    final rugType = row.getCells()[2].value.toString();
    final rugShape = row.getCells()[3].value.toString();
    final pricePerUnit = row.getCells()[4].value.toString();
    final rugMeasureType = row.getCells()[5].value.toString();

    final rugMeasureValue = row.getCells()[6].value.toString();

    final rugDescription = row.getCells()[7].value.toString();

    // Assuming you have a way to get the selected stock
    Rug selectedStock = Rug(
      id: rugId,
      name: rugName,
      type: RugType.fromString(rugType),
      shape: rugShape,
      measureValue: double.parse(rugMeasureValue),
      measureType: rugMeasureType,
      description: rugDescription,
      pricePerUnit: double.parse(pricePerUnit),
    );

    return DataGridRowAdapter(cells: <Widget>[
      Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8.0),
        child: CopyTextButton(text: rugId),
      ),
      Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(8.0),
        child: Text(rugName,
            style: const TextStyle(
                color: CustomColors.grey, fontWeight: FontWeight.normal)),
      ),
      Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(8.0),
        child: Text(rugType,
            style: const TextStyle(
                color: CustomColors.grey, fontWeight: FontWeight.normal)),
      ),
      Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(8.0),
        child: Text(
          rugShape,
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
            '$rugMeasureValue $rugMeasureType'),
      ),
      Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(8.0),
        child: Text(
          '\$$pricePerUnit',
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
