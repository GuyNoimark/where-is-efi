import 'package:flutter/material.dart';
import 'package:where_is_efi/constants.dart';

class QuestionPage extends StatefulWidget {
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
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  // void showKeyboard(Keyboard keyboard) {}
  bool showKeyboard = false;
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                        'שאלה ${widget.questionNumber} מתוך 10',
                        textScaleFactor: 1.5,
                        style: TextStyle(fontWeight: FontWeight.normal),
                      ),
                    ),
                    Text(
                      widget.question,
                      textScaleFactor: 3,
                      textAlign: TextAlign.right,
                      textDirection: TextDirection.rtl,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 90),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
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
                            controller: _controller,
                            onTap: () => setState(() {
                              print('tap');
                              showKeyboard = true;
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
            duration: Duration(milliseconds: 600),
            bottom: showKeyboard ? 150 : 120,
            curve: Curves.easeInOutQuad,
            child: Center(
              child: SizedBox(
                width: 500,
                height: 60, // specific value
                child: ElevatedButton(
                  onPressed: () {
                    print(widget.answer);
                  },
                  child: Text('בדיקה',
                      style: TextStyle(
                          color: bgColor1,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                ),
              ),
            ),
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 600),
            bottom: showKeyboard ? 0 : -100,
            curve: Curves.easeInOutQuad,
            child: Keyboard(
                keys: List.generate(
                    10,
                    (index) => TextKey(
                          text: index.toString(),
                          onClick: (text) {
                            _controller.text = text;
                          },
                        ))),
          ),
        ],
      ),
    );
  }
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
