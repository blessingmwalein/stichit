import 'package:flutter/material.dart';
import 'package:rugs_repository/rugs_repository.dart';
import 'package:stichit/app/const/colors.dart';
import 'package:stichit/ui_commons/buttons/copy_text_button.dart';
import 'package:stichit/ui_commons/buttons/icon_drop_down_button.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class RugsDataSource extends DataGridSource {
  RugsDataSource({
    required List<Rug> rugList,
    required this.onEdit,
    required this.onView,
    required this.onDelete,
  }) {
    _rugsList = rugList
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(columnName: 'id', value: e.id),
              DataGridCell<String>(columnName: 'name', value: e.name),
              DataGridCell<String>(
                  columnName: 'price', value: e.approxPricePerUnit.toString()),
              DataGridCell<String>(
                  columnName: 'description', value: e.description.toString()),
            ]))
        .toList();
  }

  final Function(Rug) onEdit;
  final Function(Rug) onView;
  final Function(Rug) onDelete;

  List<DataGridRow> _rugsList = [];

  @override
  List<DataGridRow> get rows => _rugsList;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    //get stock from list
    final rugId = row.getCells()[0].value.toString();
    final rugName = row.getCells()[1].value.toString();

    final pricePerUnit = row.getCells()[2].value.toString();

    final rugDescription = row.getCells()[3].value.toString();

    // Assuming you have a way to get the selected stock
    Rug selectedStock = Rug(
      id: rugId,
      name: rugName,
      approxPricePerUnit: double.parse(pricePerUnit),
      description: rugDescription,
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
        child: Text(
          '\$$pricePerUnit',
          style: const TextStyle(
              color: CustomColors.grey, fontWeight: FontWeight.normal),
        ),
      ),
      Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(8.0),
        child: Text(rugDescription,
            style: const TextStyle(
                color: CustomColors.grey, fontWeight: FontWeight.normal)),
      ),
      Container(
        alignment: Alignment.centerLeft,
        child: IconDropDownButton(
          items: const ['View', 'Edit', 'Delete'],
          onChanged: (String? newValue) {
            switch (newValue) {
              case 'View':
                onView(selectedStock);
                break;
              case 'Edit':
                // Call the editStock method with the selected stock
                onEdit(selectedStock);
                break;
              case 'Delete':
                onDelete(selectedStock);
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
