import 'package:flutter/material.dart';
import 'package:examen/models/type_article.dart';
import 'package:examen/services/sqlDataBase.dart';

class AfficherArticleScreen extends StatefulWidget {
  const AfficherArticleScreen({super.key});

  @override
  _AfficherArticleScreenState createState() => _AfficherArticleScreenState();
}

class _AfficherArticleScreenState extends State<AfficherArticleScreen> {
  late Future<List<TypeArticle>> articles;

  @override
  void initState() {
    super.initState();
    articles = CruddataBase().getAllTypeArticles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liste des articles'),
        centerTitle: true,
        backgroundColor: Colors.green,
        leading: const Icon(Icons.menu),
        actions: [
          IconButton(onPressed: () {},
          icon: const Icon(Icons.search)),
          IconButton(onPressed: () {},
          icon: const Icon(Icons.more_vert)),
        ],
      ),
      body: FutureBuilder<List<TypeArticle>>(
        future: articles,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur : ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Aucun article trouvé'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final article = snapshot.data![index];
                return ListTile(
                  title: Text(article.nom),
                  subtitle: Text(article.description),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () async {
                      await CruddataBase().deleteTypeArticle(article.id!);
                      setState(() {
                        articles = CruddataBase().getAllTypeArticles();
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Article supprimé avec succès'))
                      );
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
