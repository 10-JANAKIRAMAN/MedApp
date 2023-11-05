import 'package:firedart/firedart.dart';
import 'package:flutter/material.dart';
import 'package:med_app/pages/hospit.dart';
import 'package:med_app/pages/splash.dart';
import 'package:med_app/preferences_store.dart';
import 'package:provider/provider.dart';
import 'auth/authen.dart';
import 'pages/login_page.dart';
import 'pages/home_page.dart';
import 'pages/register_page.dart';

const apiKey = 'AIzaSyCCmubJoSdLnrxQSIh5zIneCWyWxpAUULA';
const projectId = 'medical-data-9a44b';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseAuth.initialize(apiKey, await PreferencesStore.create());

  Firestore.initialize(projectId);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String dd = "";
  @override
  void initState() {
    //check();
    //fd.FirebaseAuth.initialize(apiKey, VolatileStore());
    //fd.Firestore.initialize(projectId); // Firestore reuses the auth client
    DateTime de = DateTime.now();
    dd = de.toString().substring(0, 10);
    super.initState();
    //check();
  }

  // ignore: annotate_overrides
  void dispose() {
    super.dispose();
  }

  final routes = <String, WidgetBuilder>{
    LoginPage.tag: (context) => const LoginPage(),
    HomePage.tag: (context) => HomePage(
          '',
          date: "",
        ),
    RegisterPage.tag: (context) => const RegisterPage(),
    HospitalList.tag: (context) => const HospitalList(),
  };

  @override
  Widget build(BuildContext context) {
    //check();
    return MultiProvider(
      providers: [
        Provider<AuthenticationProvider>(
          create: (_) => AuthenticationProvider(
            FirebaseAuth.instance as FirebaseAuth,
          ),
        ),
        /*StreamProvider(
          create: (context) =>
              context.read<AuthenticationProvider>().authState as dynamic,
          initialData: null,
        )*/
      ],
      child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: MaterialApp(
            title: 'MED APP',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primaryColor: Colors.lightBlue,
              fontFamily: 'Nunito',
            ),
            home: const Authenticate(),
            routes: routes,
          )),
    );
  }
}

class Authenticate extends StatelessWidget {
  const Authenticate({super.key});

  @override
  Widget build(BuildContext context) {
    var firebaseUser = FirebaseAuth.instance.isSignedIn;
    // FirebaseAuth.instance.context.watch<User>();

    // ignore: unnecessary_null_comparison
    if (firebaseUser) {
      return const SplashScreen();
    }
    return const LoginPage();
  }
}
