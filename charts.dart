import 'package:fl_chart/fl_chart.dart';
import 'package:cryptoinvest/profilePage.dart';
import 'package:cryptoinvest/settingsPage.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:intl/intl.dart';

import 'home_page.dart';

class charts extends StatelessWidget{
  var currency_name=TextEditingController();
  var currency_price;
  final List<Color>gradientColors=[
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  var say1;
   charts({
    Key? key,required this.say1,

  }):super(key: key);

  @override
  Widget build(BuildContext context) {
    if(say1==1){
      currency_name.text="BTC/USD";
      currency_price=19674;
    }
    else if(say1==2){
      currency_name.text="ETH/USD";
      currency_price=1417;
    }
    else if(say1==3){
      currency_name.text="BNB/USD";
      currency_price=278;
    }
    else if(say1==4){
      currency_name.text="USDT/TRY";
      currency_price=18.50;
    }
    else if(say1==5){
      currency_name.text="BUSD/TRY";
      currency_price=18.30;
    }


    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Charts"),
        backgroundColor: Color.fromRGBO(37, 41, 76, 1.0),
        foregroundColor: Colors.white,
      ),
        bottomNavigationBar: Container(color: Color.fromRGBO(37, 41, 76, 1.0),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 15.0),
            child: GNav(gap: 8,selectedIndex: 1,
                backgroundColor: Color.fromRGBO(37, 41, 76, 1.0),color: Colors.white,activeColor: Colors.white,tabBackgroundColor: Color.fromRGBO(30, 33, 64, 1.0),
                padding: EdgeInsets.all(16),
                tabs: [
                  GButton(icon: Icons.home,text: "Home",onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>home_page()));
                  },),
                  GButton(icon: FontAwesomeIcons.chartLine,text: "Chart",onPressed: (){

                  },),
                  GButton(icon: Icons.settings,text: "Settings",onPressed: (){
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context){
                      return SettingsPage();
                    }),(route)=>false);
                  },),
                  GButton(icon: Icons.account_circle,text: "Profile",onPressed:(){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfilePage()));
                  }),
                ]),
          ),
        ),
      body: Container(width: double.infinity,
        color: Color.fromRGBO(30, 33, 64, 1.0),
        child: Column(
          children: [
            Padding(padding: EdgeInsets.symmetric(vertical: 10,horizontal: 56),child: Container(
              decoration: BoxDecoration(

                borderRadius: BorderRadius.circular(10.0)

              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10,horizontal: 36),child: Text("Start Trading With Crypto Invest",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,

                ),textAlign: TextAlign.center,
              ),
              ),
            )),
            Padding(padding: EdgeInsets.fromLTRB(36,10,36,0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0),topRight: Radius.circular(15.0)),
                color: Color.fromRGBO(37, 41, 76, 1.0)
              ),
              child: Column(
                children: [
                  LineChart(
                      LineChartData(
                          titlesData: FlTitlesData(
                            topTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 22,
                              getTextStyles: (value)=>const TextStyle(
                                color: Colors.white,
                                fontSize: 16
                              ),
                              getTitles: (value){
                                switch(value.toInt()){
                                  case 2: return 'MAR';
                                  case 5:return 'JUN';
                                  case 8:return 'SEPT';
                                  default:return '';
                                }
                              }
                            ),
                            bottomTitles: SideTitles(
                              showTitles: false,
                              reservedSize: 22,
                              getTextStyles: (value)=>const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            leftTitles: SideTitles(
                              showTitles: false,
                              reservedSize: 22,
                              getTextStyles: (value)=>const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),

                          ),
                          minX: 0,
                          maxX: 11,
                          minY: 0,
                          maxY: 6,
                          gridData: FlGridData(
                              show: false,
                              getDrawingHorizontalLine: (value){
                                return FlLine(
                                    color:const Color(0xff37434d),
                                    strokeWidth: 1
                                );
                              },
                              drawVerticalLine: true,
                              getDrawingVerticalLine: (value){
                                return FlLine(
                                  color: const Color(0xff37434d),
                                  strokeWidth: 1,
                                );
                              }
                          ),
                          borderData: FlBorderData(
                              show: false,
                              border: Border.all(color: const Color(0xff37434d),width: 1)
                          ),
                          lineBarsData: [
                            LineChartBarData(
                              spots: [
                                FlSpot(0, 3),
                                FlSpot(2.6, 2),
                                FlSpot(4.9, 5),
                                FlSpot(6.8, 2.5),
                                FlSpot(8, 4),
                                FlSpot(9.5, 3),
                                FlSpot(11, 4),

                              ],

                              dotData: FlDotData(show: true),
                              isCurved: true,
                              colors: gradientColors,
                              barWidth: 5,
                              belowBarData: BarAreaData(
                                  show: true,
                                  colors: gradientColors.map((color) => color.withOpacity(0.3))
                                      .toList()
                              ),
                            )
                          ]

                      )
                  ),
                ],
              )
            )
            ),
            Padding(padding: EdgeInsets.symmetric(vertical: 0,horizontal: 54),child: Container(width: double.infinity,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15,horizontal: 16),child: Column(
                children: [
                  Align(alignment: Alignment.centerLeft,child: TextField(enabled: false,
                    controller: currency_name,
                    decoration: InputDecoration(border: InputBorder.none,),
                  ),),
                  Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                  Align(alignment: Alignment.centerLeft,child: Text(NumberFormat.simpleCurrency(locale: "en_US",decimalDigits: 2).format(currency_price),
                  style: TextStyle(
                    fontSize: 25
                  ),
                  ),)
                ],
              ),
              ),
              decoration: BoxDecoration(
                  color: Colors.white,
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15.0),bottomRight: Radius.circular(15.0))
              ),
            ),),
            Padding(padding: EdgeInsets.symmetric(vertical: 10,horizontal: 36),child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(padding: EdgeInsets.symmetric(horizontal: 10),child:
                ElevatedButton(
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                    backgroundColor: MaterialStateProperty.all(Color.fromRGBO(31, 183, 142, 1.0))
                  ),
                  child: Text("BUY/LONG"),
                  onPressed: null,
                ),),
                Padding(padding: EdgeInsets.symmetric(horizontal: 10),child:
                ElevatedButton(
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                      backgroundColor: MaterialStateProperty.all(Color.fromRGBO(255, 91, 118, 1.0))
                  ),
                  child: Text("SELL/SHORT"),
                  onPressed: null,
                ),),
              ],
            ),)
          ],
        ),
      )
    );
  }
}