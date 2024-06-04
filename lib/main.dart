import 'package:flutter/material.dart';
import 'package:examen/screens/afficherArticle.dart';  // Importation du bon fichier pour l'écran principal
import 'package:examen/services/sqlDataBase.dart';  // Importation de la base de données pour initialiser

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CruddataBase().openDb();  // Initialisation de la base de données
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mon Application',
      theme: ThemeData(
        primarySwatch: Colors.green,  // Correspondre à la couleur verte utilisée dans les autres écrans
      ),
      home: const AfficherArticleScreen(),  // Utiliser l'écran d'affichage des articles comme écran principal
    );
  }
}
