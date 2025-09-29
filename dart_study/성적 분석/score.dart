class Score {
  int score;
  // 생성자
  Score(this.score);

  // 정보 출력
  void showInfo() {
    print('점수: $score');
  }
}

void main() {
  Score score = Score(95);
  score.showInfo();
}
