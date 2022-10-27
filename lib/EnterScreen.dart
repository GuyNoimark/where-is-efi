import 'package:where_is_efi/constants.dart';
import 'widgets/Button.dart';
import 'package:flutter/material.dart';
import 'package:where_is_efi/NameScreen.dart';

class EnterScreen extends StatefulWidget {
  const EnterScreen({Key? key}) : super(key: key);

  @override
  State<EnterScreen> createState() => _EnterScreenState();
}

class _EnterScreenState extends State<EnterScreen> {
  @override
  Widget build(final BuildContext context) {
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
            ),
            IconButton(
              icon: Image.asset('assets/new_design/mat/start_Button_01.png'),
              iconSize: 400,
              onPressed: () {
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
