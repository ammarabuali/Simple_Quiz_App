import 'package:flutter/material.dart';
import 'package:simple_quiz_app/UI/container_widget.dart';
import 'package:simple_quiz_app/data/questions.dart';
import 'package:simple_quiz_app/pages/question_page.dart';
import 'package:simple_quiz_app/pages/results_page.dart';
import 'package:simple_quiz_app/pages/welcome_page.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  final List<String> selectedAnswers = [];
  var activeScreen = 'welcome-page';

  void switchScreen() {
    setState(() {
      activeScreen = 'question-page';
    });
  }

  void restartQuiz() {
    setState(() {
      selectedAnswers.clear();
      activeScreen = 'welcome-page';
    });
  }

  void chooseAnswer(String answer) {
    selectedAnswers.add(answer);
    if (selectedAnswers.length == questions.length) {
      setState(() {
        activeScreen = 'results-page';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Widget screenWidget;
    if (activeScreen == 'welcome-page') {
      screenWidget = WelcomePage(switchScreen);
    } else if (activeScreen == 'results-page') {
      screenWidget = ResultsPage(
        onRestart: restartQuiz,
        choosenAnswers: selectedAnswers,
      );
    } else {
      screenWidget = QuestionsPage(onSelectAnswer: chooseAnswer);
    }
    return ContainerWidget(
      activeScreen: screenWidget,
    );
  }
}
