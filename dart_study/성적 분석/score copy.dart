import 'dart:io';

class OnlyScore {
  int score;

  // 생성자
  OnlyScore(this.score);

  // 정보 출력
  void showInfo() {
    print('점수: $score');
  }
}

class StudentScore extends OnlyScore {
  String name;
  // 생성자에서 부모 생성자 호출
  StudentScore(this.name, int score) : super(score);

  @override
  void showInfo() {
    print('이름: $name,점수: $score');
  }
}

// csv파일에서 학생 데이터 가져오기
Map<String, int> loadStudentData(String filePath) {
  Map<String, int> studentsMap = {};
  try {
    final file = File(filePath);
    final lines = file.readAsLinesSync(); // -> csv파일의 각 줄을 리스트로 가져옴
    // print(lines);

    for (var line in lines) {
      final parts = line.split(',');
      if (parts.length != 2) throw FormatException('잘못된 데이터 형식: $line');

      String name = parts[0];
      int score = int.parse(parts[1]);

      studentsMap.putIfAbsent(name, () => score);
    }
    // print(studentsMap);
  } catch (e) {
    print("csv파일에서 점수 데이터 가져오기 실패: $e");
    exit(1);
  }

  return studentsMap;
}

void main() {
  String filePath = 'score.csv';

  Map<String, int> studentData = loadStudentData(filePath);

  // print("전체 학생 점수: $studentData");

  // 학생 이름 입력 받기
  print('학생 이름을 입력하시오 : ');
  String? inputName = stdin
      .readLineSync(); // 디버그 콘솔에서 입력 안됨, dart run 명령어로 터미널에서 실행 후 입력가능
  while (true) {
    if (inputName != null && inputName.isNotEmpty) {
      break; // 입력이 유효하면 반복 종료
    }
  }
  print('입력한 텍스트 : $inputName');

  String searchName = inputName;

  while (true) {
    if (inputName != null && inputName.isNotEmpty) {
      break; // 입력이 유효하면 반복 종료
    }
  }

  if (studentData.containsKey(searchName)) {
    print('$searchName 학생의 점수는 ${studentData[searchName]}입니다.');
  } else {
    print('$searchName는 없는 학생입니다.');
    return main();
  }
}
