import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/service/local_notificaion_service.dart';
import 'package:flutter_project/utils/Colors.dart';
import 'feature/sensor_tracking/presentation/page/sensor_tracking_screen.dart';
import 'feature/todo/presentation/bloc/add_todo_bloc/add_todo_bloc.dart';
import 'feature/todo/presentation/pages/todo_profile_screen.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService().initialize();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
  providers: [
    BlocProvider<AddTodoBloc>(
      create: (BuildContext context) => AddTodoBloc(),
    ),
  ],
  child: MaterialApp(
      title: 'Custom Design',
      debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primaryColor: AppColors.primary, // Set primary color here
      colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: AppColors.primary,
      ),
      scaffoldBackgroundColor: AppColors.background,
    ),
      home: HomeScreen(),
    ),
);
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // A To-Do List Button
            SizedBox(
              width: MediaQuery.of(context)
                  .size
                  .width, // Set the width you want here
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TodoProfileScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.tealAccent, // Button background color
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text(
                  'A To-Do List',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20), // Spacing between buttons
            // Sensor Tracking Button
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SensorTrackingScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent, // Button background color
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text(
                  'Sensor Tracking',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
