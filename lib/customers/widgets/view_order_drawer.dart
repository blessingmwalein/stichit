import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:stichit/app/const/colors.dart';
import 'package:stichit/customers/cubit/customer_cubit.dart';
import 'package:stichit/ui_commons/avatars/initial_avatar.dart';
import 'package:stichit/ui_commons/buttons/custom_button.dart';

class ViewOrderDrawer extends StatefulWidget {
  final VoidCallback closeDrawer;
  final VoidCallback? editOrder;
  final String title;

  const ViewOrderDrawer({
    super.key,
    required this.closeDrawer,
    required this.title,
    this.editOrder,
  });

  @override
  _ViewOrderDrawerState createState() => _ViewOrderDrawerState();
}

class _ViewOrderDrawerState extends State<ViewOrderDrawer> {
  @override
  void initState() {
    super.initState();
  }

  Widget _buildDetailRow(String label, String value) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  label,
                  style: TextStyle(
                    color: CustomColors.white.withOpacity(0.7),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Expanded(
                flex: 7,
                child: Text(
                  value,
                  style: TextStyle(
                    color: CustomColors.white.withOpacity(0.7),
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ],
          ),
        ),
        Divider(
          color: CustomColors.white.withOpacity(0.3),
          thickness: 1,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.4,
      decoration: const BoxDecoration(
        color: CustomColors.lightBackGround,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: BlocBuilder<CustomerCubit, CustomerState>(
        builder: (context, state) {
          final selectedOrder = state.selectedOrder;
          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(13.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        InitialsAvatar(
                          text: selectedOrder?.userId ?? '',
                          height: 45,
                          width: 45,
                        ),
                        const SizedBox(width: 20),
                        Text(
                          selectedOrder?.userId ?? '',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.normal,
                            color: CustomColors.white,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: widget.closeDrawer,
                          icon: const Icon(Icons.close,
                              color: CustomColors.white),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Divider(
                      color: CustomColors.grey.withOpacity(0.4),
                      height: 0.4,
                    ),
                    const SizedBox(height: 15),
                    if (selectedOrder != null)
                      Expanded(
                        child: SingleChildScrollView(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: CustomColors.darkBackGround,
                            ),
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              children: [
                                _buildDetailRow('Order ID', selectedOrder.id),
                                _buildDetailRow(
                                    'User ID', selectedOrder.userId),
                                _buildDetailRow('Rug ID', selectedOrder.rugId),
                                _buildDetailRow(
                                    'Rug Size ID', selectedOrder.rugSizeId),
                                _buildDetailRow(
                                    'Created At', selectedOrder.createdAt),
                                _buildDetailRow(
                                    'Status', selectedOrder.status.toString()),
                                _buildDetailRow(
                                    'Notes', selectedOrder.notes ?? ''),
                              ],
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  color: CustomColors.lightBackGround,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomButton(
                        label: 'Close',
                        radius: 40,
                        primaryColor: Colors.red,
                        onPressed: widget.closeDrawer,
                      ),
                      const SizedBox(width: 16),
                      CustomButton(
                        label: 'Edit',
                        primaryColor: CustomColors.orange,
                        radius: 40,
                        isLoading: state.formStatus ==
                            FormzSubmissionStatus.inProgress,
                        isDisabled: state.formStatus ==
                            FormzSubmissionStatus.inProgress,
                        onPressed: () {
                          widget.editOrder!();
                        },
                      )
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
