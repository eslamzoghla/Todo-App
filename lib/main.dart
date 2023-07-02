import 'package:first_project/network/remote/dio_helper.dart';
import 'package:first_project/shared/components/contants.dart';
import 'package:first_project/shared/components/observation.dart';
import 'package:first_project/shared/cubit/cubit.dart';
import 'package:first_project/shared/cubit/news_cubit/news_cubit.dart';
import 'package:first_project/shared/cubit/states.dart';
import 'package:first_project/styles/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'modules/todo_app/newTasks.dart';
import 'network/local/cache_helper.dart';

void main() async {
  // used to print all moves in program and this block work nice or not
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  dioHelper.init();
  await cashesHelper.init();

  bool? darkMode = cashesHelper.getData(key: 'darkMode');

  bool? onBoardSaving = cashesHelper.getData(key: 'onBoarding');

  token = cashesHelper.getData(key: 'token');
  Widget widget;

  print(onBoardSaving);
  runApp(MyApp(darkMode: darkMode));
}

class MyApp extends StatelessWidget {
  final bool? darkMode;
  final Widget? startWidget;

  MyApp({this.darkMode, this.startWidget});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppCubit()..changeThemeMode(isDark: darkMode),
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            // to hide red bar in top screen
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: AppCubit.get(context).darkMode
                ? ThemeMode.dark
                : ThemeMode.light,
            routes: {
              // LoginScreen.routeName: (myContext) => LoginScreen(),
              // MassengerScreen.routeName: (myContext) => MassengerScreen(),
              // home_screen.routeName: (myContext) => home_screen(),
              // HomeLayout.routeName: (myContext) => HomeLayout(),
              // CounterScreen.routeName: (myContext) => CounterScreen(),
              // buttonIncrement.routeName: (myContext) => buttonIncrement(),
              // calculateApp.routeName: (myContext) => calculateApp(),
              // XOGame.routeName: (myContext) => XOGame(),
              // newLayout.routeName:(myContext) => newLayout(),
              // OnBoardScreen.routeName: (myContext) => OnBoardScreen(),
              // LoginShopScreen.routeName: (myContext) => LoginShopScreen(),
              // ShopLayout.routeName: (myContext) => ShopLayout(),
            },
            // initialRoute: startWidget,
            home: NewTasksScreen(),
          );
        },
      ),
    );
  }
}
