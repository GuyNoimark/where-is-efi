import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';
import 'package:neon_circular_timer/neon_circular_timer.dart';
import 'package:where_is_efi/constants.dart';
import 'package:where_is_efi/models/questions_model.dart';
import 'package:where_is_efi/EnterScreen.dart';
import 'package:where_is_efi/widgets/Button.dart';
import 'globals.dart' as globals;
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
                                            const GameOverScreen(),
                                      ));
                                },
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
                                  style: const TextStyle(fontSize: 60),
                                  decoration:
                                      const InputDecoration(hintText: 'A'),
                                ),
                              ),
                              const SizedBox(
                                width: 35,
                              ),
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
                                  style: const TextStyle(fontSize: 60),
                                  decoration:
                                      const InputDecoration(hintText: '#'),
                                ),
                              ),
                            ],
                          ),
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
                                                  const GameOverScreen()))
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
  }) : super(key: key);

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
          Button(text: "Restart Game", nextScreen: EnterScreen(), onTap: () {})
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
