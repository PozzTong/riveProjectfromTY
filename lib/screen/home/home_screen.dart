import 'package:flutter/material.dart';
import 'package:onyoutube/model/course.dart';
import 'package:onyoutube/screen/home/components/course_card.dart';
import 'package:onyoutube/screen/home/components/second_course.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40,),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  'Courses',
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium!
                      .copyWith(color: Colors.black, fontWeight: FontWeight.w600),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ...courses
                        .map((course) => Padding(
                              padding: const EdgeInsets.only(left: 16),
                              child: CourseCard(course: course),
                            ))
                        
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'Recent',
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(fontWeight: FontWeight.w600),
                ),
              ),
             ...recentCourses.map((courses)=> Padding(
               padding: const EdgeInsets.only(left: 20,right: 20,bottom: 20),
               child: SecondaryCourseCard(course: courses,),
             ))
            ],
          ),
        ),
      ),
    );
  }
}
