// ignore_for_file: non_constant_identifier_names, unused_local_variable
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:salsol_fitness/Screens/admin/home_admin.dart';
import 'package:salsol_fitness/models/db_admin_add_function.dart';

class AddVideoScreen extends StatefulWidget {
  const AddVideoScreen({super.key});

  @override
  State<AddVideoScreen> createState() => _AddVideoScreenState();
}

class _AddVideoScreenState extends State<AddVideoScreen> {
   Uint8List? _imageBytes;
   String? _videoUrl;
   String? _title;
   String? _description;
   String? _selectedCategory;
   String? _time;
   int? _selectedCategoryIndex;
   
   List<Addvideomodel> videoList = [];
   List<String> selectedCategories = [];
    List<String> categories=[
    'Yoga',
    'Endurance',
    'Arms & Shoulder',
    'Abs & core',
    'Mindfulness',
    'Strength,mindfulness',
    'Great From Home',
    'Mobility',
    'Overall Fitness',
   ];
 

   Future<void> _saveVideoDetails() async{
    if(_title != null &&
     _videoUrl != null &&
      _description != null &&
       _imageBytes !=null &&
         _time != null&&
            _selectedCategory != null) {
          final addvideomodel = Addvideomodel(
            discription: _description!,
             title: _title!,
             videoUrl: _videoUrl!,
             imageBytes: _imageBytes!,
              time: _time!,
               selectedCategory: _selectedCategory!,
               index: _selectedCategoryIndex!, 
               
              );
              final Box<Addvideomodel>videoBox = await Hive.box<Addvideomodel>('videos');
              await videoBox.add(addvideomodel);
              debugPrint('added succesfully.');
              
              final Box<int> categoryIndexBox = await Hive.openBox('selected_category_index');
              await categoryIndexBox.put('index',_selectedCategoryIndex!);

              setState(() {
                _title='';
                _videoUrl='';
                _description='';
                _imageBytes=null;
                 _selectedCategory = null;
                _time = '';
                _selectedCategoryIndex = null;
              });          
    }else{
      showDialog(context: context, builder:(BuildContext context){
        return AlertDialog(
          title: const Text('Incomplete Details'),
          content: const Text('please Fill in all the video details'),
          actions: [
            TextButton(onPressed: (){
              Navigator.of(context).pop();
            }, child: const Text('OK'))
          ],
        );
      });
    }
   }

  Future<void> _pickImage() async {
    final PickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(PickedFile != null){
      final imageBytes = await PickedFile.readAsBytes();
      setState(() {
        _imageBytes = imageBytes;
      });
      await Hive.box('images').put('image', imageBytes);
    }
  }
   
    Future<void> _deleteImage() async{
      setState(() {
        _imageBytes = null;
      });
      await Hive.box('images').delete('image');
    }

    @override
  void initState() {
    super.initState();
    _getImageFromHive();
    fetchGreatForHomeVideos();
  }

  Future<void> _getImageFromHive() async {
    final imageBytes = await Hive.box('images').get('image') as Uint8List?;
    if(imageBytes !=null){
      setState(() {
        _imageBytes = imageBytes;
      });
    }
  }

  Future<void> _showOptionsDialog()  async{
    await showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        title: const Text('Choose the either one Option'),
        actions: [
          TextButton(onPressed: _deleteImage,
           child: const Text('Delete Image',
          style: TextStyle(
            color: Colors.red
            ),
          ),
        ),
          TextButton(onPressed: (){
            Navigator.pop(context);
            _viewImageFullScreen();
          }, child: const Text('View Image'),
         )
        ],
      );
     }
   );
 }
   void _viewImageFullScreen() async{
    Navigator.push(context, MaterialPageRoute(
      builder: (context) => Scaffold(
        appBar: AppBar(),
        body: Center(
      child: Hero(
        tag: 'imageFullScreen', 
        child: _imageBytes != null
        ?Image.memory(_imageBytes!,
        fit: BoxFit.cover,)
        :const Text('No Image to Display'
          )
        ),
      ),
    ),
   )
 );
}

 Future<void> fetchGreatForHomeVideos() async{
  final selectedCategoryIndexBox = await Hive.openBox('Selected_category_from_index');
  final int? index = selectedCategoryIndexBox.get('index');

  final box = await Hive.openBox<Addvideomodel>('videos');
  final List<Addvideomodel> allvideos = box.values.toList();

  final List<Addvideomodel> greatForHomeVideos = allvideos
    .where((video) => video.selectedCategory=='Great From Home')
    .toList();

  setState(() {
    videoList = greatForHomeVideos;
  });
}

Future<void> fetchNewWorkoutvideos() async{
  final box = await Hive.openBox<Addvideomodel>('videos');
  final List<Addvideomodel> allVideos = box.values.toList();

   final List<Addvideomodel> newWorkoutVideos = allVideos
    .where((video) => video.selectedCategory != 'Great From Home')
    .toList();

    setState(() {
      videoList = newWorkoutVideos;
    });
}

 void _updateSelectedCategories(String? newValue) {
  if(newValue != null && !selectedCategories.contains(newValue)){
    setState(() {
      selectedCategories.add(newValue);
    });
  }
 }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        leading:IconButton(onPressed: (){
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const AdministrationScreen(),));
         }, icon: const Icon(Icons.arrow_back),
        ), 
        centerTitle: true,
        title: const Text('Add Video'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GestureDetector(
              onTap: _imageBytes != null ? _showOptionsDialog : _pickImage,
              child: Padding(
                padding: const EdgeInsets.all(95.0),
                child: Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black,width: 3)
                    ),
                  child: _imageBytes != null
                  ?Hero(
                    tag: 'imageFullScreen',
                    child: Image.memory(
                      _imageBytes!,
                    fit: BoxFit.cover,
                    ),
                  )
                  :const Center(
                    child: Icon(
                    Icons.add_a_photo,
                    color: Colors.black,
                    ),
                  )
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextFormField(
                    onChanged: (value) {
                      setState(() {
                        _videoUrl = value;
                      });
                    },
                    decoration: const InputDecoration(
                      labelText: 'Video URL',
                      hintText: 'Give Video Link ',
                    ),
                  ),
                     
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    _title = value;
                  });
                },
                decoration: const InputDecoration(
                  labelText: 'Title',
                  hintText: 'Give an Title Here',
                ),
              ),
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    _description = value;
                  });
                },
                decoration: const InputDecoration(
                  labelText: 'Description',
                  hintText: 'Enter the video Description',
                ),
              ),
              TextFormField(
                onChanged: (value){
                  setState(() {
                    _time = value;
                  });
                },
                decoration: const InputDecoration(
                  labelText: 'time',
                  hintText: 'Enter the video duration',
                ),
              ),
              const SizedBox(height: 20,),
              Wrap(
                children: selectedCategories.map((Category){
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(Category,
                    style: TextStyle(color: Colors.white),
                    ),
                    );
                }).toList(),
              ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButtonFormField<String>(
                    value: _selectedCategory,
                    items: categories.map((category) {
                      return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedCategory= newValue;
                      });
                      _updateSelectedCategories(newValue);
                    },
                    decoration: const InputDecoration(
                      labelText: 'category',
                      hintText: 'Select Category',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),


              const SizedBox(height: 20,),
              ElevatedButton(
                onPressed: _saveVideoDetails,
               child: const Text('Feed The Video')),
                ]      
              ), 
            ),
          ],
        ),
      ),
    );
  }
}