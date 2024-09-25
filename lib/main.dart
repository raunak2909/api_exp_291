import 'dart:convert';

import 'package:api_exp_291/data_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as httpClient;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();
    getQuotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: FutureBuilder<QuoteDataModel?>(
        future: getQuotes(),
        builder: (_, snapshot){
          if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error.toString()}'),
              );
            } else if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.quotes.length,
                  itemBuilder: (_, index) {
                    return ListTile(
                      title: Text(snapshot.data!.quotes[index].quote),
                      subtitle:
                          Text('- ${snapshot.data!.quotes[index].author}'),
                    );
                  });
            }

          return Container();
        },
      )
    );
  }


  ///mData != null ? mData!.quotes.isNotEmpty ? ListView.builder(
  //         itemCount: mData!.quotes.length,
  //           itemBuilder: (_, index){
  //           return ListTile(
  //             title: Text(mData!.quotes[index].quote),
  //             subtitle: Text('- ${mData!.quotes[index].author}'),
  //           );
  //       }) : Center(
  //         child: Text('No Quotes Found!!'),
  //       ) : Center(child: Text('Unable to load Quotes'),)

  Future<QuoteDataModel?> getQuotes() async{

    String url = "https://dummyjson.com/quotes";
    Uri uri = Uri.parse(url);

    httpClient.Response res = await httpClient.get(uri);

    ///exception handling
    if(res.statusCode==200){
      print("response body : ${res.body}");
      var resData = jsonDecode(res.body);
      return QuoteDataModel.fromJson(resData);
    } else {
      return null;
    }

  }
}
