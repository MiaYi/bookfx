import 'package:flutter/material.dart';

import 'package:bookfx/bookfx.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String data = '''''';
  EBookController eBookController = EBookController();
  BookController bookController = BookController();
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    rootBundle.loadString('assets/santi.txt').then((value) {
      setState(() {
        data = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          "翻页demo",
        ),
      ),
      body: data.isNotEmpty
          ? Column(
              children: [
                EBook(
                    maxWith: MediaQuery.of(context).size.width,
                    eBookController: eBookController,
                    bookController: bookController,
                    data: data,
                    fontSize: eBookController.fontSize,
                    padding: const EdgeInsetsDirectional.all(15),
                    maxHeight: MediaQuery.of(context).size.height -
                        MediaQuery.of(context).padding.top -
                        56 -
                        100),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          bookController.next();
                        },
                        child: Text("下一页")),
                    ElevatedButton(
                        onPressed: () {
                          bookController.last();
                        },
                        child: Text("上一页")),
                    ElevatedButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text("提示"),
                                  content: Container(
                                      height: 100,
                                      child: Column(
                                        children: [
                                          TextField(
                                            controller: textEditingController,
                                            textInputAction: TextInputAction.go,
                                            keyboardType: TextInputType.number,
                                          ),
                                          TextButton(
                                              onPressed: () {
                                                int index = int.parse(
                                                    textEditingController.text);
                                                bookController.goTo(index);
                                                Navigator.pop(context);
                                              },
                                              child: Text("确定"))
                                        ],
                                      )),
                                );
                              });
                        },
                        child: Text("跳转指定页")),
                  ],
                )
              ],
            )
          : const SizedBox(),
    );
  }
}