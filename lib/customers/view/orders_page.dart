import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:orders_repository/orders_repository.dart';
import 'package:rugs_repository/rugs_repository.dart';
import 'package:stichit/app/const/colors.dart';
import 'package:stichit/app/layouts/main_layout.dart';
import 'package:stichit/customers/cubit/customer_cubit.dart';
import 'package:stichit/customers/data_sources/orders_data_source.dart';
import 'package:stichit/customers/widgets/order_form_drawe.dart';
import 'package:stichit/customers/widgets/view_order_drawer.dart';
import 'package:stichit/rugs/constant.dart';
import 'package:stichit/rugs/cubit/rugs_cubit.dart';

import 'package:stichit/ui_commons/alerts/confirm_dialog.dart';
import 'package:stichit/ui_commons/buttons/custom_button.dart';
import 'package:stichit/ui_commons/loaders/error_page.dart';
import 'package:stichit/ui_commons/loaders/no_data_page.dart';
import 'package:stichit/ui_commons/loaders/page_loader.dart';
import 'package:stichit/ui_commons/tables/custom_data_table.dart';

class CustomerOrderPage extends StatefulWidget {
  const CustomerOrderPage({super.key});

  @override
  _CustomerOrderPageState createState() => _CustomerOrderPageState();
}

class _CustomerOrderPageState extends State<CustomerOrderPage> {
  @override
  void initState() {
    super.initState();
  }

  bool _isCreateDrawerOpen = false;
  bool _isViewDrawerOpen = false;
  final String _selectedValue = 'Orders';

  void _toggleDrawer(DraweType drawerType) {
    setState(() {
      switch (drawerType) {
        case DraweType.add:
          _isCreateDrawerOpen = !_isCreateDrawerOpen;
          break;
        case DraweType.view:
          _isViewDrawerOpen = !_isViewDrawerOpen;
          break;
        default:
          break;
      }
    });
  }

  void _closeDrawer(DraweType drawerType) {
    setState(() {
      switch (drawerType) {
        case DraweType.add:
          _isCreateDrawerOpen = false;
          break;
        case DraweType.view:
          _isViewDrawerOpen = false;
          break;
        default:
          break;
      }
    });

    // Clear form and selected order from bloc
    context.read<CustomerCubit>().clearOrderForm();
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CustomerCubit>(context).getOrders();
    BlocProvider.of<CustomerCubit>(context).getCustomers();
    BlocProvider.of<RugsCubit>(context).getRugs();

    return MainLayout(
      crumbs: const ['Home', 'Orders'],
      isOpened: _isCreateDrawerOpen || _isViewDrawerOpen,
      actionDrawers: [
        _isCreateDrawerOpen
            ? OrdersFormDrawer(
                title: 'Add $_selectedValue',
                closeDrawer: () {
                  _closeDrawer(DraweType.add);
                },
              )
            : const SizedBox(),
        _isViewDrawerOpen
            ? ViewOrderDrawer(
                title: 'View $_selectedValue',
                closeDrawer: () {
                  _closeDrawer(DraweType.view);
                },
                editOrder: () {
                  _toggleDrawer(DraweType.view);
                },
              )
            : const SizedBox(),
      ],
      child: BlocBuilder<CustomerCubit, CustomerState>(
        builder: (context, state) {
          switch (state.pageStatus) {
            case FormzSubmissionStatus.inProgress:
              return const PageLoader();
            case FormzSubmissionStatus.success:
              // Define a function to build data tables
              Widget buildDataTable(List<CustomerOrder> orderList) {
                if (orderList.isEmpty) {
                  return const Column(
                    children: [
                      SizedBox(height: 40),
                      Center(child: NoDataPage(message: 'No orders available')),
                    ],
                  );
                }
                return SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: CustomerDataTable(
                    dataSource: OrdersDataSource(
                        orderList: orderList,
                        onDelete: (CustomerOrder order) async {
                          final bool? isDelete =
                              await showCustomConfirmationDialog(
                            context,
                            'Delete Order',
                            'Are you sure you want to delete this order?',
                            'assets/icons/trash.svg',
                          );

                          if (isDelete != null && isDelete) {
                            context.read<CustomerCubit>().deleteOrder(order);
                          }
                        },
                        onView: (CustomerOrder order) {
                          context.read<CustomerCubit>().setSelectedOrder(order);
                          _toggleDrawer(DraweType.view);
                        },
                        onEdit: (CustomerOrder order) {
                          context.read<CustomerCubit>().editOrder(order);
                          context
                              .read<RugsCubit>()
                              .getRugSizes(order.rug ?? Rug.empty);
                          _toggleDrawer(DraweType.add);
                        }),
                    sort: true,
                    filter: true,
                    columns: const [
                      "Oder #",
                      "Customer",
                      "Rug Name",
                      "Rug Size",
                      "Order Date",
                      "Deposit",
                      "Cost",
                      "Status",
                      "Actions",
                    ],
                  ),
                );
              }

              return Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Expanded(
                          child: Text(
                            'Orders',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: CustomColors.white,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomButton(
                            label: 'Add Order',
                            primaryColor: CustomColors.orange,
                            primaryTextColor: CustomColors.white,
                            onPressed: () {
                              _toggleDrawer(DraweType.add);
                            },
                          ),
                        ),
                        const SizedBox(
                            width: 20), // Adjust the spacing as needed
                      ],
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Center(
                          child: buildDataTable(state.orders),
                        ),
                      ),
                    ),
                  ],
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
    );
  }
}
