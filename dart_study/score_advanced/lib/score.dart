import 'dart:io';
import 'dart:math' as math;

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
      final isLineEmpty = line.trim();

      if (isLineEmpty.isEmpty) {
        continue; // 빈 줄이면 다음 줄로 넘어감
      }
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

void topStudent(Map<String, int> studentData) {
  if (studentData.isEmpty) {
    print('데이터가 없습니다.');
    return;
  }
  // 두 값을 비교해서 더 큰 값 하나만 반환한다.
  // reduce : 모든 값을 하나씩 순서대로 꺼내서 함수 (a,b)에 넣고 누적해서 하나의 결과를 만든다
  // int topScore = studentData.values.reduce((a, b) => a > b ? a : b);

  //math 라이브러리의 max 함수 사용으로 더 간편하게 가장 큰 값 구하기
  int topScore = studentData.values.reduce(math.max);

  var topStudent = studentData.keys.where(
    (name) => studentData[name] == topScore,
  );

  print('우수생 : $topStudent (점수 : $topScore 점)');
}

void avg(Map<String, int> studentData) {
  if (studentData.isEmpty) {
    print('데이터가 없습니다.');
    return;
  }
  int sum = studentData.values.reduce((a, b) => a + b);

  double avgScore = sum / studentData.length;
  print(avgScore);
}

void writeFile(String filename, String content) {
  try {
    final file = File(filename);
    file.writeAsStringSync(content);
    print('$filename 파일이 생성되었습니다.');
  } catch (e) {
    print('파일 생성 실패: $e');
  }
}
