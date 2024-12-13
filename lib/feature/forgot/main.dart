import 'package:flutter/cupertino.dart';
import 'package:unforgettable_getaway/app.dart';

import 'core/auth/dependency.dart';

void main(){
  DependencyInjection di = DependencyInjection();
  di.dependencies();
  runApp(const MyApp());
}