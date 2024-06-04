import 'package:flutter/material.dart';
import 'package:examen/models/type_article.dart';
import 'package:examen/services/sqlDataBase.dart';

class ModifierArticleScreen extends StatefulWidget {
  final int? articleId;
  const ModifierArticleScreen({this.articleId});

  @override
  State<ModifierArticleScreen> createState() => _ModifierArticleScreenState();
}

class _ModifierArticleScreenState extends State<ModifierArticleScreen> {
  final TextEditingController nomController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  Future<void> _loadArticleData() async {
    if (widget.articleId != null) {
      final article = await CruddataBase().getArticleWithId(widget.articleId!);
      if (article != null) {
        setState(() {
          nomController.text = article.nom;
          descriptionController.text = article.description;
        });
      }
    }
  } 

    @override
    Widget build(BuildContext context) {
      return Scaffold(
      appBar: AppBar(
        title: Text('Modifier un article'),
        centerTitle: true,
        backgroundColor: Colors.green,
        leading: Icon(Icons.menu),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
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
            ElevatedButton(
              onPressed: () async {
                final nom = nomController.text;
                final description = descriptionController.text;
                if (nom.isNotEmpty && description.isNotEmpty) {
                  final article = TypeArticle(id: widget.articleId, nom: nom, description: description);
                  await CruddataBase().updateTypeArticle(article);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Article mis à jour avec succès')));
                    Navigator.pop(context, true);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Veuillez remplir tous les champs !')));
                }
              },
            child: Text("Mettre à jour l\'article"),
            )
          ],
        ),
      ),
      );
    }
  }

