import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:rugs_repository/rugs_repository.dart';
import 'package:stichit/app/const/colors.dart';
import 'package:stichit/app/layouts/main_layout.dart';
import 'package:stichit/rugs/constant.dart';
import 'package:stichit/rugs/cubit/rugs_cubit.dart';
import 'package:stichit/rugs/data_sources/rugs_data_source.dart';
import 'package:stichit/rugs/view/widgets/rug_form_drawer.dart';
import 'package:stichit/rugs/view/widgets/view_rug_drawer.dart';
import 'package:stichit/ui_commons/alerts/confirm_dialog.dart';
import 'package:stichit/ui_commons/buttons/custom_button.dart';
import 'package:stichit/ui_commons/loaders/error_page.dart';
import 'package:stichit/ui_commons/loaders/no_data_page.dart';
import 'package:stichit/ui_commons/loaders/page_loader.dart';
import 'package:stichit/ui_commons/tables/custom_data_table.dart';

class RugsPage extends StatefulWidget {
  const RugsPage({super.key});

  static Page<void> page() => const MaterialPage<void>(child: RugsPage());

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const RugsPage());
  }

  @override
  StockPageState createState() => StockPageState();
}

class StockPageState extends State<RugsPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<RugsCubit>(context).getRugs();
  }

  bool _isCreateRugDrawerOpen = false;
  bool _isViewDrawerOpen = false;
  final String _selectedValue = 'Rugs';

  void _toggleDrawer(
    RugDrawerType drawerType,
  ) {
    setState(() {
      switch (drawerType) {
        case RugDrawerType.add:
          _isCreateRugDrawerOpen = !_isCreateRugDrawerOpen;
          break;
        case RugDrawerType.view:
          _isViewDrawerOpen = !_isViewDrawerOpen;
          break;
        default:
          break;
      }
    });
  }

  void _closeDrawer(
    RugDrawerType drawerType,
  ) {
    setState(() {
      switch (drawerType) {
        case RugDrawerType.add:
          _isCreateRugDrawerOpen = false;
          break;
        case RugDrawerType.view:
          _isViewDrawerOpen = false;
          break;
        default:
          break;
      }
    });

    //fire clear form event and selected rug frombloc
    context.read<RugsCubit>().clearForm();
  }

  @override
  Widget build(BuildContext context) {
    // final rugCubit = context.read<RugsCubit>();

    return MainLayout(
      crumbs: const ['Home', 'Rug'],
      isOpened: _isCreateRugDrawerOpen || _isViewDrawerOpen,
      actionDrawers: [
        _isCreateRugDrawerOpen
            ? RugFormDrawer(
                title: 'Add $_selectedValue',
                closeDrawer: () {
                  _closeDrawer(RugDrawerType.add);
                },
              )
            : const SizedBox(),
        _isViewDrawerOpen
            ? ViewRugDrawer(
                title: 'View $_selectedValue',
                closeDrawer: () {
                  _closeDrawer(RugDrawerType.view);
                },
                editRug: () {
                  _toggleDrawer(
                    RugDrawerType.view,
                  );
                },
              )
            : const SizedBox(),
      ],
      child: BlocBuilder<RugsCubit, RugsState>(
        builder: (context, state) {
          switch (state.pageStatus) {
            case FormzSubmissionStatus.inProgress:
              return const PageLoader();
            case FormzSubmissionStatus.success:
              // Get rugs by category

              // Define a function to build data tables
              Widget buildDataTable(List<Rug> rugList) {
                if (rugList.isEmpty) {
                  return const Column(
                    children: [
                      SizedBox(height: 40),
                      Center(child: NoDataPage(message: 'No rugs available')),
                    ],
                  );
                }
                return CustomerDataTable(
                  dataSource: RugsDataSource(
                      rugList: rugList,
                      onDelete: (Rug rug) async {
                        // context.read<RugsCubit>().deleteRug(rug);
                        final bool? isDelete =
                            await showCustomConfirmationDialog(
                          context,
                          'Delete Rug',
                          'Are you sure you want to delete this rug?',
                          'assets/icons/trash.svg',
                        );
                      },
                      onView: (Rug rug) {
                        context.read<RugsCubit>().setSelectedRug(
                              rug,
                            );
                        _toggleDrawer(
                          RugDrawerType.view,
                        );
                      },
                      onEdit: (Rug rug) {
                        context.read<RugsCubit>().editRug(rug);
                        _toggleDrawer(
                          RugDrawerType.add,
                        );
                      }),
                  sort: true,
                  filter: true,
                  columns: const [
                    "ID",
                    "Name",
                    "Aprox Price",
                    "Description",
                    "Actions",
                  ],
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
                            'Rugs',
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
                            label: 'Add Rug',
                            primaryColor: CustomColors.orange,
                            primaryTextColor: CustomColors.white,
                            onPressed: () {
                              _toggleDrawer(
                                RugDrawerType.add,
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
                          child: buildDataTable(state.rugs),
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