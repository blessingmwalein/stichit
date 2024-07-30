import 'package:authentication_repository/authentication_repository.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';
import 'package:rugs_repository/rugs_repository.dart';
import 'package:stichit/app/const/colors.dart';
import 'package:stichit/app/routes/routes.dart';
import 'package:stichit/login/cubit/login_cubit.dart';
import 'package:stichit/ui_commons/alerts/snack_bar.dart';
import 'package:stichit/ui_commons/buttons/custom_button.dart';
import 'package:stichit/ui_commons/forms/custom_select_field.dart';
import 'package:stichit/ui_commons/forms/custom_text_input.dart';
import 'package:stichit/ui_commons/icons/custom_svg_icon.dart';
import 'package:ui_commons/ui_commons.dart';

class RugCalculatorForm extends StatefulWidget {
  const RugCalculatorForm({Key? key}) : super(key: key);

  @override
  _RugCalculatorFormState createState() => _RugCalculatorFormState();
}

class _RugCalculatorFormState extends State<RugCalculatorForm> {
  bool _hasShownError = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      width: MediaQuery.of(context).size.width * 0.4,
      margin: const EdgeInsets.only(left: 20),
      decoration: BoxDecoration(
        color: CustomColors.searchFormBack,
        borderRadius: BorderRadius.circular(25),
      ),
      padding: const EdgeInsets.all(0),
      child: Padding(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 25),
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
                      label: 'Type',
                      primaryColor: CustomColors.black.withOpacity(0.4),
                      borderColor: CustomColors.black.withOpacity(0.4),
                      selectedOption: RugType.cutPile,
                      options: RugType.values
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
            
          ],
        ),
      ),
    );
  }
}

// Social login buttons
