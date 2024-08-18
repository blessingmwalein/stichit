import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:stichit/app/const/colors.dart';
import 'package:stichit/ui_commons/avatars/initial_avatar.dart';
import 'package:stichit/ui_commons/buttons/copy_text_button.dart';
import 'package:stichit/ui_commons/buttons/icon_drop_down_button.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class CustomersDataSource extends DataGridSource {
  CustomersDataSource({
    required List<UserModel> customerList,
    required this.onEdit,
    required this.onView,
    required this.onDelete,
  }) {
    _customersList = customerList
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(columnName: 'id', value: e.id),
              DataGridCell<String>(columnName: 'name', value: e.fullName),
              DataGridCell<String>(columnName: 'email', value: e.email?.value),
              DataGridCell<String>(
                  columnName: 'gender', value: e.gender.toString()),
              DataGridCell<String>(
                  columnName: 'mobile', value: e.mobile?.value),
              DataGridCell<String>(columnName: 'address', value: e.address),
            ]))
        .toList();
  }

  final Function(UserModel) onEdit;
  final Function(UserModel) onView;
  final Function(UserModel) onDelete;

  List<DataGridRow> _customersList = [];

  @override
  List<DataGridRow> get rows => _customersList;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    //get stock from list
    final customerId = row.getCells()[0].value.toString();
    final fullName = row.getCells()[1].value.toString();

    final email = row.getCells()[2].value.toString();
    final gender = row.getCells()[3].value.toString();
    final mobile = row.getCells()[4].value.toString();
    final address = row.getCells()[5].value.toString();

    // Assuming you have a way to get the selected stock
    UserModel selectedCustomer = UserModel(
        id: customerId,
        fullName: fullName,
        email: Email.dirty(email),
        gender: gender,
        address: address,
        mobile: PhoneNumber.dirty(mobile));

    return DataGridRowAdapter(cells: <Widget>[
      Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8.0),
        child: CopyTextButton(text: customerId),
      ),
      Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            InitialsAvatar(
              text: selectedCustomer.fullName ?? "",
              height: 30,
              width: 30,
            ),
            const SizedBox(width: 10),
            Text(fullName,
                style: const TextStyle(
                    color: CustomColors.grey, fontWeight: FontWeight.normal)),
          ],
        ),
      ),
      Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(8.0),
        child: Text(email,
            style: const TextStyle(
                color: CustomColors.grey, fontWeight: FontWeight.normal)),
      ),
      Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(8.0),
        child: Text(
          gender,
          style: const TextStyle(
              color: CustomColors.grey, fontWeight: FontWeight.normal),
        ),
      ),
      Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(8.0),
        child: Text(
          mobile,
          style: const TextStyle(
              color: CustomColors.grey, fontWeight: FontWeight.normal),
        ),
      ),
      Container(
        alignment: Alignment.centerLeft,
        child: IconDropDownButton(
          items: const ['View', 'Edit', 'Delete'],
          onChanged: (String? newValue) {
            switch (newValue) {
              case 'View':
                onView(selectedCustomer);
                break;
              case 'Edit':
                // Call the editStock method with the selected stock
                onEdit(selectedCustomer);
                break;
              case 'Delete':
                onDelete(selectedCustomer);
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
