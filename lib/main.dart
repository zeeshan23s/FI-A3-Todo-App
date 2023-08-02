import 'packages_export.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider())
      ],
      child: MaterialApp(
        title: 'Todo Application',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            textTheme: TextTheme(
              headlineLarge: TextStyle(
                  fontSize: ScreenHelper.screenHeight(context) * 0.028,
                  fontFamily: GoogleFonts.poppins().fontFamily),
              headlineMedium: TextStyle(
                  fontSize: ScreenHelper.screenHeight(context) * 0.024,
                  fontFamily: GoogleFonts.poppins().fontFamily),
              bodyLarge: TextStyle(
                  fontSize: ScreenHelper.screenHeight(context) * 0.018,
                  fontFamily: GoogleFonts.poppins().fontFamily),
              bodyMedium: TextStyle(
                  fontSize: ScreenHelper.screenHeight(context) * 0.016,
                  fontFamily: GoogleFonts.poppins().fontFamily),
              bodySmall: TextStyle(
                  fontSize: ScreenHelper.screenHeight(context) * 0.014,
                  fontFamily: GoogleFonts.poppins().fontFamily),
            ),
            useMaterial3: true,
            primaryColor: secondaryColor),
        home: Consumer<AuthProvider>(builder: (context, user, child) {
          return user.currentUser == null
              ? const TodoAuthScreen()
              : user.currentUser!.emailVerified
                  ? const DummyScreen()
                  : const TodoEmailVerificationScreen();
        }),
      ),
    );
  }
}
