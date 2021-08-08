import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_paper/models/news.dart';
import 'package:news_paper/screens/news_details.dart';
import 'package:news_paper/services/news_service.dart';

class NewsPaperListScreen extends StatefulWidget {
  // const NewsPaperListScreen({Key? key}) : super(key: key);

  @override
  _NewsPaperListScreenState createState() => _NewsPaperListScreenState();
}

class _NewsPaperListScreenState extends State<NewsPaperListScreen> {
  final NewsServiceBase newsService = NewsService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        // elevation: 0,
        title: Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
            "News Paper App",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: FutureBuilder<List<News>>(
        future: newsService.getAllNews(),
        builder: (context, AsyncSnapshot<List<News>> snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
            return Center(
              child: Text("Something went wrong!"),
            );
          }

          if (!snapshot.hasData)
            return Center(
              child: CircularProgressIndicator(),
            );
          List<News> news = snapshot.data!;
          return ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            itemCount: news.length,
            itemBuilder: (BuildContext context, index) {
              return ListTile(
                minVerticalPadding: 12,
                onTap: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => NewsDetailsScreen(
                        news: news[index],
                      ),
                    ),
                  );
                },
                leading: AspectRatio(
                  aspectRatio: 4 / 3,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      news[index].image == null
                          ? "https://i.stack.imgur.com/y9DpT.jpg"
                          : news[index].image!,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                //We are assuming that the title will not be null
                title: Text(
                  news[index].title!,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  news[index].description ?? "",
                  overflow: TextOverflow.ellipsis,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
