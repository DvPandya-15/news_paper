import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_paper/models/news.dart';

class NewsDetailsScreen extends StatelessWidget {
  const NewsDetailsScreen({required this.news});

  final News news;

  @override
  Widget build(BuildContext context) {
    TextStyle metaTextStyle =
        TextStyle(fontWeight: FontWeight.bold, fontSize: 17);
    return Scaffold(
      body: CustomScrollView(
        physics: ClampingScrollPhysics(),
        slivers: [
          SliverAppBar(
            pinned: true,
            centerTitle: true,
            expandedHeight: 300,
            floating: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  news.title!,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              background: Image.network(
                news.image == null
                    ? "https://i.stack.imgur.com/y9DpT.jpg"
                    : news.image!,
                fit: BoxFit.cover,
              ),
            ),
            backgroundColor: Colors.black87,
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                SizedBox(height: 20),
                Row(
                  children: [
                    Text(news.category ?? '', style: metaTextStyle),
                    Spacer(),
                    Text(news.author ?? "Dhrumil Pandya", style: metaTextStyle),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Text(DateFormat('dd MMMM, yyyy').format(news.publishedAt!),
                        style: metaTextStyle),
                    Spacer(),
                    Text(news.country ?? "India", style: metaTextStyle),
                  ],
                ),
                SizedBox(height: 15),
                Text(
                  news.description!,
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 15),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
