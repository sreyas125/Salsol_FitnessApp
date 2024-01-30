
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:salsol_fitness/models/db_admin_add_function.dart';


 editVideoDetails(int index,context,videoList, setStateCallback,saveUpdatedDetails){
    showModalBottomSheet(
      context: context,
       builder: (BuildContext context){
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                initialValue: videoList[index].title,
                decoration: const InputDecoration(
                  labelText: 'title',
                  border: OutlineInputBorder(),
                ),
                onChanged: (newValue) {
                  setStateCallback(() {
                    videoList[index].title = newValue;
                  });
                },
              ),
              const SizedBox(height: 16.0,),
              TextFormField(
                initialValue: videoList[index].discription,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                onChanged: (newValue) {
                  setStateCallback(() {
                    videoList[index].discription = newValue;
                  });
                },
              ),
              const SizedBox(height: 16.0,),
              TextFormField(
                initialValue: videoList[index].time,
                decoration: const InputDecoration(
                  labelText: 'Time',
                  border: OutlineInputBorder(),
                ),
                onChanged: (newValue) {
                  setStateCallback(() {
                    videoList[index].time = newValue;
                  });
                },
              ),
              const SizedBox(height: 16.0,),
              ElevatedButton(onPressed: (){
                saveUpdatedDetails(index);
                Navigator.pop(context);
              }, child: const Text('Save'),)
            ],
          ),
        );
       });
   }

       deleteVideoDetails(int index,context,setStateCallback,List videoList) {
  return  showDialog(
      context: context,
       builder: (BuildContext context){
        return AlertDialog(
          title:  const Text('Are You sure You Want to delete this details?'),
          content: const Text('This Action will delete the workout details'),
          actions: [
            TextButton(
              onPressed: (){
                deleteDetails(index,setStateCallback,videoList);
                Navigator.of(context).pop();
            }, child: const Text('Delete'),)
          ],
        );
       });
  }
   Future<void> deleteDetails(int index,SetStateCallback,List videoList,) async{
    final Box = await Hive.openBox<Addvideomodel>('videos');
    await Box.deleteAt(index);

    SetStateCallback(() {
      videoList.removeAt(index);
    });
   }
   

  