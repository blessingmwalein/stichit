import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:orders_repository/orders_repository.dart';
import 'package:stichit/app/const/colors.dart';
import 'package:stichit/ui_commons/buttons/copy_text_button.dart';
import 'package:stichit/ui_commons/buttons/icon_drop_down_button.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class OrdersDataSource extends DataGridSource {
  OrdersDataSource({
    required List<CustomerOrder> orderList,
    required this.onEdit,
    required this.onView,
    required this.onDelete,
  }) {
    _ordersList = orderList
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(columnName: 'id', value: e.id),
              DataGridCell<String>(columnName: 'userId', value: e.userId),
              DataGridCell<String>(columnName: 'rugId', value: e.rugId),
              DataGridCell<String>(columnName: 'rugSizeId', value: e.rugSizeId),
              DataGridCell<String>(columnName: 'imageUrl', value: e.imageUrl),
              DataGridCell<String>(columnName: 'createdAt', value: e.createdAt),
              DataGridCell<String>(
                  columnName: 'colorPalet',
                  value: e.colorPalet?.join(', ') ?? ''),
              DataGridCell<String>(columnName: 'notes', value: e.notes ?? ''),
              DataGridCell<String>(
                  columnName: 'status', value: e.status.toString()),
            ]))
        .toList();
  }

  final Function(CustomerOrder) onEdit;
  final Function(CustomerOrder) onView;
  final Function(CustomerOrder) onDelete;

  List<DataGridRow> _ordersList = [];

  @override
  List<DataGridRow> get rows => _ordersList;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final orderId = row.getCells()[0].value.toString();
    final userId = row.getCells()[1].value.toString();
    final rugId = row.getCells()[2].value.toString();
    final rugSizeId = row.getCells()[3].value.toString();
    final imageUrl = row.getCells()[4].value.toString();
    final createdAt = row.getCells()[5].value.toString();
    final colorPalet = row.getCells()[6].value.toString();
    final notes = row.getCells()[7].value.toString();
    final status = row.getCells()[8].value.toString();

    CustomerOrder selectedOrder = CustomerOrder(
      id: orderId,
      userId: userId,
      rugId: rugId,
      rugSizeId: rugSizeId,
      imageUrl: imageUrl,
      colorPalet: colorPalet.split(', '),
      createdAt: createdAt,
      status: OrderStatus.fromString(status),
      notes: notes,
      totalCost: 0,
    );

    return DataGridRowAdapter(cells: <Widget>[
      Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8.0),
        child: CopyTextButton(text: orderId),
      ),
      Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(8.0),
        child: Text(userId,
            style: const TextStyle(
                color: CustomColors.grey, fontWeight: FontWeight.normal)),
      ),
      Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(8.0),
        child: Text(rugId,
            style: const TextStyle(
                color: CustomColors.grey, fontWeight: FontWeight.normal)),
      ),
      Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(8.0),
        child: Text(rugSizeId,
            style: const TextStyle(
                color: CustomColors.grey, fontWeight: FontWeight.normal)),
      ),
      Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(8.0),
        child: Text(imageUrl,
            style: const TextStyle(
                color: CustomColors.grey, fontWeight: FontWeight.normal)),
      ),
      Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(8.0),
        child: Text(createdAt,
            style: const TextStyle(
                color: CustomColors.grey, fontWeight: FontWeight.normal)),
      ),
      Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(8.0),
        child: Text(colorPalet,
            style: const TextStyle(
                color: CustomColors.grey, fontWeight: FontWeight.normal)),
      ),
      Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(8.0),
        child: Text(notes,
            style: const TextStyle(
                color: CustomColors.grey, fontWeight: FontWeight.normal)),
      ),
      Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(8.0),
        child: Text(status,
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
                onView(selectedOrder);
                break;
              case 'Edit':
                onEdit(selectedOrder);
                break;
              case 'Delete':
                onDelete(selectedOrder);
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
