import 'package:authentication_repository/authentication_repository.dart';
import 'package:customer_repository/customer_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orders_repository/orders_repository.dart';
import 'package:rugs_repository/rugs_repository.dart';
import 'package:stichit/app/bloc/app_bloc.dart';
import 'package:stichit/app/routes/app.dart';
import 'package:stichit/customers/cubit/customer_cubit.dart';
import 'package:stichit/login/login.dart';
import 'package:stichit/raw_materials/cubit/raw_material_cubit.dart';
import 'package:stichit/rugs/cubit/rugs_cubit.dart';
import 'package:stichit/sign-up/cubit/sign_up_cubit.dart';
import 'package:stichit/theme.dart';
import 'package:raw_materials_repository/raw_materials_repository.dart';

class App extends StatelessWidget {
  App({
    super.key,
  });

  final AuthenticationRepository _authenticationRepository =
      AuthenticationRepository();
  final RawMaterialsRepository _rawMaterialsRepository =
      RawMaterialsRepository();
  final RugsRepositoryBase _rugsRepositoryBase = RugsRepositoryBase();
  final CustomerRepository _customerRepository = CustomerRepository();
  //order repository
  final OrdersRepositoryBase _orderRepository = OrdersRepositoryBase();

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthenticationRepository>.value(
          value: _authenticationRepository,
        ),
        RepositoryProvider<RawMaterialsRepository>.value(
          value: _rawMaterialsRepository,
        ),
        RepositoryProvider<RugsRepositoryBase>.value(
          value: _rugsRepositoryBase,
        ),
        RepositoryProvider<CustomerRepository>.value(
          value: _customerRepository,
        ),
        RepositoryProvider<OrdersRepositoryBase>.value(
          value: _orderRepository,
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => AppBloc(
              authenticationRepository: _authenticationRepository,
            ),
          ),
          BlocProvider(
            create: (context) => LoginCubit(
              authenticationRepository: _authenticationRepository,
            ),
          ),
          BlocProvider(
            create: (context) => RawMaterialCubit(
              rawMaterialRepository: _rawMaterialsRepository,
            ),
          ),
          BlocProvider(
            create: (context) => RugsCubit(
              rugRepository: _rugsRepositoryBase,
            ),
          ),
          BlocProvider(
            create: (context) => SignUpCubit(
              authenticationRepository: _authenticationRepository,
            ),
          ),
          BlocProvider(
            create: (context) => CustomerCubit(
              customerRepository: _customerRepository,
              ordersRepository: _orderRepository,
            ),
          ),
        ],
        child: BlocListener<AppBloc, AppState>(
          listener: (context, state) {
            // AppRouter.router.refresh();
          },
          child: const AppView(),
        ),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    final appBloc = context.read<AppBloc>();

    return MaterialApp.router(
      theme: theme,
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.userRouter(appBloc),
    );
  }
}
