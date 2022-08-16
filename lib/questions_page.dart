import 'dart:convert';

import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';
import 'package:neon_circular_timer/neon_circular_timer.dart';
import 'package:wheel_chooser/wheel_chooser.dart';
import 'package:where_is_efi/constants.dart';
import 'package:where_is_efi/models/questions_model.dart';
import 'package:where_is_efi/EnterScreen.dart';
import 'package:where_is_efi/widgets/Button.dart';
import 'package:where_is_efi/widgets/scoll_wheel.dart';
import 'globals.dart' as globals;
import 'constants.dart';
import 'package:http/http.dart' as http;

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
  final TextEditingController _numController = TextEditingController();
  final TextEditingController _charController = TextEditingController();
  final CountDownController _countDownController = CountDownController();

  ButtonState buttonState = ButtonState.idle;
  int questionIndex = 0;
  int score = 0;

  bool checkAnswer() =>
      _charController.text + _numController.text ==
      questions[questionIndex].answer;
  void gameOver() {
    //todo: call when timer is complete
    globals.playerScore = score;
  }

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
                      flex: 6,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              NeonCircularTimer(
                                onComplete: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (final BuildContext context) =>
                                            GameOverScreen(
                                                time: _countDownController
                                                    .getTimeInSeconds()),
                                      ));
                                },
                                // initialDuration: 60,
                                width: 90,
                                duration: 60,
                                controller: _countDownController,
                                isReverse: true,
                                neumorphicEffect: false,
                                innerFillGradient: LinearGradient(colors: [
                                  Colors.yellowAccent.shade200,
                                  Colors.orange
                                ]),
                                neonColor: secondary.withOpacity(0.1),
                                textFormat: TextFormat.SS,
                                // neonGradient: LinearGradient(colors: [
                                //   Colors.greenAccent.shade200,
                                //   Colors.blueAccent.shade400
                                // ]),
                                // innerFillColor: Colors.yellowAccent,
                                // neonColor: Colors.lightBlue,
                                // outerStrokeColor: Colors.amber,
                                isTimerTextShown: true,
                                isReverseAnimation: true,
                                textStyle: const TextStyle(fontSize: 30),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Opacity(
                                    opacity: 0.7,
                                    child: Text(
                                      'שאלה ${questionIndex + 1} מתוך ${questions.length}',
                                      textScaleFactor: 1.5,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ),
                                  AnimatedSwitcher(
                                    duration: const Duration(milliseconds: 400),
                                    switchInCurve: Curves.easeInOutQuad,
                                    // switchOutCurve: Curves.easeInOutQuad,
                                    transitionBuilder: (Widget child,
                                        Animation<double> animation) {
                                      return SlideTransition(
                                        child: child,
                                        position: Tween<Offset>(
                                                begin: const Offset(50, 0),
                                                end: const Offset(0.0, 0.0))
                                            .animate(animation),
                                      );
                                    },
                                    child: Text(
                                      currentQuestion.question,
                                      key: ValueKey<String>(
                                          currentQuestion.question),
                                      textScaleFactor: 3,
                                      textAlign: TextAlign.right,
                                      textDirection: TextDirection.rtl,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 90),
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              SizedBox(
                                height: 70,
                                width: 70,
                                child: Container(
                                    decoration: BoxDecoration(
                                  borderRadius: defaultBorderRadius,
                                  border:
                                      Border.all(color: secondary, width: 3),
                                )),
                              ),
                              SizedBox(
                                height: 100,
                                child: WheelChooser(
                                  onValueChanged: (s) => setState(() =>
                                      _charController.text = s.toString()),
                                  datas: List.generate(
                                      10,
                                      (index) =>
                                          String.fromCharCode(index + 65)),
                                  horizontal: true,
                                  itemSize: 60,
                                  selectTextStyle: const TextStyle(
                                    fontSize: 28,
                                  ),
                                  startPosition: 5,
                                  unSelectTextStyle: TextStyle(
                                      fontSize: 25,
                                      color: Colors.white.withOpacity(0.5)),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Stack(alignment: Alignment.center, children: [
                            SizedBox(
                              height: 70,
                              width: 70,
                              child: Container(
                                  decoration: BoxDecoration(
                                borderRadius: defaultBorderRadius,
                                border: Border.all(color: secondary, width: 3),
                              )),
                            ),
                            SizedBox(
                              height: 100,
                              child: WheelChooser.integer(
                                onValueChanged: (s) => setState(
                                    () => _numController.text = s.toString()),
                                maxValue: 10,
                                minValue: 1,
                                initValue: 5,
                                horizontal: true,
                                itemSize: 60,
                                selectTextStyle: const TextStyle(
                                  fontSize: 28,
                                ),
                                unSelectTextStyle: TextStyle(
                                    fontSize: 25,
                                    color: Colors.white.withOpacity(0.5)),
                              ),
                            ),
                          ]),
                          const SizedBox(height: 90),
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
                ),
              ),
              AnimatedPositioned(
                duration: const Duration(milliseconds: 600),
                bottom: showNumKeyboard || showCharKeyboard ? 120 : 90,
                curve: Curves.easeInOutQuad,
                child: Center(
                  child: SizedBox(
                    width: 700,
                    height: 60, // specific value
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              buttonState == ButtonState.wrong
                                  ? Colors.red
                                  : buttonState == ButtonState.correct
                                      ? Colors.lightGreen
                                      : secondary)),
                      onPressed: () {
                        print('button pressed');
                        setState(() {
                          buttonState = ButtonState.loading;
                        });
                        Future.delayed(
                            const Duration(seconds: 1),
                            () => {
                                  print('button set state'),
                                  setState(() {
                                    showNumKeyboard = false;
                                    showCharKeyboard = false;
                                    buttonState = checkAnswer()
                                        ? ButtonState.correct
                                        : ButtonState.wrong;
                                  })
                                });

                        Future.delayed(
                            const Duration(milliseconds: 1500),
                            () => setState(() => {
                                  print('question++'),
                                  buttonState == ButtonState.correct
                                      ? score += 100
                                      : null,
                                  questionIndex + 1 == questions.length
                                      ? Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (final BuildContext
                                                      context) =>
                                                  GameOverScreen(
                                                      time: _countDownController
                                                          .getTimeInSeconds())))
                                      : questionIndex++,
                                  _numController.text = '',
                                  _charController.text = ''
                                }));
                        Future.delayed(const Duration(milliseconds: 2000), () {
                          print('button set idle');
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
                              : buttonState == ButtonState.loading
                                  ? '....'
                                  : buttonState == ButtonState.correct
                                      ? 'V'
                                      : 'X',
                          style: TextStyle(
                              color: buttonState == ButtonState.idle ||
                                      buttonState == ButtonState.loading
                                  ? bgColor1
                                  : secondary,
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              ),
              // AnimatedPositioned(
              //   duration: const Duration(milliseconds: 600),
              //   bottom: showNumKeyboard || showCharKeyboard ? 0 : -100,
              //   curve: Curves.easeInOutQuad,
              //   child: Keyboard(
              //       keys: List.generate(
              //           10,
              //           (index) => TextKey(
              //                 text: showNumKeyboard
              //                     ? (index + 1).toString()
              //                     : String.fromCharCode(index + 65),
              //                 onClick: (text) {
              //                   showNumKeyboard
              //                       ? _numController.text = text
              //                       : _charController.text = text;
              //                 },
              //               ))),
              // ),
              Positioned(
                top: 20,
                right: 20,
                child: SizedBox(
                    height: 50,
                    width: 100,
                    child: Chip(
                        avatar: const Icon(Icons.emoji_events),
                        label: Center(
                          child: AnimatedFlipCounter(
                            value: score,
                            // textStyle: TextStyle(),
                            duration: const Duration(seconds: 1),
                            // curve: Curves.bounceIn,
                          ),
                        ))),
              ),
            ]));
  }
}

class GameOverScreen extends StatelessWidget {
  const GameOverScreen({
    Key? key,
    required this.time,
  }) : super(key: key);

  final int time;
  Future<String> sendData() async {
    const String stand = 'WhereIsEfi1'; //TODO: switch for different APK's
    final response = await http.get(Uri.parse(
        'https://iddofroom.wixsite.com/elsewhere/_functions/winner?stand=$stand&resualt=$time'));
    // body: jsonEncode(data);
    return response.body;

    // headers: <String, String>{
    //   'Content-Type': 'application/json; charset=UTF-8',
    //   'Access-Control-Allow-Origin': '*',
    //   'Access-Control-Allow-Headers': 'Content-Type',
    //   'Referrer-Policy': 'no-referrer-when-downgrade'
    // },
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        children: [
          SizedBox(
            height: 200,
            child: Container(),
          ),
          const Text(
            "Game Over",
            textScaleFactor: 3,
          ),
          SizedBox(
            height: 100,
            child: Container(),
          ),
          Button(text: "Restart Game", nextScreen: EnterScreen(), onTap: () {}),
          SizedBox(
            height: 100,
            child: Container(),
          ),
          FutureBuilder(
            future: sendData(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                bool isWinner = jsonDecode(snapshot.data)['winner'];
                print(jsonDecode(snapshot.data)['winner']);
                // TODO: Later change the actions
                if (isWinner) {
                  return Text('Winner :)');
                } else {
                  return Text('Looser :(');
                }
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        ],
      )),
    );
  }
}

enum ButtonState {
  idle,
  correct,
  wrong,
  loading,
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
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
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
