import 'package:flutter/material.dart';
import 'package:rugs_repository/rugs_repository.dart';
import 'package:stichit/app/const/colors.dart';
import 'package:stichit/ui_commons/buttons/custom_button.dart';
import 'package:stichit/ui_commons/forms/custom_select_field.dart';
import 'package:stichit/ui_commons/forms/custom_text_input.dart';

class RugCalculatorForm extends StatefulWidget {
  const RugCalculatorForm({Key? key}) : super(key: key);

  @override
  _RugCalculatorFormState createState() => _RugCalculatorFormState();
}

class _RugCalculatorFormState extends State<RugCalculatorForm> {
  // Controllers for length and width input fields
  final TextEditingController _lengthController = TextEditingController();
  final TextEditingController _widthController = TextEditingController();

  // Variables to store the calculated values
  double _totalPrice = 0.0;
  int _totalDays = 0;
  int _totalHours = 0;
  String _discount = 'No discount';

  void _calculatePrice() {
    // Implement the calculation logic here and update the state variables
    setState(() {
      // For example purposes, let's use dummy values
      _totalPrice = 120.0;
      _totalDays = 3;
      _totalHours = 6;
      _discount = '5% off for early order';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      width: MediaQuery.of(context).size.width * 0.5,
      margin: const EdgeInsets.only(left: 20),
      decoration: BoxDecoration(
        color: CustomColors.searchFormBack,
        borderRadius: BorderRadius.circular(25),
      ),
      padding: const EdgeInsets.all(0),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 25),
            Text(
              'Design Your Perfect Rug',
              style: TextStyle(
                color: CustomColors.black.withOpacity(0.7),
                fontSize: 25,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: CustomSelectTextFieldWidget(
                      isOutline: true,
                      label: 'Size',
                      primaryColor: CustomColors.black.withOpacity(0.4),
                      borderColor: CustomColors.black.withOpacity(0.4),
                      selectedOption: RugSize.medium,
                      options: RugSize.values
                          .map((e) => e.toString().split('.').last)
                          .toList(),
                      onChanged: (value) {},
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: CustomSelectTextFieldWidget(
                      isOutline: true,
                      label: 'Shape',
                      primaryColor: CustomColors.black.withOpacity(0.4),
                      borderColor: CustomColors.black.withOpacity(0.4),
                      selectedOption: RugShape.rectangle,
                      options: RugShape.values
                          .map((e) => e.toString().split('.').last)
                          .toList(),
                      onChanged: (value) {},
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: CustomTextFieldWidget(
                      controller: _lengthController,
                      label: 'Approx. Length (cm)',
                      isOutline: true,
                      hint: 'Enter length',
                      onChanged: (value) {},
                      isEnabled: true,
                      primaryColor: CustomColors.black.withOpacity(0.4),
                      isPassword: false,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: CustomTextFieldWidget(
                      controller: _widthController,
                      label: 'Approx. Width (cm)',
                      isOutline: true,
                      hint: 'Enter width',
                      primaryColor: CustomColors.black.withOpacity(0.4),
                      isPassword: false,
                      onChanged: (value) {},
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomSelectTextFieldWidget(
                isOutline: true,
                label: 'Design Complexity',
                primaryColor: CustomColors.black.withOpacity(0.4),
                borderColor: CustomColors.black.withOpacity(0.4),
                selectedOption: 'Simple',
                options: ['Simple', 'Moderate', 'Complex'],
                onChanged: (value) {},
              ),
            ),
            const SizedBox(height: 15),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: CustomColors.lightBackGround,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total Price',
                        style: TextStyle(
                          color: CustomColors.white.withOpacity(0.5),
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      Text(
                        '\$$_totalPrice',
                        style: TextStyle(
                          color: CustomColors.white.withOpacity(0.7),
                          fontSize: 35,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Estimated Time',
                        style: TextStyle(
                          color: CustomColors.white.withOpacity(0.5),
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      Text(
                        '$_totalDays days $_totalHours hours',
                        style: TextStyle(
                          color: CustomColors.white.withOpacity(0.7),
                          fontSize: 35,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Discount',
                        style: TextStyle(
                          color: CustomColors.white.withOpacity(0.5),
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      Text(
                        _discount,
                        style: TextStyle(
                          color: CustomColors.white.withOpacity(0.7),
                          fontSize: 35,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  height: 60,
                  child: CustomButton(
                    label: 'Calculate Price',
                    primaryColor: CustomColors.orange,
                    radius: 40,
                    onPressed: _calculatePrice,
                  ),
                ),
                const SizedBox(width: 20),
                SizedBox(
                  height: 60,
                  child: CustomButton(
                    label: 'Order Now',
                    primaryColor: CustomColors.black,
                    radius: 40,
                    onPressed: _calculatePrice,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
