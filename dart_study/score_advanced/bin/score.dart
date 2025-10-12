import 'dart:io';
import 'package:score_advanced/score.dart';
import 'dart:async'; // 딜레이주기위해 사용하는 라이브러리

void main(List<String> arguments) async {
  String filePath = '../students.csv';
  Map<String, int> studentData = loadStudentData(filePath);

  while (true) {
    print('============= 사용하실 기능을 선택 하시오. =============');
    await delay(500); // 메뉴 전후 짧게 0.5초 대기

    print(
      '(1: 우수 학생 점수 확인, 2: 학생 전체 평균 점수 확인, 3: 학생 점수 조회, 4: 학생 등급 조회, 5: 종합 정리본 저장, 6: 종료)',
    );
    String? category = stdin.readLineSync();
    // 아예 종료
    if (category == '6') break;

    switch (category) {
      case '1':
        print('============= 우수학생 점수를 조회합니다. =============');
        topStudent(studentData);
        await delay(500); // 결과 확인용 0.5초
        break;

      case '2': // 학생 전체 평균 점수 확인
        print('============= 학생 전체의 평균을 구합니다. =============');
        avg(studentData);
        await delay(500); // 결과 확인용 0.5초
        break;

      case '3':
        while (true) {
          // 가독성을 위한 0.5초 딜레이
          await delay(500);
          print(
            '============= 어떤 학생의 점수를 확인하시겠습니까? (그만하려면 exit or 종료 입력)=============',
          );
          String? inputName = stdin.readLineSync();

          if (inputName == null || inputName.isEmpty) continue;

          // 아예 종료기능
          if (inputName == 'exit' || inputName == '종료') {
            print('============= 학생 점수 조회를 종료합니다. =============');
            await delay(500);
            break;
          }

          if (studentData.containsKey(inputName)) {
            print('$inputName 학생의 점수는 ${studentData[inputName]}점 입니다.');
            await delay(500); // 점수 출력 후 짧게 대기
            print(
              '============= $inputName 학생 점수 정보를 저장하시겠습니까? (y or n) =============',
            );
            String? isSave = stdin.readLineSync();
            if (isSave == 'y') {
              writeFile(
                '../data/$inputName.csv',
                '$inputName 학생의 점수는 ${studentData[inputName]}점 입니다.',
              );
              await delay(300); // 저장 완료 메시지 잠깐 대기
              print('파일이 생성되었습니다. 파일 이름 : $inputName');
            } else {
              print('학생 점수 정보를 저장하지않습니다.');
              await delay(300); // 짧게 대기
            }
          } else {
            print('$inputName 학생은 없는 학생입니다.');
            await delay(500); // 에러 메시지 잠깐 보여주기
          }
        }
        break;
      case '4':
        print('============= 학생들의 등급을 조회합니다. =============');
        await delay(500); // 결과 확인용 0.5초
        studentGrades(studentData);
        break;

      case '5':
        saveAllData(studentData, '../data/summary.csv');
        await delay(500); // 결과 확인 후 0.5초
        break;

      case '6':
        await delay(500); // 종료 시 딜레이
        break;

      default:
        print('잘못된 입력입니다.');
        await delay(300); // 잘못된 입력 메시지
        break;
    }
  }
}
