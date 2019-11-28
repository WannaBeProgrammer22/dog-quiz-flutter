import 'question.dart';

class QuizBrain {
  int _currentQuestionNumber = 0;
  List<Question> _questionBank = [
    Question('Electrons are larger than molecules.', false),
    Question('The Atlantic Ocean is the biggest ocean on Earth.', false),
    Question('The chemical make up food often changes when you cook it.', true),
    Question('Sharks are mammals.', false),
    Question('The human body has four lungs.', false),
    Question('The human skeleton is made up of less than 100 bones.', false),
    Question('Kelvin is a measure of temperature..', true),
    Question('Spiders have six legs..', false),
    Question('Atomic bombs work by atomic fission.', true),
    Question('Herbivores eat meat.', false),
  ];

  void nextQuestion() {
    _currentQuestionNumber++;
  }

  bool isFinished() {
    return _currentQuestionNumber == _questionBank.length - 1;
  }

  String getQuestionText() {
    return _questionBank[_currentQuestionNumber].questionText;
  }

  bool getQuestionAnswer() {
    return _questionBank[_currentQuestionNumber].questionAnswer;
  }

  String getNumberOfQuestion() {
    return _questionBank.length.toString();
  }

  void reset() {
    _currentQuestionNumber = 0;
  }
}
