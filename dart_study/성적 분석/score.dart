class Score {
  int score;
  // 생성자
  Score(this.score);

  // 정보 출력
  void showInfo() {
    print('점수: $score');
  }
}

class StudentScore extends Score {
  String name;
  String subject;

  // 생성자에서 부모 생성자 호출
  StudentScore(this.name, this.subject, int score) : super(score);
  @override
  void show() {
    super.showInfo();
    print('이름: $name, 점수: $subject');
  }
}

void main() {
  StudentScore student = StudentScore('강준석', '수학', 95);
  student.show();
}
