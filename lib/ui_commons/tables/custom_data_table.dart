import 'package:flutter/material.dart';
import 'package:stichit/app/const/colors.dart';
import 'package:stichit/ui_commons/icons/custom_svg_icon.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';

class CustomerDataTable<T> extends StatefulWidget {
  final List<Widget>? actions;
  final List<String> columns;
  final T dataSource;
  // final List<Widget> Function(T) rowBuilder;
  final bool sort;
  final bool filter;

  const CustomerDataTable({
    Key? key,
    this.actions,
    required this.columns,
    required this.dataSource,
    required this.sort,
    required this.filter,
  }) : super(key: key);

  @override
  State<CustomerDataTable<T>> createState() => _CustomerDataTableState<T>();
}

class _CustomerDataTableState<T> extends State<CustomerDataTable<T>> {
  @override
  Widget build(BuildContext context) {
    return SfDataGridTheme(
      data: SfDataGridThemeData(
          gridLineColor: Colors.grey.withOpacity(0.3),
          gridLineStrokeWidth: 0.3,
          filterIcon: Padding(
            padding: const EdgeInsets.all(3.0),
            child: customSvgIcon(
                path: "assets/icons/filter.svg",
                width: 15,
                height: 15,
                iconColor: CustomColors.white),
          ),
          sortIcon: Padding(
            padding: const EdgeInsets.all(3.0),
            child: customSvgIcon(
                path: "assets/icons/switch-vertical.svg",
                width: 15,
                height: 15,
                iconColor: CustomColors.white),
          ),
          headerHoverColor: CustomColors.white.withOpacity(0.3),
          headerColor: CustomColors.orange),
      child: SfDataGrid(
        source: widget.dataSource as DataGridSource,
        columnWidthMode: ColumnWidthMode.fill,
        allowSorting: widget.sort,
        allowFiltering: widget.filter,
        // gridLinesVisibility: GridLinesVisibility.none,
        columns: <GridColumn>[
          for (final column in widget.columns)
            GridColumn(
              filterIconPadding: EdgeInsets.zero,
              columnName: column,
              allowSorting: column != 'Actions' ? widget.sort : false,
              allowFiltering: column != 'Actions' ? widget.filter : false,
              label: Container(
                padding: const EdgeInsets.all(8.0),
                alignment:column != 'Actions' ? Alignment.centerLeft : Alignment.center,
                child: Text(
                  column,
                  style: const TextStyle(
                      fontWeight: FontWeight.w500, color: CustomColors.white),
                ),
              ),
            ),

          //actions
          if (widget.actions != null)
            GridColumn(
              columnName: 'actions',
              label: Container(
                padding: const EdgeInsets.all(8.0),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: widget.actions!,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
