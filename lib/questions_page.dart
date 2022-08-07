import 'package:flutter/material.dart';
import 'package:where_is_efi/constants.dart';

class QuestionPage extends StatelessWidget {
  const QuestionPage({
    Key? key,
    required this.questionNumber,
    required this.numberOfQuestions,
    required this.question,
    required this.answer,
  }) : super(key: key);

  final int questionNumber;
  final int numberOfQuestions;
  final String question;
  final String answer;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: bgGradient),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Center(
              child: Row(
            children: [
              Expanded(child: Container(), flex: 2),
              Expanded(
                flex: 4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Opacity(
                      opacity: 0.7,
                      child: Text(
                        'שאלה $questionNumber מתוך 10',
                        textScaleFactor: 1.5,
                        style: TextStyle(fontWeight: FontWeight.normal),
                      ),
                    ),
                    Text(
                      question,
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
                            readOnly: true,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 60),
                            decoration: InputDecoration(hintText: 'A'),
                          ),
                        ),
                        SizedBox(width: 35),
                        SizedBox(
                          width: 100,
                          child: TextField(
                            readOnly: true,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 60),
                            decoration: InputDecoration(hintText: '5'),
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
                          onPressed: () {
                            print(answer);
                          },
                          child: Text('בדיקה',
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
          Keyboard(
              keys: List.generate(
                  10, (index) => TextKey(text: index.toString()))),
        ],
      ),
    );
  }
}

class TextKey extends StatelessWidget {
  const TextKey({
    Key? key,
    required this.text,
    // required this.onTextInput,
  }) : super(key: key);

  final String text;
  // final ValueSetter<String> onTextInput;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 1,
        child: SizedBox(
          height: 100,
          child: TextButton(
            onPressed: () {},
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ));
  }
}

class Keyboard extends StatelessWidget {
  const Keyboard({
    Key? key,
    required this.keys,
    // required this.onTextInput,
  }) : super(key: key);

  final List<TextKey> keys;
  // final ValueSetter<String> onTextInput;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: secondary,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: keys,
      ),
    );
  }
}
