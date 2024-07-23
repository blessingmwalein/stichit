import 'package:flutter/widgets.dart';
import 'package:stichit/app/bloc/app_bloc.dart';
import 'package:stichit/home/view/admin.dart';
import 'package:stichit/login/view/login_page.dart';

List<Page<dynamic>> onGenerateAppViewPages(
  AppStatus state,
  List<Page<dynamic>> pages,
) {
  switch (state) {
    case AppStatus.authenticated:
      return [HomePage.page()];
    case AppStatus.unauthenticated:
      return [LoginPage.page()];
  }
}
