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

void writeFile(String filename, String content) {
  try {
    final file = File(filename);
    file.writeAsStringSync(content);
    print('$filename 파일이 생성되었습니다.');
  } catch (e) {
    print('파일 생성 실패: $e');
  }
}

void main() {
  String filePath = 'score.csv';
  Map<String, int> studentData = loadStudentData(filePath);

  print('사용하실 기능을 선택 하시오. ');
  print('(1: 우수 학생 점수 확인, 2: 학생 전체 평균 점수 확인, 3: 특정 학생 점수 조회, 4. 종료)');
  String? category = stdin.readLineSync();

  switch (category) {
    case '1':
      print('우수학생 점수를 조회합니다.');
      topStudent(studentData);

    case '2': // 학생 전체 평균 점수 확인
      print('아직 구현 전입니다.');
      break;
    case '3':
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
          writeFile(
            '$inputName.csv',
            '$inputName 학생의 점수는 ${studentData[inputName]}점 입니다.',
          );
          print('생성된 파일 이름은 : $inputName');
        } else {
          print('$inputName 학생은 없는 학생입니다.');
        }
      }

    case '4':
      print('종료합니다.');
      break;
  }
}
