class Score {
  int score = 90;

  void showInfo() {
    print('점수: $score');
  }
}

class StudentScore extends Score {
  String name = '강준석';
  String subject = '수학';

  @override
  void show() {
    super.showInfo(); // 부모 클래스의 메서드 호출
    print('이름 : $name, 과목: $subject');
  }
}

void main() {
  // Score score = Score();
  // score.showInfo();

  StudentScore studentScore = StudentScore();
  studentScore.show();
}
