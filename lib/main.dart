import 'dart:math';
import 'dart:ui';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: OurAppMainPage(),
    );
  }
}

class OurAppMainPage extends StatefulWidget {
  OurAppMainPage({Key? key}) : super(key: key);

  @override
  _OurAppMainPageState createState() => _OurAppMainPageState();
}

class _OurAppMainPageState extends State<OurAppMainPage> {
  PageController pageController = new PageController(initialPage: 0);

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Stack(
              children: [
                  Container(
                    height: double.infinity,
                    color: Colors.white12,
                    width: 200000,
                    child: Image.asset("assets/bg.png", fit: BoxFit.fitHeight),
                ),
                ClipRRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 7.0, sigmaY: 7.0),
                      child: Container(
                        height: double.infinity,
                        width: double.infinity,
                      ),
                    )
                ),
                Center(
                    child: Column(
                        children: [
                          _TopBar(pageController: pageController,),
                          Expanded(
                            child: PageView(
                              physics: NeverScrollableScrollPhysics(),
                              controller: this.pageController,
                              children: [
                                PlayScreen(),
                              ],),
                          ),
                        ]
                    )
                )
              ]),
        )
    );
  }
}

class _TopBar extends StatelessWidget {
  final PageController pageController;

  const _TopBar({
    Key? key,
    required this.pageController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
          Container(
              width: double.infinity,
              color: Colors.black45.withOpacity(0.4),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: ImageIcon(AssetImage("assets/setting_icon.png"), size: 70,)
          ),

          Container(
              child: Row( //1
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: (){},
                    icon: Image.asset("assets/setting_icon.png"),
                    iconSize: 70,
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: (){},
                    icon: Image.asset('assets/message_icon.png'),
                    iconSize: 70,),
                  IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: (){
                      this.pageController.animateToPage(0, duration: Duration(seconds: 1), curve: Curves.ease);
                    },
                    icon: Image.asset("assets/home_icon.png",),
                    iconSize: 80,
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: (){},
                    icon: Image.asset("assets/top_icon.png"),
                    iconSize: 70,
                  ),
                  //ImageIcon(AssetImage("assets/coin_icon.png"), color: null, size: 50,),
                  Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2)
                      ),
                      child: Text("\$12,1425", style: TextStyle(color: Colors.white, fontSize: 22),)
                  )
                ],)
          )
        ]);
  }
}

class _BattomBar extends StatelessWidget {
  const _BattomBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.4),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row( //2
          mainAxisAlignment: MainAxisAlignment.center,
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //IconButton(onPressed: (){}, icon: Icon(CupertinoIcons.question, size: 40,)),

          ]),
    );
  }
}

class PlayScreen extends StatefulWidget {
  const PlayScreen({Key? key}) : super(key: key);

  @override
  _PlayScreenState createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen> {

  @override
  void initState() {
    this.refreshing();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
        width: double.infinity,
        height: double.infinity,
        margin: EdgeInsets.only(left: 20),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                  height: size.height * 0.7,
                  width: size.width * 0.4,
                  decoration: BoxDecoration(
                      color: Color(0xff232d37).withOpacity(0.67),
                      borderRadius: BorderRadius.circular(20)
                  ),
                  margin: EdgeInsets.all(7),
                  padding: EdgeInsets.only(top: 10),
                  child: SingleChildScrollView(
                      child: Column(
                        children: [
                          _Stock("Alpha"),
                          _Stock("coin cosine"),
                          _Stock("부광 코인"),
                        ],)
                  )
              ),
              Container(
                  height: size.height * 0.7,
                  width: size.width * 0.4,
                  decoration: BoxDecoration(
                      color: Color(0xff232d37).withOpacity(0.67),
                      borderRadius: BorderRadius.circular(20)
                  ),
                  margin: EdgeInsets.all(7),
                  padding: EdgeInsets.all(20),
                  child: LineChart(
                    mainData(),
                  )
              )
            ])
    );
  }

  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  List<FlSpot> spots = [];

  Future<void> refreshing() async {
    setState(() {
      spots = [
        FlSpot(0, Random().nextInt(5).toDouble()),
        FlSpot(2.6, Random().nextInt(5).toDouble()),
        FlSpot(4.9, Random().nextInt(5).toDouble()),
        FlSpot(6.8, Random().nextInt(5).toDouble()),
        FlSpot(8, Random().nextInt(5).toDouble()),
        FlSpot(9.5, Random().nextInt(5).toDouble()),
        FlSpot(11, Random().nextInt(5).toDouble()),
      ];
    });
    Future.delayed(Duration(milliseconds: 700), () async {
      refreshing();
      print("again");
    });
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: SideTitles(showTitles: false),
        topTitles: SideTitles(showTitles: false),
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          interval: 1,
          getTextStyles: (context, value) => const TextStyle(
              color: Colors.white70,
              fontWeight: FontWeight.bold,
              fontSize: 16),
          getTitles: (value) {
            switch (value.toInt()) {
              case 2:
                return '20분 전';
              case 5:
                return '10분 전';
              case 8:
                return '5분 전';
            }
            return '';
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          interval: 1,
          getTextStyles: (context, value) => const TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return '10k';
              case 3:
                return '30k';
              case 5:
                return '50k';
            }
            return '';
          },
          reservedSize: 32,
          margin: 12,
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: spots,
          isCurved: true,
          colors: gradientColors,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors:
            gradientColors.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ],
    );
  }
}

class _Stock extends StatefulWidget {
  const _Stock(this.name, {Key? key}) : super(key: key);

  final String name;

  @override
  _StockState createState() => _StockState();
}

class _StockState extends State<_Stock> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.lightBlueAccent),
            borderRadius: BorderRadius.circular(10)
        ),
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        padding: EdgeInsets.only(top: 15, bottom: 15, left: 15, right: 10),
        width: double.infinity,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.name,
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontWeight: FontWeight.bold,
                      fontSize: 23
                  )),
              Container(height: 10,),
              Row(
                children: [
                  ElevatedButton(onPressed: (){}, child: Text("구매")),
                  Container(width: 20,),
                  ElevatedButton(onPressed: (){}, child: Text("판매"), style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.redAccent)),),
                ],
              )
            ])
    );
  }
}
