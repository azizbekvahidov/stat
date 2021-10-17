import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:statistic/bloc/category/category_bloc.dart';
import 'package:statistic/config/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: basicTheme(),
      themeMode: ThemeMode.light,
      title: '',
      home: MyHomePage(title: 'Statistic'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Timer? timers;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    timers = Timer.periodic(Duration(seconds: 5), (Timer t) {
      categoryBloc.fetchData();
    });
  }

  @override
  void dispose() {
    timers?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    categoryBloc.fetchData();
    var dWidth = MediaQuery.of(context).size.width;
    var dHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(
            horizontal: dHeight * 0.04, vertical: dWidth * 0.04),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [Color(0xff3A4484), Color(0xff182050)],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 4,
                  child: Container(
                    child: Stack(
                      children: [
                        Image.asset(
                          "assets/logo.png",
                          width: dWidth * 0.19,
                          height: dWidth * 0.19 * 0.322,
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset("assets/calendar.svg"),
                      Text(
                        "охирги 2 кун",
                        style: Theme.of(context).textTheme.headline4,
                      )
                    ],
                  ),
                )
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              height: dHeight - dHeight * 0.1 - dWidth * 0.25 * 0.322 - 20,
              child: StreamBuilder(
                  stream: categoryBloc.categoryList,
                  builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                    if (snapshot.hasData) {
                      List<dynamic>? data = snapshot.data;
                      data!.sort((a, b) => (b["count"]).compareTo(a["count"]));
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            for (var i = 0; i < data.length; i++)
                              AnimatedSwitcher(
                                duration: const Duration(seconds: 3),
                                transitionBuilder: (Widget child,
                                        Animation<double> animation) =>
                                    ScaleTransition(
                                  child: child,
                                  scale: animation,
                                ),
                                child: Column(
                                  key: ValueKey(i),
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            "${data[i]["name"]}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline1!
                                                .copyWith(
                                                    fontSize: dHeight * 0.05),
                                          ),
                                          flex: 4,
                                        ),
                                        Expanded(
                                          child: Text(
                                            "${data[i]["count"]}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline1!
                                                .copyWith(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: dHeight * 0.05),
                                          ),
                                          flex: 1,
                                        ),
                                      ],
                                    ),
                                    Divider(
                                      color: Color.fromRGBO(255, 255, 255, 0.2),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Text(snapshot.error.toString());
                    }
                    return Center(
                        child: CircularProgressIndicator(
                      color: Theme.of(context).primaryColor,
                    ));
                  }),
            )
          ],
        ),
      ),
    );
  }
}
