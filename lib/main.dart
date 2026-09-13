import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pocket_pal/core/shared/bottom_nav/controller/bottom_nav_controller.dart';
import 'package:pocket_pal/core/shared/bottom_nav/presentation/bottom_nav_screen.dart';
import 'package:pocket_pal/features/home/cubit/transaction_cubit.dart';
import 'package:pocket_pal/features/profile/cubit/profile_cubit.dart';

void main() async {
  // runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('transactions');
  await Hive.openBox('profile');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => BottomNavbarCubit()),
        BlocProvider(create: (context) => TransactionCubit()),
        BlocProvider(create: (context) => ProfileCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const BottomNavScreen(),
      ),
    );
  }
}
