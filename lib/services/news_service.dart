import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';
import 'package:news_paper/models/news.dart';
import 'package:news_paper/utils/constants.dart';

abstract class NewsServiceBase {
  Future<List<News>> getAllNews();
}

//For Testing Purpose
class NewsServiceMock implements NewsServiceBase {
  @override
  Future<List<News>> getAllNews() async {
    List<News> newsList = List.generate(
      25,
      (index) => News(
        title: 'Demo news title $index',
        description:
            'India announced on 19 April that it would inoculate people aged 18-45 starting 1 May under its ‘Liberalised and Accelerated Phase 3 Strategy’. The two vaccine manufacturers have been asked to supply 50 percent of their production to the federal government, with the remaining 50 percent to be handed over to the state authorities.\nIndia announced on 19 April that it would inoculate people aged \n 18-45 starting 1 May under its ‘Liberalised and Accelerated Phase 3 Strategy’. The two vaccine manufacturers have been asked to supply 50 percent of their production to the federal government, with the remaining 50 percent to be handed over to the state authorities.\nIndia announced on 19 April that it would inoculate people aged \n 18-45 starting 1 May under its ‘Liberalised and Accelerated Phase 3 Strategy’. The two vaccine manufacturers have been asked to supply 50 percent of their production to the federal government, with the remaining 50 percent to be handed over to the state authorities.\nIndia announced on 19 April that it would inoculate people aged \n 18-45 starting 1 May under its ‘Liberalised and Accelerated Phase 3 Strategy’. The two vaccine manufacturers have been asked to supply 50 percent of their production to the federal government, with the remaining 50 percent to be handed over to the state authorities.\nIndia announced on 19 April that it would inoculate people aged \n 18-45 starting 1 May under its ‘Liberalised and Accelerated Phase 3 Strategy’. The two vaccine manufacturers have been asked to supply 50 percent of their production to the federal government, with the remaining 50 percent to be handed over to the state authorities.\nIndia announced on 19 April that it would inoculate people aged \n 18-45 starting 1 May under its ‘Liberalised and Accelerated Phase 3 Strategy’. The two vaccine manufacturers have been asked to supply 50 percent of their production to the federal government, with the remaining 50 percent to be handed over to the state authorities.',
        image:
            'https://images.ctfassets.net/hrltx12pl8hq/3MbF54EhWUhsXunc5Keueb/60774fbbff86e6bf6776f1e17a8016b4/04-nature_721703848.jpg?fit=fill&w=480&h=270',
        author: "Dhrumil Pandya",
        category: 'General',
        country: 'IN',
        publishedAt: DateTime.now(),
      ),
    );
    await Future.delayed(Duration(seconds: 3));
    return newsList;
  }
}

//Actual Implementation
class NewsService implements NewsServiceBase {
  @override
  Future<List<News>> getAllNews() async {
    final Response response = await get(
      Uri.http(
        API_BASE_URL,
        'v1/news',
        {
          "access_key": dotenv.env['API_KEY'],
          "sources": "en",
        },
      ),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode != 200)
      throw HttpException("couldn't get response!");

    final mapResponse = jsonDecode(response.body);

    if (mapResponse['data'] == null || !(mapResponse['data'] is List))
      throw HttpException(
          "Invalid Response: No 'data' element found in response ");
    return (mapResponse['data'] as List)
        .map<News>((n) => News.fromJson(n))
        .toList();
  }
}
