void main() {
  int score = 84;

  if (score < 80) {
    print("이 학생의 점수는 $score이며, 등급은 C등급.");
  } else if (score < 90) {
    print("이 학생의 점수는 $score이며, 등급은 B등급.");
  } else if (90 <= score && 100 >= score) {
    print("이 학생의 점수는 $score이며, 등급은 A등급.");
  } else {
    print("이 학생의 점수는 $score이며, 잘못된 점수.");
  }
}
