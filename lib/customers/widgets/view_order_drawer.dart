import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:orders_repository/orders_repository.dart';
import 'package:rugs_repository/rugs_repository.dart';
import 'package:stichit/app/const/colors.dart';
import 'package:stichit/customers/cubit/customer_cubit.dart';
import 'package:stichit/rugs/view/widgets/rug_size_display.dart';
import 'package:stichit/ui_commons/alerts/snack_bar.dart';
import 'package:stichit/ui_commons/alerts/status/status_pill.dart';
import 'package:stichit/ui_commons/avatars/initial_avatar.dart';
import 'package:stichit/ui_commons/buttons/custom_button.dart';

class ViewOrderDrawer extends StatefulWidget {
  final VoidCallback closeDrawer;
  final VoidCallback? editOrder;
  final String title;
  final void Function(String status)? onStatusChange;

  ViewOrderDrawer({
    super.key,
    required this.closeDrawer,
    required this.title,
    this.editOrder,
    this.onStatusChange,
  });

  @override
  _ViewOrderDrawerState createState() => _ViewOrderDrawerState();
}

class _ViewOrderDrawerState extends State<ViewOrderDrawer>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this); // 4 tabs
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget _buildDetailRow(String label, String value, {Widget? trailing}) {
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
              trailing == null
                  ? Expanded(
                      flex: 7,
                      child: Text(
                        value,
                        style: TextStyle(
                          color: CustomColors.white.withOpacity(0.7),
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    )
                  : Expanded(flex: 7, child: trailing),
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
    return BlocListener<CustomerCubit, CustomerState>(
      listener: (context, state) {
        switch (state.formStatus) {
          case FormzSubmissionStatus.success:
            showCustomSnackbar(
              context,
              'Success!',
              state.successMessage ?? "Operation Success",
              ContentType.success,
            );
            break;
          case FormzSubmissionStatus.failure:
            showCustomSnackbar(
              context,
              'Error!',
              state.errorMessage ?? 'An error occurred',
              ContentType.failure,
            );
            break;
          default:
            break;
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.5,
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
            return Column(
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: Row(
                    children: [
                      InitialsAvatar(
                        text: selectedOrder?.user?.fullName ?? '',
                        height: 45,
                        width: 45,
                      ),
                      const SizedBox(width: 20),
                      Text(
                        selectedOrder?.orderNumber.toString() ?? '',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.normal,
                          color: CustomColors.white,
                        ),
                      ),
                      const Spacer(),
                      nextStatusButton(selectedOrder?.status.name ?? ""),
                      SizedBox(width: 20),
                      state.selectedOrder?.orderConfirmed != true
                          ? CustomButton(
                              label: 'Order Confirmation',
                              radius: 40,
                              isOutline: true,
                              icon: "assets/icons/mail.svg",
                              primaryColor: Colors.white,
                              onPressed: widget.closeDrawer,
                            )
                          : SizedBox(),
                      const SizedBox(width: 20),
                      IconButton(
                        onPressed: widget.closeDrawer,
                        icon:
                            const Icon(Icons.close, color: CustomColors.white),
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: CustomColors.grey.withOpacity(0.4),
                  height: 0.4,
                ),
                // Tabs
                TabBar(
                  controller: _tabController,
                  labelColor: CustomColors.white,
                  unselectedLabelColor: CustomColors.white.withOpacity(0.5),
                  tabs: const [
                    Tab(text: 'Order Details'),
                    Tab(text: 'Customer Details'),
                    Tab(text: 'Transaction Details'),
                    Tab(text: 'Rug Details'),
                  ],
                  indicatorColor: CustomColors.orange,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        // Order Details Tab
                        SingleChildScrollView(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: CustomColors.darkBackGround,
                            ),
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        selectedOrder?.orderImage?.imageUrl ??
                                            'https://via.placeholder.com/150',
                                    width: double.infinity,
                                    height: 400,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) =>
                                        const SizedBox(
                                            height: 100,
                                            width: 100,
                                            child: CircularProgressIndicator()),
                                    errorWidget: (context, url, error) {
                                      return const Icon(Icons.error);
                                    },
                                  ),
                                ),
                                _buildDetailRow(
                                    'Order #',
                                    selectedOrder?.orderNumber.toString() ??
                                        ''),
                                _buildDetailRow('Order Date',
                                    selectedOrder?.createdAt ?? ''),
                                _buildDetailRow(
                                    'Status', selectedOrder?.status.name ?? '',
                                    trailing: SizedBox(
                                      width: 100,
                                      child: StatusPill(
                                        status:
                                            selectedOrder?.status.name ?? '',
                                      ),
                                    )),
                                _buildDetailRow(
                                    'Notes', selectedOrder?.notes ?? ''),
                              ],
                            ),
                          ),
                        ),
                        // Customer Details Tab
                        SingleChildScrollView(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: CustomColors.darkBackGround,
                            ),
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              children: [
                                _buildDetailRow('Full Name',
                                    selectedOrder?.user?.fullName ?? ''),
                                _buildDetailRow('Email',
                                    selectedOrder?.user?.email?.value ?? ''),
                                _buildDetailRow('Phone',
                                    selectedOrder?.user?.mobile?.value ?? ''),
                                _buildDetailRow('Address',
                                    selectedOrder?.user?.address ?? ''),
                                _buildDetailRow('Gender',
                                    selectedOrder?.user?.gender ?? ''),
                              ],
                            ),
                          ),
                        ),
                        // Transaction Details Tab
                        SingleChildScrollView(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: CustomColors.darkBackGround,
                            ),
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              children: [
                                _buildDetailRow('Deposit',
                                    '\$${selectedOrder?.deposit.toStringAsFixed(2) ?? '0.00'}'),
                                _buildDetailRow('Total Cost',
                                    '\$${selectedOrder?.totalCost.toStringAsFixed(2) ?? '0.00'}'),
                                _buildDetailRow('Estimated Delivery Date',
                                    selectedOrder?.estimatedDeliveryDate ?? ''),
                              ],
                            ),
                          ),
                        ),
                        // Rug Details Tab
                        SingleChildScrollView(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: CustomColors.darkBackGround,
                            ),
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              children: [
                                _buildDetailRow(
                                    'Name', selectedOrder?.rug?.name ?? ''),
                                _buildDetailRow('Size',
                                    '${selectedOrder?.rugSize?.length}cm x ${selectedOrder?.rugSize?.width}cm',
                                    trailing: RugSizeDisplay(
                                        rugSize: selectedOrder?.rugSize ??
                                            RugSizes.empty)),
                                _buildDetailRow(
                                    'Color Palette',
                                    (selectedOrder?.colorPalet?.join(', ') ??
                                        '')),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
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
                            if (widget.editOrder != null) {
                              widget.editOrder!();
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget nextStatusButton(String status) {
    switch (status) {
      case OrderStatus.created:
      case OrderStatus.reaceived:
        return CustomButton(
          label: 'Process',
          radius: 40,
          isOutline: true,
          icon: "assets/icons/arrow-right.svg",
          primaryColor: Colors.white,
          onPressed: () {
            if (widget.onStatusChange != null) {
              widget.onStatusChange!(OrderStatus.processed);
            }
          },
        );
      case OrderStatus.processed:
        return CustomButton(
          label: 'Tuft',
          radius: 40,
          isOutline: true,
          icon: "assets/icons/arrow-right.svg",
          primaryColor: Colors.white,
          onPressed: () {
            if (widget.onStatusChange != null) {
              widget.onStatusChange!(OrderStatus.inProgress);
            }
          },
        );
      case OrderStatus.inProgress:
        return CustomButton(
          label: 'Finish',
          radius: 40,
          isOutline: true,
          icon: "assets/icons/arrow-right.svg",
          primaryColor: Colors.white,
          onPressed: () {
            if (widget.onStatusChange != null) {
              widget.onStatusChange!(OrderStatus.done);
            }
          },
        );
      case OrderStatus.done:
        return CustomButton(
          label: 'Deliver',
          radius: 40,
          isOutline: true,
          icon: "assets/icons/arrow-right.svg",
          primaryColor: Colors.white,
          onPressed: () {
            if (widget.onStatusChange != null) {
              widget.onStatusChange!(OrderStatus.delivered);
            }
          },
        );
      default:
        return SizedBox();
    }
  }
}
