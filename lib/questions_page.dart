import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:where_is_efi/constants.dart';
import 'package:where_is_efi/models/questions_model.dart';

import 'constants.dart';

class QuestionPage extends StatefulWidget {
  const QuestionPage({
    Key? key,
  }) : super(key: key);

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  // void showNumKeyboard(Keyboard keyboard) {}
  bool showNumKeyboard = false;
  bool showCharKeyboard = false;
  TextEditingController _numController = TextEditingController();
  TextEditingController _charController = TextEditingController();
  ButtonState buttonState = ButtonState.idle;
  int questionIndex = 0;

  bool checkAnswer() =>
      _charController.text + _numController.text ==
      questions[questionIndex].answer;

  @override
  Widget build(BuildContext context) {
    QuestionsData currentQuestion = questions[questionIndex];

    return Container(
      decoration: BoxDecoration(gradient: bgGradient),
      child: Stack(
        // fit: StackFit.expand,
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
                        'שאלה ${questionIndex} מתוך ${questions.length}',
                        textScaleFactor: 1.5,
                        style: TextStyle(fontWeight: FontWeight.normal),
                      ),
                    ),
                    Text(
                      currentQuestion.question,
                      textScaleFactor: 3,
                      textAlign: TextAlign.right,
                      textDirection: TextDirection.rtl,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 90),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 100,
                          child: TextField(
                            readOnly: true,
                            controller: _charController,
                            onTap: () => setState(() {
                              showCharKeyboard = true;
                              showNumKeyboard = false;
                            }),
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
                            controller: _numController,
                            onTap: () => setState(() {
                              showNumKeyboard = true;
                              showCharKeyboard = false;
                            }),
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
                        child: Container(),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(flex: 2, child: Container()),
            ],
          )),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 600),
            bottom: showNumKeyboard || showCharKeyboard ? 150 : 130,
            curve: Curves.easeInOutQuad,
            child: Center(
              child: SizedBox(
                width: 500,
                height: 60, // specific value
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          buttonState == ButtonState.idle
                              ? secondary
                              : buttonState == ButtonState.correct
                                  ? Colors.lightGreen
                                  : Colors.red)),
                  onPressed: () {
                    setState(() {
                      showNumKeyboard = false;
                      showCharKeyboard = false;
                      buttonState = checkAnswer()
                          ? ButtonState.correct
                          : ButtonState.wrong;
                    });
                    Future.delayed(
                        const Duration(seconds: 1),
                        () => setState(() => buttonState == ButtonState.correct
                            ? questionIndex++
                            : null));
                    Future.delayed(const Duration(seconds: 2), () {
                      //cool :)
                      setState(() {
                        buttonState = ButtonState.idle;
                      });
                    });

                    print(currentQuestion.answer +
                        ' | ' +
                        _charController.text +
                        _numController.text);
                  },
                  child: Text(
                      buttonState == ButtonState.idle
                          ? 'בדיקה'
                          : buttonState == ButtonState.correct
                              ? 'V'
                              : 'X',
                      style: TextStyle(
                          color: buttonState == ButtonState.idle
                              ? bgColor1
                              : secondary,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                ),
              ),
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 600),
            bottom: showNumKeyboard || showCharKeyboard ? 0 : -100,
            curve: Curves.easeInOutQuad,
            child: Keyboard(
                keys: List.generate(
                    10,
                    (index) => TextKey(
                          text: showNumKeyboard
                              ? (index + 1).toString()
                              : String.fromCharCode(index + 65),
                          onClick: (text) {
                            showNumKeyboard
                                ? _numController.text = text
                                : _charController.text = text;
                          },
                        ))),
          ),
        ],
      ),
    );
  }
}

enum ButtonState {
  idle,
  correct,
  wrong,
  // TODO: Add loading state
}

class TextKey extends StatelessWidget {
  const TextKey({
    Key? key,
    required this.text,
    required this.onClick,
    // required this.onTextInput,
  }) : super(key: key);

  final String text;
  final Function(String text) onClick;
  // final ValueSetter<String> onTextInput;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        onClick(text);
      },
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
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
    Size size = MediaQuery.of(context).size;
    double screenWidth = size.width;

    return SizedBox(
      height: 60,
      width: screenWidth,
      child: Container(
        decoration: BoxDecoration(
          color: secondary,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: keys,
        ),
      ),
    );
  }
}
