import 'dart:io';
import 'package:score_advanced/score.dart';
import 'dart:async'; // 딜레이주기위해 사용하는 라이브러리

void main(List<String> arguments) async {
  String filePath = '../students.csv';
  Map<String, int> studentData = loadStudentData(filePath);

  while (true) {
    print('사용하실 기능을 선택 하시오. ');
    print('(1: 우수 학생 점수 확인, 2: 학생 전체 평균 점수 확인, 3: 특정 학생 점수 조회, 4: 종료)');
    String? category = stdin.readLineSync();
    // 아예 종료
    if (category == '4') break;

    switch (category) {
      case '1':
        print('우수학생 점수를 조회합니다.');
        topStudent(studentData);

      case '2': // 학생 전체 평균 점수 확인
        print('학생 전체의 평균을 구합니다.');
        avg(studentData);

        break;
      case '3':
        while (true) {
          // 가독성을 위한 1초 딜레이
          await Future.delayed(Duration(milliseconds: 1000));

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
            // 가독성을 위한 1초 딜레이
            await Future.delayed(Duration(milliseconds: 1000));
            print('$inputName 학생 점수 정보를 저장하시겠습니까? (y or n)');

            String? isSave = stdin.readLineSync();
            if (isSave == '1' || isSave == 'y') {
              writeFile(
                '$inputName.csv',
                '$inputName 학생의 점수는 ${studentData[inputName]}점 입니다.',
              );
              print('생성된 파일 이름은 : $inputName');
            } else {
              print('학생 점수 정보를 저장하지않습니다.');
            }
          } else {
            print('$inputName 학생은 없는 학생입니다.');
          }
        }
      // 특정 학생 점수 조회 종료
      case '4':
        print('종료합니다.');
        await Future.delayed(Duration(milliseconds: 1000));
        break;
    }
  }
}
