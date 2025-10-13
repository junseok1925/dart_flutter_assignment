import 'dart:io';
import 'dart:math' as math;

class Student {
  String name;
  int score;

  Student(this.name, this.score);

  void showInfo() {
    print('============= 이름: $name,점수: $score =============');
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
        throw FormatException('============= 잘못된 데이터 형식: $line =============');
      }
      String name = parts[0];
      int score = int.parse(parts[1]);

      studentMap.putIfAbsent(name, () => score);

      // print(studentMap);
    }
  } catch (e) {
    print("============= 학생 데이터 가져오기 실패 $e =============");
    exit(1);
  }

  // print('============= csv파일에서 가져온 학생 점수 데이터 : $studentMap =============');

  return studentMap;
}

// 우수 학생 조회
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
    print('============= 데이터가 없습니다. =============');
    return;
  }
  int sum = studentData.values.reduce((a, b) => a + b);

  double avgScore = sum / studentData.length;
  print('학생 전체 평균은 $avgScore점 입니다.');
}

// 등급 나누기
void studentGrades(Map<String, int> studentData) {
  print('학생 데이터 확인 용 : $studentData');
  if (studentData.isEmpty) {
    print('============= 데이터가 없습니다. =============');
    return;
  }

  // 점수를 내림차순으로 정렬
  var sortedStudents = studentData.entries.toList()
    ..sort((a, b) => b.value.compareTo(a.value));

  int total = sortedStudents.length;
  int grade1Count = (total * 0.3).ceil(); // 상위 30%
  int grade2Count = (total * 0.4).ceil(); // 중간 40%
  // 나머지 학생은 3등급

  print('학생 등급 결과:');
  for (int i = 0; i < sortedStudents.length; i++) {
    String grade;
    if (i < grade1Count) {
      grade = '1등급';
    } else if (i < grade1Count + grade2Count) {
      grade = '2등급';
    } else {
      grade = '3등급';
    }
    print(
      '${sortedStudents[i].key} -> 점수: ${sortedStudents[i].value}점 등급: $grade',
    );
  }
}

// 파일 생성
void writeFile(String filename, String content) {
  try {
    final file = File(filename);
    file.writeAsStringSync(content);
    print('============= 파일이 생성되었습니다. =============');
  } catch (e) {
    print('============= 파일 생성 실패: $e =============');
  }
}

// 한번에 모든 정보 .csv 파일로 생성해서 저장하기
void saveAllData(Map<String, int> studentData, String filename) {
  if (studentData.isEmpty) {
    print('데이터가 없습니다.');
    return;
  }

  // 1. 우수생
  int topScore = studentData.values.reduce((a, b) => a > b ? a : b);
  var topStudents = studentData.keys.where(
    (name) => studentData[name] == topScore,
  );

  // 2. 평균 점수
  double avgScore =
      studentData.values.reduce((a, b) => a + b) / studentData.length;

  // 3. 등급 계산
  var sortedStudents = studentData.entries.toList()
    ..sort((a, b) => b.value.compareTo(a.value));
  int total = sortedStudents.length;
  int grade1Count = (total * 0.1).ceil(); // 상위 10프로
  int grade2Count = (total * 0.2).ceil(); // 상위 20프로
  int grade3Count = (total * 0.3).ceil(); // 상위 30프로... 나머지는 4등급

  // CSV 문자열 생성
  StringBuffer contents = StringBuffer();
  contents.writeln('우수생: ${topStudents.join(", ")}');
  contents.writeln('전체 평균: $avgScore');
  for (int i = 0; i < sortedStudents.length; i++) {
    String grade;
    if (i < grade1Count) {
      grade = '1등급';
    } else if (i < grade1Count + grade2Count) {
      grade = '2등급';
    } else if (i < grade2Count + grade3Count) {
      grade = '3등급';
    } else {
      grade = '4등급'; // 나머지는 4등급
    }
    ;
    contents.writeln(
      '${sortedStudents[i].key},${sortedStudents[i].value},$grade',
    );
  }

  // 파일 생성
  writeFile(filename, contents.toString());
  print('모든 학생 데이터가 $filename 파일로 저장되었습니다.');
}

// 1초 딜레이 함수
// int ms = 0 -> 매개변수 값 없을 시 기본 딜레이 시간 0으로 지정
Future<void> delay([int ms = 0]) async =>
    await Future.delayed(Duration(milliseconds: ms));
