class QuestionsData {
  QuestionsData(this.question, this.answer);

  final String question;
  final String answer;

  QuestionsData.fromJson(Map<String, dynamic> json)
      : question = json['question'],
        answer = json['answer'];
}
