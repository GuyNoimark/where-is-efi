import 'dart:convert';
import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:neon_circular_timer/neon_circular_timer.dart';
import 'package:wheel_chooser/wheel_chooser.dart';
import 'package:where_is_efi/constants.dart';
import 'package:where_is_efi/models/questions_model.dart';
import 'package:where_is_efi/EnterScreen.dart';
import 'package:where_is_efi/widgets/Button.dart';
import 'package:where_is_efi/winning_texts.dart';
import 'globals.dart' as globals;
import 'package:http/http.dart' as http;
import 'package:audioplayers/audioplayers.dart';

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
  final FixedExtentScrollController _charController =
      FixedExtentScrollController(initialItem: 4);
  final FixedExtentScrollController _numController =
      FixedExtentScrollController(initialItem: 4);
  final CountDownController _countDownController = CountDownController();

  ButtonState buttonState = ButtonState.idle;
  int questionIndex = 0;
  int score = 0;

  List<String> charItems =
      List<String>.generate(12, (index) => String.fromCharCode(index + 65))
        ..removeWhere((element) => element == "D");
  List<int> numItems = List.generate(10, (index) => index);

  bool checkAnswer() =>
      charItems[_charController.selectedItem] +
          (_numController.selectedItem + 1).toString() ==
      questions[questionIndex].answer;

  void gameOver() {
    globals.playerScore = score;
  }

  @override
  Widget build(BuildContext context) {
    QuestionsData currentQuestion = questions[questionIndex];
    return Container(
        decoration: BoxDecoration(
          image: const DecorationImage(
            opacity: 0.7,
            image:
                AssetImage('assets/new_design/mat/Eifo_Efi_01a_Background.png'),
          ),
          gradient: bgGradient,
        ),
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
                              const SizedBox(
                                width: 100,
                                height: 100,
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
                                          fontFamily: 'DancingScript',
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
                                      textScaleFactor: 4,
                                      textAlign: TextAlign.right,
                                      textDirection: TextDirection.rtl,
                                      style: const TextStyle(
                                          fontFamily: 'Albatros',
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
                                  // borderRadius: defaultBorderRadius,
                                  border:
                                      Border.all(color: secondary, width: 3),
                                )),
                              ),
                              SizedBox(
                                height: 100,
                                child: WheelChooser.byController(
                                  controller: _charController,
                                  onValueChanged: (s) => setState(() => {}),
                                  datas: charItems,
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
                            ],
                          ),
                          const SizedBox(height: 20),
                          Stack(alignment: Alignment.center, children: [
                            SizedBox(
                              height: 70,
                              width: 70,
                              child: Container(
                                  decoration: BoxDecoration(
                                // borderRadius: defaultBorderRadius,
                                border: Border.all(color: secondary, width: 3),
                              )),
                            ),
                            SizedBox(
                              height: 100,
                              child: WheelChooser.integer(
                                onValueChanged: (s) => setState(() => {}),
                                maxValue: 4,
                                minValue: 1,
                                controller: _numController,
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
                                  ? Colors.grey.shade800
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

                                    print(checkAnswer());
                                    buttonState = checkAnswer()
                                        ? ButtonState.correct
                                        : ButtonState.wrong;
                                  })
                                });

                        Future.delayed(
                            const Duration(milliseconds: 1500),
                            () => setState(() => {
                                  print('question++'),
                                  _charController.animateToItem(4,
                                      duration: const Duration(seconds: 1),
                                      curve: Curves.easeInOutCubic),
                                  _numController.animateToItem(4,
                                      duration: const Duration(seconds: 1),
                                      curve: Curves.easeInOutCubic),
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
                                                    name: playerName,
                                                    score: score,
                                                  )))
                                      : questionIndex++,
                                  // _numController.text = '',
                                  // _charController.text = ''
                                }));
                        Future.delayed(const Duration(milliseconds: 2000), () {
                          print('button set idle');
                          setState(() {
                            buttonState = ButtonState.idle;
                          });
                        });

                        print(currentQuestion.answer +
                            ' | ' +
                            charItems[_charController.selectedItem] +
                            (_numController.selectedItem + 1).toString());
                      },
                      child: Text(
                          buttonState == ButtonState.idle
                              ? 'בדיקה'
                              : buttonState == ButtonState.loading
                                  ? '....'
                                  : buttonState == ButtonState.correct
                                      ? ':) נכון'
                                      : ':( לא נכון',
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
              Positioned(
                top: 20,
                left: 20,
                child: NeonCircularTimer(
                  onComplete: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (final BuildContext context) =>
                              GameOverScreen(
                            name: playerName,
                            score: score,
                          ),
                        ));
                  },
                  // initialDuration: 60,
                  width: 90,
                  duration: 60,
                  controller: _countDownController,
                  isReverse: true,
                  neumorphicEffect: false,
                  innerFillGradient: const LinearGradient(colors: [
                    Color.fromARGB(255, 0, 255, 217),
                    Color.fromARGB(255, 0, 213, 255)
                  ]),
                  neonColor: secondary.withOpacity(0.4),
                  textFormat: TextFormat.SS,
                  neonGradient: LinearGradient(colors: [
                    Colors.greenAccent.shade200,
                    Colors.blueAccent.shade400
                  ]),
                  // innerFillColor: Colors.yellowAccent,
                  // neonColor: Colors.lightBlue,
                  // outerStrokeColor: Colors.amber,
                  isTimerTextShown: true,
                  isReverseAnimation: true,
                  textStyle: const TextStyle(fontSize: 30),
                ),
              )
            ]));
  }
}

class GameOverScreen extends StatelessWidget {
  const GameOverScreen({
    Key? key,
    required this.score,
    required this.name,
  }) : super(key: key);

  final int score;
  final String name;
  Future<String> sendData() async {
    const String stand = 'WhereIsEfi2'; //TODO: switch for different APK's
    final response = await http.get(Uri.parse(
        'https://iddofroom.wixsite.com/elsewhere/_functions/winner?stand=$stand$name&result=${score ~/ 100}'));
    // body: jsonEncode(data);
    print(
        'https://iddofroom.wixsite.com/elsewhere/_functions/winner?stand=$stand$name&result=${score ~/ 100}');
    return response.body;
  }

  @override
  Widget build(BuildContext context) {
    WinningTexts _winningText = WinningTexts.WON;

    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "GAME OVER",
            textScaleFactor: 3,
            style: TextStyle(
              fontFamily: 'Avenir',
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          FutureBuilder(
            future: sendData(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                bool isWinner = jsonDecode(snapshot.data)['winner'];
                if (isWinner) {
                  AudioPlayer player = AudioPlayer();
                  const winnerSound = "winner_sound.mp3";
                  player.play(AssetSource(winnerSound));
                  return Column(
                    children: const [
                      Text(
                        'WOW, YOU WON!',
                        textScaleFactor: 2,
                        style: TextStyle(fontFamily: 'Avenir'),
                      ),
                      SizedBox(height: 20),
                      AutoConfetti(),
                    ],
                  );
                } else {
                  _winningText = WinningTexts.NOTHING;
                  return Container();
                }
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              } else {
                return Container();
              }
            },
          ),
          Button(
              text: "Restart Game",
              nextScreen: const EnterScreen(),
              onTap: () {}),
        ],
      )),
    );
  }
}

class AutoConfetti extends StatefulWidget {
  const AutoConfetti({
    Key? key,
  }) : super(key: key);

  @override
  State<AutoConfetti> createState() => _AutoConfettiState();
}

class _AutoConfettiState extends State<AutoConfetti> {
  final ConfettiController _confettiController =
      ConfettiController(duration: const Duration(seconds: 5));

  @override
  void initState() {
    super.initState();
    _confettiController.play();
  }

  @override
  Widget build(BuildContext context) {
    return ConfettiWidget(
      confettiController: _confettiController,
      blastDirectionality: BlastDirectionality.explosive, // radial value - LEFT
      particleDrag: 0.05, // apply drag to the confetti
      emissionFrequency: 0.05, // how often it should emit
      numberOfParticles: 20, // number of particles to emit
      gravity: 0.05, // gravity - or fall speed
      shouldLoop: false,
      colors: const [
        Colors.green,
        Colors.blue,
        Colors.pink
      ], // manually specify the colors to be used
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
