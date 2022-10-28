import 'package:flutter/material.dart';
import 'package:where_is_efi/questions_page.dart';
import 'constants.dart';

class NameScreen extends StatefulWidget {
  const NameScreen({Key? key}) : super(key: key);

  @override
  State<NameScreen> createState() => _NameScreenState();
}

class _NameScreenState extends State<NameScreen> {
  final myController = TextEditingController();
  @override
  Widget build(final BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: const DecorationImage(
          fit: BoxFit.fill,
          opacity: 0.7,
          image:
              AssetImage('assets/new_design/mat/Eifo_Efi_01a_Background.png'),
        ),
        gradient: bgGradient,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "?מה שמך",
              textScaleFactor: 7,
              style: TextStyle(
                fontFamily: 'Albatros',
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              width: 500,
              height: 60,
              child: TextField(
                // obscureText: false,
                style: TextStyle(fontFamily: 'DancingScript', color: bgColor1),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(5)),
                  // labelStyle: TextStyle(color: bgColor1),
                  // labelText: 'שם',
                ),
                controller: myController,
                cursorColor: bgColor1,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            GestureDetector(
              child: SizedBox(
                width: 200,
                // height: 100,
                child: Image.asset(
                  'assets/new_design/mat/Continue_button_01.png',
                  fit: BoxFit.cover,
                ),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (final BuildContext context) => const Scaffold(
                              body: QuestionPage(),
                            )));
              },
            ),
          ],
        ),
      ),
    );
  }
}
