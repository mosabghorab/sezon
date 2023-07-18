import 'dart:io';

void main()async{
  print('Welcome to flutter magic cli !!!!');
  print('1.create a new module.');
  print('2.remove an existing module.');
  String? moduleName = stdin.readLineSync();
  String path  = 'src/modules/$moduleName';
  await Directory(path).create(recursive: true);
  File moduleService = File('$path/${moduleName}s_service.dart');
  File moduleRepository = File('$path/${moduleName}s_repository.dart');
  moduleService.create(recursive: true);
  moduleService.writeAsString('''import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:jordan_motor/src/config/helpers.dart';
import 'package:jordan_motor/src/data/models/responses/base_response.dart';
import 'package:jordan_motor/src/data/models/responses/other_module/user_response.dart';
import 'package:jordan_motor/src/services/firebase_messaging_service.dart';
import 'package:random_password_generator/random_password_generator.dart';

class AuthService {
  static AuthService? _instance;
  late final Dio _dio = Dio(Helpers.baseOptions());
  late final RandomPasswordGenerator _randomPasswordGenerator =
      RandomPasswordGenerator();
  late final FirebaseMessagingService _firebaseMessagingService =
      FirebaseMessagingService.instance;

  // private constructor.
  AuthService._();

  // singleton pattern.
  static AuthService get instance => _instance ?? (_instance = AuthService._());
    
  // write your requests here ....  
}''');


  moduleRepository.writeAsString('''class AuthRepository {
  static AuthRepository? _instance;
  late final AuthService _authService = AuthService.instance;

  // private constructor.
  AuthRepository._();

  // singleton pattern.
  static AuthRepository get instance =>
      _instance ?? (_instance = AuthRepository._());
      
  // write your requests here ....
}
''');
  moduleRepository.create(recursive:true);
//   f.writeAsString('''import 'package:flutter/material.dart';
//
// class LoginScreen extends StatefulWidget {
//   const LoginScreen({Key? key}) : super(key: key);
//
//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }
// ''');
//   f.create();
}