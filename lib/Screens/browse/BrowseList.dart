// ignore_for_file: file_names

import 'package:flutter/material.dart';

class WorkoutFocus extends StatefulWidget {
  const WorkoutFocus({super.key});

  @override
  State<WorkoutFocus> createState() => _WorkoutFocusState();
}
class _WorkoutFocusState extends State<WorkoutFocus> {
  RoundedRectangleBorder roundedRectangleBorder = const RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(20),
      topRight: Radius.circular(20),
    )
  );
  @override
  Widget build(BuildContext context) {
  return Stack(
   children: [
         Positioned(
       top: 40,
       child: GestureDetector(
        onTap: () {
          showModalBottomSheet(
            context: context,
             backgroundColor: const Color.fromARGB(255, 216, 212, 212),
             shape: roundedRectangleBorder,
             builder: (BuildContext context) {
             return ListView.builder(
              shrinkWrap: true,
             itemCount: 2,
             itemBuilder: (context, index) {
              if (index == 0) {
                return const ListTile(
                  title: Text('Endurance'),
                );
              } else {
                return const  ListTile(
                  title: Text('Yoga'),
                );
              }
            },
          );
        },
      );
    },
    child: Stack(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Image.asset('lib/Assets/Premium_App_to_Stay_Free_Year_Round.jpeg'),
              ),
               const  Positioned(
                  bottom: 80,
                  left: 30,
                  child: Text(
                    'Workout Focus',
                    style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      
      Positioned(
       top: 270,
       child: GestureDetector(
        onTap: () {
          showModalBottomSheet(
            context: context,
             backgroundColor: const Color.fromARGB(255, 216, 212, 212),
             shape: roundedRectangleBorder,
             builder: (BuildContext context) {
             return ListView.builder(
              shrinkWrap: true,
             itemCount: 2,
             itemBuilder: (context, index) {
              if (index == 0) {
                return ListTile(
                  title: const Text('Abs & Core'),
                  onTap: () {
                    
                  },
                );
              } else {
                return ListTile(
                  title:const Text('Arms & Shoulders'),
                  onTap: () {
                    
                  },
                );
              }
            },
          );
        },
      );
    },
      child: Stack(
        children: [
         SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Image.asset('lib/Assets/Loft_Fitness_Training.jpeg'),
              ),
                const Positioned(
                  bottom: 60,
                  left: 30,
                  child: Text(
                    'Muscle Group',
                    style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
       top: 520,
       child: GestureDetector(
        onTap: () {
          showModalBottomSheet(
            context: context,
             backgroundColor: const Color.fromARGB(255, 216, 212, 212),
             shape: roundedRectangleBorder,
             builder: (BuildContext context) {
             return ListView.builder(
              shrinkWrap: true,
             itemCount: 2,
             itemBuilder: (context, index) {
              if (index == 0) {
                return const  ListTile(
                  title: Text('Full Equipment'),
                );
              } else {
                return const  ListTile(
                  title: Text('No Equipments'),
                );
              }
            },
          );
        },
      );
    },
         child: Stack(
         children: [
         SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Image.asset('lib/Assets/Luvas_de_Treino-M.jpeg'),
              ),
                const Positioned(
                  bottom: 80,
                  left: 30,
                  child: Text(
                    'Equipments',
                    style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        )
     ],
   );    
  }
}