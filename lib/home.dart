import 'dart:developer';

import 'package:crud_project/data/model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // fetchData();
    super.initState();
  }

  Future<List<Welcome>> getPostApi() async {
    final data = await fetchData();
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Get APi"),
        ),
        body: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                  future: getPostApi(),
                  builder: (context, futuredATA) {
                    if (!futuredATA.hasData) {
                      return Text('Loading');
                    } else if (futuredATA.hasData) {
                      return InkWell(
                        child: ListView.builder(
                          itemCount: futuredATA.data?.length ?? 0,
                          itemBuilder: (context, index) {
                            final item = futuredATA.data![index];

                            return Card(
                              elevation: 4,
                              margin: const EdgeInsets.all(10),
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.title.toString(),
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      "ID: ${item.id.toString()}",
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      "Body: ${item.body.toString()}",
                                      style: const TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      "User ID: ${item.userId.toString()}",
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.blueAccent,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    } else {
                      return Text('Some error ');
                    }
                  }),
            )
          ],
        ));
  }

  Welcome? welcome;
  List<Welcome> userList = [];
  Future<List<Welcome>> fetchData() async {
    userList.clear();
    try {
      Dio dio = Dio();
      final response =
          await dio.get("https://jsonplaceholder.typicode.com/posts");
      for (var item in response.data) {
        userList.add(Welcome(
            body: item['body'],
            id: item['id'],
            title: item['title'],
            userId: item['userId']));
      }
      return userList ?? [];
    } catch (e) {
      log(e.toString());
    }
    return userList ?? [];
  }
}
