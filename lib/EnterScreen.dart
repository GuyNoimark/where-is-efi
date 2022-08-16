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
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text(
              'Elsewhere',
              textScaleFactor: 10,
            ),
            SizedBox(
                height: 200, child: Image.asset('assets/magnifying-glass.png')),
            Button(
              text: "Let's Begin",
              nextScreen: NameScreen(),
              onTap: () {},
            )
          ],
        )),
        decoration: BoxDecoration(gradient: bgGradient));
  }
}
