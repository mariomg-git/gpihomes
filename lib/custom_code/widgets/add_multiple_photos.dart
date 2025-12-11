// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'index.dart'; // Imports other custom widgets
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:typed_data';
import 'dart:io';

class AddMultiplePhotos extends StatefulWidget {
  const AddMultiplePhotos({
    super.key,
    this.width,
    this.height,
    this.idPropiedad,
  });

  final double? width;
  final double? height;
  final String? idPropiedad;

  @override
  State<AddMultiplePhotos> createState() => _AddMultiplePhotosState();
}

class _AddMultiplePhotosState extends State<AddMultiplePhotos> {
  final List<Map<String, dynamic>> _images = [];
  final _descriptionController = TextEditingController();
  bool _isLoading = false;

  Future<void> _pickImage() async {
    if (kIsWeb) {
      // Web platform
      final result = await FilePicker.platform.pickFiles(type: FileType.image);
      if (result != null && result.files.first.bytes != null) {
        setState(() {
          _images.add({
            'file': result.files.first.bytes,
            'description': '',
          });
        });
      }
    } else {
      // Mobile platform
      final result = await FilePicker.platform.pickFiles(type: FileType.image);
      if (result != null && result.files.first.path != null) {
        final bytes = await File(result.files.first.path!).readAsBytes();
        setState(() {
          _images.add({
            'file': bytes,
            'description': '',
          });
        });
      }
    }
  }

  Future<void> _saveImagesToFirestore() async {
    setState(() {
      _isLoading = true;
    });

    final firestore = FirebaseFirestore.instance;
    final storage = FirebaseStorage.instance;
    final documentRef = firestore.doc('properties/' + widget.idPropiedad!);

    List<Map<String, dynamic>> imagesToSave = [];

    for (var image in _images) {
      final storageRef =
          storage.ref().child('images/${DateTime.now().toIso8601String()}');
      final uploadTask = storageRef.putData(image['file']);
      final snapshot = await uploadTask;
      final imageUrl = await snapshot.ref.getDownloadURL();

      imagesToSave.add({
        'imageUrl': imageUrl,
        'description': image['description'],
      });
    }

    await documentRef.update({
      'images': FieldValue.arrayUnion(imagesToSave),
    });

    setState(() {
      _isLoading = false;
    });

    _showAlertDialog('Exito', 'Imagenes Guardadas Correctamente.');
  }

  void _showAlertDialog(String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showImageModal(Uint8List imageData) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Stack(
            children: [
              Container(
                width: double.maxFinite,
                child: Image.memory(imageData, fit: BoxFit.contain),
              ),
              Positioned(
                right: 0,
                child: IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white, // Fondo blanco
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 30,
              ),
              Container(),
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton.icon(
                icon: Icon(Icons.image),
                label: Text('Agregar Imagen'),
                onPressed: _pickImage,
              ),
              TextButton.icon(
                icon: Icon(Icons.save),
                label: Text('Guardar'),
                onPressed: _saveImagesToFirestore,
              ),
            ],
          ),
          if (_isLoading)
            Center(
              child: CircularProgressIndicator(),
            ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: _images.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {
                          _showImageModal(_images[index]['file']);
                        },
                        leading: kIsWeb
                            ? Image.memory(_images[index]['file'])
                            : Image.memory(_images[index]['file']),
                        title: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                onChanged: (value) {
                                  setState(() {
                                    _images[index]['description'] = value;
                                  });
                                },
                                decoration: InputDecoration(
                                    hintText:
                                        'Escriba una Descripción de la Foto'),
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () async {
                                setState(() {
                                  _images.removeAt(index);
                                });
                                _showAlertDialog(
                                    'Borrado', 'Imagen fue Borrada.');
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
