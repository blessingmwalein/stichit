import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:rugs_repository/rugs_repository.dart';
import 'package:stichit/ui_commons/alerts/status/status_pill.dart';
import 'package:stichit/ui_commons/avatars/initial_avatar.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:stichit/app/const/colors.dart';
import 'package:stichit/ui_commons/buttons/copy_text_button.dart';
import 'package:stichit/ui_commons/buttons/icon_drop_down_button.dart';
import 'package:orders_repository/orders_repository.dart';

class OrdersDataSource extends DataGridSource {
  OrdersDataSource({
    required List<CustomerOrder> orderList,
    required this.onEdit,
    required this.onView,
    required this.onDelete,
  }) {
    _ordersList = orderList
        .map<DataGridRow>((CustomerOrder e) => DataGridRow(cells: [
              DataGridCell<String>(columnName: 'orderId', value: e.id),
              DataGridCell<String>(
                  columnName: 'userName', value: e.user?.fullName),
              DataGridCell<String>(columnName: 'rugName', value: e.rug?.name),
              DataGridCell<String>(
                  columnName: 'rugSize',
                  value: '${e.rugSize?.length}cm x ${e.rugSize?.width}cm'),
              DataGridCell<String>(columnName: 'orderDate', value: e.createdAt),
              DataGridCell<String>(
                  columnName: 'deposit', value: e.deposit.toStringAsFixed(2)),
              DataGridCell<String>(
                  columnName: 'total', value: e.totalCost.toStringAsFixed(2)),
              DataGridCell<String>(columnName: 'status', value: e.status.name),
              DataGridCell<UserModel>(columnName: 'user', value: e.user),
              DataGridCell<Rug>(columnName: 'rug', value: e.rug),
              DataGridCell<RugSizes>(columnName: 'size', value: e.rugSize),
              DataGridCell<String>(columnName: 'imageUrl', value: e.imageUrl),
              DataGridCell<int>(
                  columnName: 'orderNumber', value: e.orderNumber ?? 0),
              DataGridCell<String>(columnName: 'notes', value: e.notes),
              DataGridCell<String>(
                  columnName: 'estimatedDeliveryDate',
                  value: e.estimatedDeliveryDate),
              DataGridCell<List<String>>(
                  columnName: 'colorPalet', value: e.colorPalet),
              DataGridCell<OrderImage>(
                  columnName: 'orderImage', value: e.orderImage),
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
    // Retrieve data from the row cells
    final orderId = row.getCells()[0].value.toString();
    final userName = row.getCells()[1].value.toString();
    final rugName = row.getCells()[2].value.toString();
    final rugSize = row.getCells()[3].value.toString();
    final orderDate = row.getCells()[4].value.toString();
    final deposit = row.getCells()[5].value.toString();
    final total = row.getCells()[6].value.toString();
    final status = row.getCells()[7].value.toString();
    final user = row.getCells()[8].value;
    final rug = row.getCells()[9].value;
    final size = row.getCells()[10].value;
    final imageUrl = row.getCells()[11].value;
    final orderNumber = row.getCells()[12].value;
    final notes = row.getCells()[13].value;
    final estimatedDeliveryDate = row.getCells()[14].value;
    final colorPalet = row.getCells()[15].value;
    final orderImage = row.getCells()[16].value;

    // Create a selected CustomerOrder object
    final selectedOrder = CustomerOrder(
        id: orderId,
        userId: user.id,
        user: user,
        rug: rug,
        rugSize: size,
        createdAt: orderDate,
        deposit: double.parse(deposit),
        totalCost: double.parse(total),
        rugId: rug.id,
        rugSizeId: size.id,
        imageUrl: imageUrl,
        status: OrderStatus.fromString(status),
        notes: notes,
        estimatedDeliveryDate: estimatedDeliveryDate,
        colorPalet: colorPalet,
        orderImage: orderImage,
        orderNumber: orderNumber);

    return DataGridRowAdapter(cells: <Widget>[
      Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8.0),
        child: CopyTextButton(text: orderNumber.toString()),
      ),
      Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            InitialsAvatar(
              text: userName,
              height: 30,
              width: 30,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                userName,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    color: CustomColors.grey, fontWeight: FontWeight.normal),
              ),
            ),
          ],
        ),
      ),
      Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(8.0),
        child: Text(
          rugName,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
              color: CustomColors.grey, fontWeight: FontWeight.normal),
        ),
      ),
      Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(8.0),
        child: Text(
          rugSize,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
              color: CustomColors.grey, fontWeight: FontWeight.normal),
        ),
      ),
      Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(8.0),
        child: Text(
          orderDate,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
              color: CustomColors.grey, fontWeight: FontWeight.normal),
        ),
      ),
      Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(8.0),
        child: Text(
          '\$$deposit',
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
              color: CustomColors.grey, fontWeight: FontWeight.normal),
        ),
      ),
      Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(8.0),
        child: Text(
          '\$$total',
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
              color: CustomColors.grey, fontWeight: FontWeight.normal),
        ),
      ),
      Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(8.0),
        child: StatusPill(
          status: status,
        ),
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
