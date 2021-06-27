import 'package:calculator_raro/pages/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:calculator_raro/shared/themes/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final options = [
    "AC",
    "C",
    "%",
    "/",
    "7",
    "8",
    "9",
    "*",
    "4",
    "5",
    "6",
    "-",
    "1",
    "2",
    "3",
    "+",
    "0",
    ".",
    "=",
  ]; // static goes to memory global

  var operation = "";
  var result = "";

  CalcController calculator = CalcController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: true,
        bottom: true,
        minimum: EdgeInsets.only(bottom: 16),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: AppColors.darkGrey,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black87,
                                  offset: Offset(-1, -1),
                                  blurRadius: 2,
                                  spreadRadius: 1)
                            ]),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        reverse: true,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, right: 8.0, top: 16, bottom: 8),
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: Text(
                              operation,
                              textAlign: TextAlign.right,
                              style: GoogleFonts.prompt(
                                height: 1.1,
                                fontSize: 48,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: StaggeredGridView.countBuilder(
                  padding:
                      EdgeInsets.only(top: 8, right: 16, left: 16, bottom: 16),
                  crossAxisCount: 4,
                  itemCount: 19,
                  itemBuilder: (BuildContext context, int index) {
                    var tileColor;

                    switch (index) {
                      case 18:
                        tileColor = AppColors.purple;
                        break;
                      case 0:
                        tileColor = AppColors.orange;
                        break;
                      case 1:
                        tileColor = AppColors.darkPurple;
                        break;
                      case 2:
                        tileColor = AppColors.darkPurple;
                        break;
                      case 3:
                        tileColor = AppColors.lightDarkPurple;
                        break;
                      case 7:
                        tileColor = AppColors.lightDarkPurple;
                        break;
                      case 11:
                        tileColor = AppColors.lightDarkPurple;
                        break;
                      case 15:
                        tileColor = AppColors.lightDarkPurple;
                        break;
                      default:
                        tileColor = AppColors.darkBackground;
                    }

                    return InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () {
                        final op = options[index];
                        if (op == "C") {
                          if (operation != '') {
                            operation = operation.replaceFirst(
                                operation[operation.length - 1], '');
                          }
                        } else if (op == "AC") {
                          operation = "";
                        } else if (op == "=") {
                          operation = calculator.calculator(operation);
                        } else {
                          operation += options[index];
                        }

                        setState(() {});
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Ink(
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black87,
                                    offset: Offset(1, 1),
                                    blurRadius: 2,
                                    spreadRadius: 1)
                              ],
                              color: tileColor,
                            ),
                            child: Center(
                              child: Text(options[index],
                                  style: GoogleFonts.prompt(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w400,
                                  )),
                            )),
                      ),
                    );
                  },
                  staggeredTileBuilder: (int index) {
                    if (index == 0) {
                      return new StaggeredTile.count(1, 1);
                    } else if (index == 18) {
                      return new StaggeredTile.count(2, 1);
                    } else {
                      return new StaggeredTile.count(1, 1);
                    }
                  },
                  mainAxisSpacing: 4.0,
                  crossAxisSpacing: 4.0,
                ),
              ),
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
