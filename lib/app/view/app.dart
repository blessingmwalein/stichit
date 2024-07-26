import 'package:authentication_repository/authentication_repository.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rugs_repository/rugs_repository.dart';
import 'package:stichit/app/bloc/app_bloc.dart';
import 'package:stichit/app/routes/app.dart';
import 'package:stichit/app/routes/routes.dart';
import 'package:stichit/login/login.dart';
import 'package:stichit/rugs/cubit/rugs_cubit.dart';
import 'package:stichit/stock/cubit/stock_cubit.dart';
import 'package:stichit/theme.dart';
import 'package:stock_repository/stock_repository.dart';

class App extends StatelessWidget {
  App({
    super.key,
  });

  final AuthenticationRepository _authenticationRepository =
      AuthenticationRepository();
  final StockRepository _stockRepository = StockRepository();
  final RugsRepositoryBase _rugsRepositoryBase = RugsRepositoryBase();

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthenticationRepository>.value(
          value: _authenticationRepository,
        ),
        RepositoryProvider<StockRepository>.value(
          value: _stockRepository,
        ),
        RepositoryProvider<RugsRepositoryBase>.value(
          value: _rugsRepositoryBase,
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
              _authenticationRepository,
            ),
          ),
          BlocProvider(
            create: (context) => StockCubit(
              stockRepository: _stockRepository,
            ),
          ),
          BlocProvider(
            create: (context) => RugsCubit(
              rugRepository: _rugsRepositoryBase,
            ),
          ),
        ],
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: theme,
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.userRouter,
      // home: FlowBuilder<AppStatus>(
      //   state: context.select((AppBloc bloc) => bloc.state.status),
      //   onGeneratePages: onGenerateAppViewPages,
      // ),
    );
  }
}
