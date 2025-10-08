import 'dart:io';

class Student {
  String name;
  int score;

  Student(this.name, this.score);

  void showInfo() {
    print('이름: $name,점수: $score');
  }
}

// csv파일에서 학생 데이터 가져오기
Map<String, int> loadStudentData(String filePath) {
  Map<String, int> studentMap = {};
  try {
    final file = File(filePath);
    final line = file.readAsLinesSync(); // -> csv파일의 각 줄을 리스트로 가져옴

    for (var line in line) {
      final parts = line.split(',');
      if (parts.length != 2) {
        throw FormatException('잘못된 데이터 형식: $line');
      }
      String name = parts[0];
      int score = int.parse(parts[1]);

      studentMap.putIfAbsent(name, () => score);
    }
  } catch (e) {
    print("학생 데이터 가져오기 실패 $e");
    exit(1);
  }

  print('csv파일에서 가져온 학생 점수 데이터 : $studentMap');

  return studentMap;
}

void main() {
  String filePath = 'score.csv';
  Map<String, int> studentData = loadStudentData(filePath);

  while (true) {
    print('어떤 학생의 점수를 확인하시겠습니까? (그만하려면 exit or 종료 입력): ');
    String? inputName = stdin.readLineSync();

    if (inputName == null || inputName.isEmpty) continue;

    // 종료기능
    if (inputName == 'exit' || inputName == '종료') {
      print('종료합니다.');
      break;
    }
    ;

    if (studentData.containsKey(inputName)) {
      print('$inputName 학생의 점수는 ${studentData[inputName]}점 입니다.');
    } else {
      print('$inputName 학생은 없는 학생입니다.');
    }
  }
}
