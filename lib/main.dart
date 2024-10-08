import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:stockapi/feature/bottomnavbar/bloc/navbar_bloc.dart';
import 'package:stockapi/feature/splash/splash.dart';
import 'package:stockapi/feature/stock/bloc/stock_bloc.dart';
import 'package:stockapi/feature/stock/repository/stock_repository.dart';
import 'package:stockapi/feature/stock/model/stock_model.dart';
import 'package:stockapi/feature/stock/model/symbolsearch.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(StockModelAdapter());
  Hive.registerAdapter(SymbolSearchModelAdapter());
  final watchlistBox = await Hive.openBox<StockModel>('watchlist');

  runApp( MyApp(watchlistBox: watchlistBox));
}

class MyApp extends StatelessWidget {
    final Box<StockModel> watchlistBox;

  const MyApp({super.key, required this.watchlistBox});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NavbarBloc(),
        ),
        BlocProvider(
          create: (context) => StockBloc(StockRepository(), watchlistBox),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
