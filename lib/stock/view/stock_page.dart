import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:stichit/app/const/colors.dart';
import 'package:stichit/app/layouts/main_layout.dart';
import 'package:stichit/stock/cubit/stock_cubit.dart';
import 'package:stichit/stock/data_sources/stock_data_source.dart';
import 'package:stichit/stock/view/widgets/stock_form_drawer.dart'; // Import the new view drawer
import 'package:stichit/ui_commons/alerts/confirm_dialog.dart';
import 'package:stichit/ui_commons/buttons/dropdown_button.dart';
import 'package:stichit/ui_commons/loaders/error_page.dart';
import 'package:stichit/ui_commons/loaders/no_data_page.dart';
import 'package:stichit/ui_commons/loaders/page_loader.dart';
import 'package:stichit/ui_commons/tables/custom_data_table.dart';
import 'package:raw_materials_repository/raw_materials_repository.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class StockPage extends StatefulWidget {
  const StockPage({super.key});

  static Page<void> page() => const MaterialPage<void>(child: StockPage());

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const StockPage());
  }

  @override
  _StockPageState createState() => _StockPageState();
}

class _StockPageState extends State<StockPage> {
  @override
  void initState() {
    super.initState();
  }

  bool _isDrawerOpen = false;
  bool _isViewDrawerOpen = false; // Add a boolean for the view drawer
  String _selectedValue = 'Stocks';

  void _toggleDrawer() {
    setState(() {
      _isDrawerOpen = !_isDrawerOpen;
    });
  }

  // Toggle view drawer
  void _toggleViewDrawer() {
    setState(() {
      _isViewDrawerOpen = !_isViewDrawerOpen;
    });
  }

  void _closeDrawer() {
    setState(() {
      _isDrawerOpen = false;
    });

    // Clear form and selected stock from bloc
    context.read<StockCubit>().clearForm();
  }

  void _closeViewDrawer() {
    setState(() {
      _isViewDrawerOpen = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<StockCubit>(context).getStocks();
    final stockCubit = context.read<StockCubit>();

    return DefaultTabController(
      length: 3, // Number of tabs
      child: MainLayout(
        crumbs: const ['Home', 'RawMaterial'],
        isOpened: _isDrawerOpen,
        actionDrawers: [
          StockFormDrawer(
            title: 'Add $_selectedValue',
            closeDrawer: _closeDrawer,
          ),
        ],
        child: Column(
          children: [
            Row(
              children: [
                const Expanded(
                  child: TabBar(
                    dividerColor: Colors.transparent,
                    isScrollable: true,
                    tabs: [
                      Tab(text: 'Yarn'),
                      Tab(text: 'Cloth'),
                      Tab(text: 'Glue'),
                    ],
                    indicatorColor: CustomColors.orange,
                    labelColor: CustomColors.white,
                    unselectedLabelColor: Colors.grey,
                    indicatorSize: TabBarIndicatorSize.label,
                    labelStyle: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                    ),
                    unselectedLabelStyle: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropDownButton(
                    items: RawMaterialCategory.values
                        .map((e) => e.toString().split('.').last)
                        .toList(),
                    selectedValue: _selectedValue,
                    onChanged: (String? value) {
                      setState(() {
                        _selectedValue = value!;
                      });
                      _toggleDrawer();
                    },
                  ),
                ),
                const SizedBox(width: 20), // Adjust the spacing as needed
              ],
            ),
            Expanded(
              child: BlocBuilder<StockCubit, StockCubitState>(
                builder: (context, state) {
                  switch (state.pageStatus) {
                    case FormzSubmissionStatus.inProgress:
                      return const PageLoader();
                    case FormzSubmissionStatus.success:
                      // Get stocks by category

                      List<RawMaterial> yarns =
                          stockCubit.searchStockByCategory('Yarn');
                      List<RawMaterial> cloths =
                          stockCubit.searchStockByCategory('Cloth');
                      List<RawMaterial> glues =
                          stockCubit.searchStockByCategory('Glue');

                      // Define a function to build data tables
                      Widget buildDataTable(List<RawMaterial> stockList) {
                        if (stockList.isEmpty) {
                          return const NoDataPage(
                              message: 'No stocks available');
                        }
                        return CustomerDataTable(
                          dataSource: StockDataSource(
                              stockList: stockList,
                              onView: (RawMaterial stock) {
                                context
                                    .read<StockCubit>()
                                    .setSelectedStock(stock);
                                _toggleViewDrawer();
                              },
                              onDelete: (RawMaterial stock) async {
                                final bool? isDelete =
                                    await showCustomConfirmationDialog(
                                  context,
                                  'Delete RawMaterial',
                                  'Are you sure you want to delete this stock?',
                                  'assets/icons/trash.svg',
                                );
                                if (isDelete == true) {
                                  // context.read<StockCubit>().deleteStock(stock);
                                }
                              },
                              onEdit: (RawMaterial stock) {
                                context.read<StockCubit>().editStock(stock);
                                _toggleDrawer();
                              }),
                          sort: true,
                          filter: true,
                          columns: const [
                            "ID",
                            "Name",
                            "Category",
                            "Quantity",
                            "Measures",
                            "Color",
                            "Price",
                            "Actions",
                          ],
                        );
                      }

                      return Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: CustomColors.lightBackGround,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: TabBarView(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8.0),
                                child: buildDataTable(yarns),
                              ),
                              Container(
                                padding: const EdgeInsets.all(8.0),
                                child: buildDataTable(cloths),
                              ),
                              Container(
                                padding: const EdgeInsets.all(8.0),
                                child: buildDataTable(glues),
                              ),
                            ],
                          ),
                        ),
                      );
                    case FormzSubmissionStatus.failure:
                      return ErrorPage(
                          message: state.errorMessage ?? 'An error occurred');
                    default:
                      return const SizedBox();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
