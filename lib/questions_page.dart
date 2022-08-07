import 'package:flutter/material.dart';
import 'package:where_is_efi/constants.dart';

class QuestionPage extends StatelessWidget {
  const QuestionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: bgGradient),
      child: Center(
          child: Row(
        children: [
          Expanded(child: Container(), flex: 2),
          Expanded(
            flex: 4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Opacity(
                  opacity: 0.7,
                  child: Text(
                    'שאלה 5 מתוך 10',
                    textScaleFactor: 1.5,
                    style: TextStyle(fontWeight: FontWeight.normal),
                  ),
                ),
                const Text(
                  'איפה נמצאת הצפרדע?',
                  textScaleFactor: 3,
                  textAlign: TextAlign.right,
                  textDirection: TextDirection.rtl,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 90),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    SizedBox(
                      width: 100,
                      child: TextField(
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 60,
                        ),
                      ),
                    ),
                    SizedBox(width: 50),
                    SizedBox(
                      width: 100,
                      child: TextField(
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 60),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 90),
                Center(
                  child: SizedBox(
                    width: 500,
                    height: 60, // specific value
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: secondary,
                        shape: RoundedRectangleBorder(
                          borderRadius: defaultBorderRadius,
                        ),
                      ),
                      onPressed: () {},
                      child: Text('Let\'s Play',
                          style: TextStyle(
                              color: bgColor1,
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(flex: 2, child: Container()),
        ],
      )),
    );
  }
}
