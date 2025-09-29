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

  print(studentMap);

  return studentMap;
}

void main() {
  String filePath = 'score.csv';
  Map<String, int> studentData = loadStudentData(filePath);

  print('학생 이름을 적으시오 : ');
  String? inputName = stdin.readLineSync();

  while (true) {
    if (inputName != null && inputName.isNotEmpty) {
      break; // 입력을 하면반복 종료
    } else {
      // 입력안하면 계속 입력창 띄우기
      print('학생 이름을 적으시오 : ');
      inputName = stdin.readLineSync();
    }
  }
  print('입력한 텍스트 : $inputName');
}
