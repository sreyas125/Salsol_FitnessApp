// ignore_for_file: prefer_const_constructors, unused_field, file_names

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:salsol_fitness/list_of_Categories/Endurance.dart';
import 'package:salsol_fitness/list_of_Categories/equipments.dart';
import 'package:salsol_fitness/list_of_Categories/muscle_group.dart';

class WorkoutFocus extends StatefulWidget {
  const WorkoutFocus({super.key});

  @override
  State<WorkoutFocus> createState() => _WorkoutFocusState();
}

class _WorkoutFocusState extends State<WorkoutFocus> with SingleTickerProviderStateMixin{
  late TabController _tabController;
  RoundedRectangleBorder roundedRectangleBorder = const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
    topLeft: Radius.circular(20),
    topRight: Radius.circular(20),
  ));
  List<String> workoutFocusOptions = ['Endurance', 'Yoga'];
  List<String> muscleGroupOptions = ['Abs & Core', 'Arms & Shoulders'];
  List<String> equipmentsOptions = ['Full Equipment', 'No Equipments'];

  String selectedWorkoutFocus = 'Endurance';
  String selectedMuscleGroup = 'Abs & Core';
  String selectedEquipments = 'Full Equipment';

 double opacityvalue = 0.3;
 @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          Positioned(
            top: 40,
            child: GestureDetector(
              onTap: () {
                _showDropdown(
                  workoutFocusOptions,
                  'Workout Focus',
                  selectedWorkoutFocus,
                  (String value) {
                    setState(() {
                      selectedWorkoutFocus = value;
                    });
                  },
                );
              },
              child: Stack(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ColorFiltered(
                      colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(opacityvalue),
                         BlendMode.srcOver,
                         ),
                      child: Image.asset(
                          'lib/Assets/Premium_App_to_Stay_Free_Year_Round.jpeg'),
                    ),
                  ),
                  const Positioned(
                    bottom: 80,
                    left: 30,
                    child: Row(
                      children: [
                        Text(
                          'Workout Focus',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          CupertinoIcons.arrowtriangle_down_fill,
                          size: 15,
                          color: Colors.white,
                        )
                      ],
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
                _showDropdown(
                  muscleGroupOptions,
                  'Muscle Group',
                  selectedMuscleGroup,
                  (String value) {
                    setState(() {
                      selectedMuscleGroup = value;
                    });
                  },
                );
              },
              child: Stack(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ColorFiltered(
                      colorFilter: ColorFilter.mode(Colors.black.withOpacity(opacityvalue),
                       BlendMode.srcOver),
                      child: Image.asset(
                          'lib/Assets/Loft_Fitness_Training.jpeg'),
                    ),
                  ),
                  const Positioned(
                    bottom: 60,
                    left: 30,
                    child: Row(
                      children: [
                        Text(
                          'Muscle Group',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          CupertinoIcons.arrowtriangle_down_fill,
                          size: 15,
                          color: Colors.white,
                        ),
                      ],
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
                _showDropdown(
                  equipmentsOptions,
                  'Muscle Group',
                  selectedEquipments,
                  (String value) {
                    setState(() {
                      selectedEquipments = value;
                    });
                  },
                );
              },
              child: Stack(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ColorFiltered(
                      colorFilter: ColorFilter.mode(Colors.black.withOpacity(opacityvalue),
                       BlendMode.srcOver),
                      child: Image.asset(
                          'lib/Assets/Luvas_de_Treino-M.jpeg'),
                    ),
                  ),
                  const Positioned(
                    bottom: 80,
                    left: 30,
                    child: Row(
                      children: [
                        Text(
                          'Equipments',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          CupertinoIcons.arrowtriangle_down_fill,
                          size: 15,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
void _showDropdown(
    List<String> items,
    String title,
    String selectedItem,
    Function(String) onChanged,
  ) {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final imageSize = renderBox.size.height;
    final position = RelativeRect.fromRect(
      Rect.fromPoints(
        renderBox.localToGlobal(Offset(0, imageSize)),
        renderBox.localToGlobal(Offset(0, imageSize + 100)),
      ),
      Offset.zero & context.size!,
    );
    showMenu(
      context: context,
      position: position,
      items: items.map((String value) {
        return 
          PopupMenuItem(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height:MediaQuery.of(context).size.height/16,
              child: ListTile(
                title: Text(value),
                onTap: () {
                  onChanged(value);
                  Navigator.of(context).pop();
                  _navigateToAnotherPage(value);
                },
              ),
            ),  
          ),
         );
      }).toList(),
      elevation: 8.0,
    );
  }

  void _navigateToAnotherPage(String selectedValue){
     switch(selectedValue){
     case 'Endurance':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Endurance.create(
              categoryVideoList: const [],
              selectedCategories:const [],
              ),
            ), 
          );
        break;
      case 'Yoga':
      Navigator.push(context, MaterialPageRoute(
        builder: (context) => Endurance.create(
          categoryVideoList: const [],
          selectedCategories: const [],
        ),));
      break;
      case 'Abs & Core':
      Navigator.push(context, MaterialPageRoute(
        builder: (context) => MuscleGroupScreen.create(
          categoryvideoList: const [],
          selectedCategories: const [],
        ),));
        break;
        case 'Full Equipment':
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => EquipmentScreen.create(
          categoryVideoList: const [],
           selectedCategories: const [],
           ),));
           break;
    }
  }

}
