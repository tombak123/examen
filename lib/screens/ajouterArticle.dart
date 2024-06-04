import 'package:flutter/material.dart';
import 'package:examen/models/type_article.dart';
import 'package:examen/services/sqlDataBase.dart';

class AjouterArticleScreen extends StatelessWidget {
  final TextEditingController nomController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  AjouterArticleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouter un article'),
        centerTitle: true,
        backgroundColor: Colors.green,
        leading: Icon(Icons.menu),
        actions: [
          IconButton(onPressed: () {},
          icon: const Icon(Icons.search)),
          IconButton(onPressed: () {},
          icon: const Icon(Icons.more_vert)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: nomController,
              decoration: const InputDecoration(labelText: "Nom de l\'article"),
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration (labelText: "Description de l\'article"),
            ),
            SizedBox(
              height: 16,
            ),
            ElevatedButton(onPressed: () async {
              final nom = nomController.text;
              final description = descriptionController.text;
              if (nom.isNotEmpty && description.isNotEmpty) {
                final article = TypeArticle(nom: nom, description: description);
                await CruddataBase().insertTypeArticle(article);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Article ajouté avec succès')));
                  Navigator.pop(context, true);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Veuillez saisir les champs !')));
              }
            },
            child: Text("Ajouter un article"))
          ],
        ),
      ),
    );
  }
}