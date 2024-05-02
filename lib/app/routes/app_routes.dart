// ignore_for_file: constant_identifier_names

part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const TAKS = _Paths.TAKS;
  static const HOME = _Paths.HOME;
}

abstract class _Paths {
  _Paths._();
  static const TAKS = '/taks';
  static const HOME = '/home';
}
