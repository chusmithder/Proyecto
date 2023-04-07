import 'package:flutter/material.dart';
import 'package:revdiet/screens/1_signin_screen.dart';
import 'package:revdiet/screens/2_signup_screen.dart';

void main(List<String> args) async {
  // Utilizado para las notificaciones, comprueba que esté todo inicializado
  // WidgetsFlutterBinding.ensureInitialized();
  // Inicializamos las configuraciones iniciales de las notificaciones
  // await NotificationProvider.notificationProvider.setup();

  //ejecutar la notificacion a cierta hora
  // DateTime yourTime = DateTime.now().add(Duration( minutes: 1));
  // VoidCallback yourAction =() {
  //   print('sadasadslkasdjladskjadslkadsjadslkjddads');
  // };
  // Timer(yourTime.difference(DateTime.now()), yourAction);

  runApp(const RevDiet());
}

class RevDiet extends StatelessWidget{
  const RevDiet({super.key});
  
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SignInScreen(),
    );
  }
}