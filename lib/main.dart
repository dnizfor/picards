import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:picards/navigation.dart';
import 'package:picards/providers/language_provider.dart';
import 'package:picards/screens/network_error_screen.dart';
import 'package:picards/screens/onboarding_screen.dart';
import 'package:picards/services/database_service.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Color(0xFF121212),
      systemNavigationBarColor: Color(0xFF121212),
    ),
  );
  await DatabaseService.initializeDatabase();
  final prefs = await SharedPreferences.getInstance();
  final bool showHome = prefs.getBool('showHome') ?? false;
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LanguageProvider()),
      ],
      child: Main(showHome: showHome),
    ),
  );
}

class Main extends StatefulWidget {
  const Main({super.key, required this.showHome});
  final bool showHome;

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  // This widget is the root of your application.
  bool isConnected = false;

  @override
  void initState() {
    super.initState();

    checkConnectivity();

    if (widget.showHome) {
      Provider.of<LanguageProvider>(
        context,
        listen: false,
      ).initializeLanguageData();
    }
  }

  Future<bool> checkConnectivity() async {
    List<ConnectivityResult> connectivityResult = await Connectivity()
        .checkConnectivity();
    bool networkIsConnected = !connectivityResult.contains(
      ConnectivityResult.none,
    );
    setState(() {
      isConnected = networkIsConnected;
    });
    return networkIsConnected;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFF121212),
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFF121212),
          surfaceTintColor: Color(0xFF121212),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: Color(0xFF2979FF)),
          ),
        ),
        colorScheme: ColorScheme.dark(
          primary: Color(0xFF2979FF),
          error: Color(0XFFE53935),
          tertiary: Color(0xFF4CAF50),
          surface: Color(0xFF1E1E1E),
          shadow: Color(0xFF121212),
        ),
      ),
      home: !isConnected
          ? NetworkErrorScreen()
          : widget.showHome
          ? Navigation()
          : OnboardingScreen(),
    );
  }
}
