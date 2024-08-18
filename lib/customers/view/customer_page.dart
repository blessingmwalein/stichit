import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:stichit/app/const/colors.dart';
import 'package:stichit/app/layouts/main_layout.dart';
import 'package:stichit/customers/cubit/customer_cubit.dart';
import 'package:stichit/customers/data_sources/customers_data_source.dart';
import 'package:stichit/customers/widgets/customer_form_drawer.dart';
import 'package:stichit/customers/widgets/view_customer_drawer.dart';
import 'package:stichit/rugs/constant.dart';

import 'package:stichit/ui_commons/alerts/confirm_dialog.dart';
import 'package:stichit/ui_commons/buttons/custom_button.dart';
import 'package:stichit/ui_commons/loaders/error_page.dart';
import 'package:stichit/ui_commons/loaders/no_data_page.dart';
import 'package:stichit/ui_commons/loaders/page_loader.dart';
import 'package:stichit/ui_commons/tables/custom_data_table.dart';

class CustomerPage extends StatefulWidget {
  const CustomerPage({super.key});

  @override
  _CustomerPageState createState() => _CustomerPageState();
}

class _CustomerPageState extends State<CustomerPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CustomerCubit>(context).getCustomers();
  }

  bool _isCreatDrawerOpen = false;
  bool _isViewDrawerOpen = false;
  final String _selectedValue = 'Customers';

  void _toggleDrawer(
    DraweType drawerType,
  ) {
    setState(() {
      switch (drawerType) {
        case DraweType.add:
          _isCreatDrawerOpen = !_isCreatDrawerOpen;
          break;
        case DraweType.view:
          _isViewDrawerOpen = !_isViewDrawerOpen;
          break;
        default:
          break;
      }
    });
  }

  void _closeDrawer(
    DraweType drawerType,
  ) {
    setState(() {
      switch (drawerType) {
        case DraweType.add:
          _isCreatDrawerOpen = false;
          break;
        case DraweType.view:
          _isViewDrawerOpen = false;
          break;
        default:
          break;
      }
    });

    //fire clear form event and selected customer frombloc
    context.read<CustomerCubit>().clearForm();
  }

  @override
  Widget build(BuildContext context) {
    // final rugCubit = context.read<CustomerCubit>();

    return MainLayout(
      crumbs: const ['Home', 'Customers'],
      isOpened: _isCreatDrawerOpen || _isViewDrawerOpen,
      actionDrawers: [
        _isCreatDrawerOpen
            ? CustomerFormDrawer(
                title: 'Add $_selectedValue',
                closeDrawer: () {
                  _closeDrawer(DraweType.add);
                },
              )
            : const SizedBox(),
        _isViewDrawerOpen
            ? ViewCustomerDrawer(
                title: 'View $_selectedValue',
                closeDrawer: () {
                  _closeDrawer(DraweType.view);
                },
                editCustomer: () {
                  _toggleDrawer(
                    DraweType.view,
                  );
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
              // Get customers by category

              // Define a function to build data tables
              Widget buildDataTable(List<UserModel> customerList) {
                if (customerList.isEmpty) {
                  return const Column(
                    children: [
                      SizedBox(height: 40),
                      Center(
                          child: NoDataPage(message: 'No customers available')),
                    ],
                  );
                }
                return SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: CustomerDataTable(
                    dataSource: CustomersDataSource(
                        customerList: customerList,
                        onDelete: (UserModel customer) async {
                          final bool? isDelete =
                              await showCustomConfirmationDialog(
                            context,
                            'Delete Customer',
                            'Are you sure you want to delete this customer?',
                            'assets/icons/trash.svg',
                          );

                          if (isDelete != null && isDelete) {
                            // ignore: use_build_context_synchronously
                            context
                                .read<CustomerCubit>()
                                .deleteCustomer(customer);
                          }
                        },
                        onView: (UserModel customer) {
                          context
                              .read<CustomerCubit>()
                              .setSelectedCustomer(customer);
                          _toggleDrawer(
                            DraweType.view,
                          );
                        },
                        onEdit: (UserModel customer) {
                          context.read<CustomerCubit>().editCustomer(customer);
                          _toggleDrawer(
                            DraweType.add,
                          );
                        }),
                    sort: true,
                    filter: true,
                    columns: const [
                      "ID",
                      "Name",
                      "Email",
                      "Gender",
                      "Mobile",
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
                            'Customers',
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
                            label: 'Add Customer',
                            primaryColor: CustomColors.orange,
                            primaryTextColor: CustomColors.white,
                            onPressed: () {
                              _toggleDrawer(
                                DraweType.add,
                              );
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
                          child: buildDataTable(state.customers),
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


//