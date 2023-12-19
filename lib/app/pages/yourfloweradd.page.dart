import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'yourflow.page.dart' as yourflow;

class YourFlowerAddPage extends StatefulWidget {
  const YourFlowerAddPage({Key? key}) : super(key: key);

  @override
  _YourFlowerAddPageState createState() => _YourFlowerAddPageState();
}

class _YourFlowerAddPageState extends State<YourFlowerAddPage> {
  late ImagePicker _imagePicker;
  File? _pickedImage;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _imagePicker = ImagePicker();
    _loadSavedData();
  }

  Future<void> _pickImage() async {
    final XFile? pickedImage = await _imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );

    setState(() {
      if (pickedImage != null) {
        _pickedImage = File(pickedImage.path);
      }
    });
  }

  void _saveFlower() async {
    if (_formKey.currentState!.validate()) {
      String id = DateTime.now().millisecondsSinceEpoch.toString();

      yourflow.Flower newFlower = yourflow.Flower(
        id: id,
        name: _nameController.text,
        description: _descriptionController.text,
        imageUrl: _pickedImage != null ? _pickedImage!.path : '',
        notes: _notesController.text,
      );

      Provider.of<yourflow.FlowerNotifier>(context, listen: false).addFlower(newFlower);
      _saveFlowers();

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('flower_name', _nameController.text);
      prefs.setString('flower_description', _descriptionController.text);
      prefs.setString('flower_notes', _notesController.text);

      if (_pickedImage != null) {
        prefs.setString('flower_image_path', _pickedImage!.path);
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Flower saved successfully!'),
          duration: Duration(seconds: 2),
        ),
      );

      Navigator.pop(context);
    }
  }

  void _loadSavedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _nameController.text = prefs.getString('flower_name') ?? '';
      _descriptionController.text = prefs.getString('flower_description') ?? '';
      _notesController.text = prefs.getString('flower_notes') ?? '';

      String? imagePath = prefs.getString('flower_image_path');
      if (imagePath != null) {
        _pickedImage = File(imagePath);
      }
    });
  }

  void _saveFlowers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> flowerList = Provider
        .of<yourflow.FlowerNotifier>(context, listen: false)
        .flowers
        .map((flower) => flower.toJsonString())
        .toList();

    prefs.setStringList('flowers', flowerList);
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(393, 873));
    return Scaffold(
      backgroundColor: const Color.fromRGBO(235, 255, 240, 1),
      appBar: AppBar(
        title: Text(
          'Add flower',
          style: GoogleFonts.nunito(
            textStyle: TextStyle(
              color: Colors.black,
              fontSize: ScreenUtil().setSp(17),
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        backgroundColor: const Color.fromRGBO(235, 255, 240, 1),
        iconTheme: const IconThemeData(color: Color.fromRGBO(210, 59, 106, 1)),
        elevation: 0,
        toolbarHeight: ScreenUtil().setHeight(44),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(ScreenUtil().setWidth(16)),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    _pickImage();
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                  child: Container(
                    width: ScreenUtil().setWidth(200),
                    height: ScreenUtil().setHeight(200),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(
                        ScreenUtil().setWidth(4),
                      ),
                      border: Border.all(
                        color: const Color.fromRGBO(70, 180, 48, 1),
                        width: ScreenUtil().setWidth(1),
                      ),
                    ),
                    child: Center(
                      child: _pickedImage == null
                          ? Icon(
                        Icons.image_search,
                        size: ScreenUtil().setSp(40),
                        color: const Color.fromRGBO(70, 180, 48, 0.7),
                      )
                          : Image.file(
                        _pickedImage!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: ScreenUtil().setHeight(30)),
                TextFormField(
                  controller: _nameController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: 'Flower name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        ScreenUtil().setWidth(4),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        ScreenUtil().setWidth(4),
                      ),
                      borderSide: BorderSide(
                        color: const Color.fromRGBO(70, 180, 48, 1),
                        width: ScreenUtil().setWidth(1),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        ScreenUtil().setWidth(4),
                      ),
                      borderSide: BorderSide(
                        color: const Color.fromRGBO(70, 180, 48, 1),
                        width: ScreenUtil().setWidth(1),
                      ),
                    ),
                    labelText: 'Name',
                    labelStyle: GoogleFonts.nunito(
                      textStyle: TextStyle(
                        fontSize: ScreenUtil().setSp(14),
                        color: const Color.fromRGBO(70, 180, 48, 1),
                      ),
                    ),
                    hintStyle: GoogleFonts.nunito(
                      textStyle: TextStyle(
                        fontSize: ScreenUtil().setSp(14),
                        color: const Color.fromRGBO(70, 180, 48, 1),
                      ),
                    ),
                  ),
                  style: GoogleFonts.nunito(
                    textStyle: TextStyle(
                      fontSize: ScreenUtil().setSp(14),
                      color: Colors.black,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter flower name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: ScreenUtil().setHeight(30)),
                TextFormField(
                  controller: _descriptionController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: 'Description',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        ScreenUtil().setWidth(4),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        ScreenUtil().setWidth(4),
                      ),
                      borderSide: BorderSide(
                        color: const Color.fromRGBO(70, 180, 48, 1),
                        width: ScreenUtil().setWidth(1),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        ScreenUtil().setWidth(4),
                      ),
                      borderSide: BorderSide(
                        color: const Color.fromRGBO(70, 180, 48, 1),
                        width: ScreenUtil().setWidth(1),
                      ),
                    ),
                    labelText: 'Description',
                    labelStyle: GoogleFonts.nunito(
                      textStyle: TextStyle(
                        fontSize: ScreenUtil().setSp(14),
                        color: const Color.fromRGBO(70, 180, 48, 1),
                      ),
                    ),
                    hintStyle: GoogleFonts.nunito(
                      textStyle: TextStyle(
                        fontSize: ScreenUtil().setSp(14),
                        color: const Color.fromRGBO(70, 180, 48, 1),
                      ),
                    ),
                  ),
                  style: GoogleFonts.nunito(
                    textStyle: TextStyle(
                      fontSize: ScreenUtil().setSp(14),
                      color: Colors.black,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter description';
                    }
                    return null;
                  },
                ),
                SizedBox(height: ScreenUtil().setHeight(30)),
                TextFormField(
                  controller: _notesController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: 'Notes',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        ScreenUtil().setWidth(4),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        ScreenUtil().setWidth(4),
                      ),
                      borderSide: BorderSide(
                        color: const Color.fromRGBO(70, 180, 48, 1),
                        width: ScreenUtil().setWidth(1),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        ScreenUtil().setWidth(4),
                      ),
                      borderSide: BorderSide(
                        color: const Color.fromRGBO(70, 180, 48, 1),
                        width: ScreenUtil().setWidth(1),
                      ),
                    ),
                    labelText: 'Notes',
                    labelStyle: GoogleFonts.nunito(
                      textStyle: TextStyle(
                        fontSize: ScreenUtil().setSp(14),
                        color: const Color.fromRGBO(70, 180, 48, 1),
                      ),
                    ),
                    hintStyle: GoogleFonts.nunito(
                      textStyle: TextStyle(
                        fontSize: ScreenUtil().setSp(14),
                        color: const Color.fromRGBO(70, 180, 48, 1),
                      ),
                    ),
                  ),
                  style: GoogleFonts.nunito(
                    textStyle: TextStyle(
                      fontSize: ScreenUtil().setSp(14),
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _saveFlower,
        backgroundColor: const Color.fromRGBO(210, 59, 106, 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ScreenUtil().setWidth(16)),
        ),
        mini: false,
        child: const Icon(Icons.check),
      ),
    );
  }
}
