import 'package:flutter/material.dart';
import 'package:where_is_efi/constants.dart';

class QuestionPage extends StatelessWidget {
  const QuestionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text(
              'Elsewhere',
              textScaleFactor: 10,
            ),
            SizedBox(
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
            )
          ],
        )),
        decoration: BoxDecoration(gradient: bgGradient));
  }
}
