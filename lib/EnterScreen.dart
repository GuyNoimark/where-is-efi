import 'package:where_is_efi/constants.dart';
import 'package:flutter/material.dart';
import 'package:where_is_efi/NameScreen.dart';

class EnterScreen extends StatefulWidget {
  const EnterScreen({Key? key}) : super(key: key);

  @override
  State<EnterScreen> createState() => _EnterScreenState();
}

class _EnterScreenState extends State<EnterScreen> {
  bool isPressed = false;

  Image buttonIdle = Image.asset('assets/new_design/mat/start_Button_01.png');
  Image buttonPressed =
      Image.asset('assets/new_design/mat/start_Button_02.png');

  @override
  Widget build(final BuildContext context) {
    questions.shuffle();

    return Container(
        decoration: BoxDecoration(
          image: const DecorationImage(
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
              '?איפה אפי',
              textScaleFactor: 10,
              style: TextStyle(
                fontFamily: 'Albatros',
                shadows: <Shadow>[
                  Shadow(
                    offset: Offset(5.0, 5.0),
                    blurRadius: 3.0,
                    color: Color.fromARGB(30, 0, 0, 0),
                  ),
                  Shadow(
                    offset: Offset(10.0, 10.0),
                    blurRadius: 3.0,
                    color: Color.fromARGB(30, 0, 0, 0),
                  ),
                  Shadow(
                    offset: Offset(15.0, 15.0),
                    blurRadius: 3.0,
                    color: Color.fromARGB(30, 0, 0, 0),
                  ),
                  Shadow(
                    offset: Offset(20.0, 20.0),
                    blurRadius: 3.0,
                    color: Color.fromARGB(30, 0, 0, 0),
                  ),
                ],
              ),
            ),
            GestureDetector(
              child: SizedBox(
                width: 400,
                height: 400,
                child: !isPressed ? buttonIdle : buttonPressed,
              ),
              onTapDown: (tapDownDetails) => setState(() => isPressed = true),
              onTapCancel: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (final BuildContext context) => const Scaffold(
                              body: NameScreen(),
                            )));
              },
              onTap: () {
                setState(() => isPressed = true);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (final BuildContext context) => const Scaffold(
                              body: NameScreen(),
                            )));
              },
            ),
          ],
        )));
  }
}
