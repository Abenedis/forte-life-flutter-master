import 'dart:io';

import 'package:flutter/material.dart';
import 'package:forte_life/app/colors.dart';
import 'package:forte_life/ui/widget/photo/photo_controller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class PhotoWidget extends StatelessWidget {
  const PhotoWidget({
    Key key,
    this.controller,
    this.title = '',
    this.description = '',
  }) : super(key: key);

  final PhotoController controller;
  final String title;
  final String description;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 24.0,
            bottom: 24.0,
          ),
          child: Text(
            title,
            style: GoogleFonts.roboto(
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        StreamBuilder<List<File>>(
            stream: controller.imagesStream,
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data.isNotEmpty)
                return SizedBox(
                  height: 66,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.all(8.0)
                        .copyWith(top: 0.0, bottom: 16),
                    children: snapshot.data
                        .map<Widget>(
                          (e) => Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: InkWell(
                              child: Image.file(e, height: 50),
                              onTap: () => controller.onDeletePhoto(e),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                );
              return const SizedBox.shrink();
            }),
        OutlineButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          borderSide: BorderSide(
            color: StandardColors.selectedColor,
            width: 2,
            style: BorderStyle.solid,
          ),
          textColor: StandardColors.selectedColor,
          highlightedBorderColor: StandardColors.selectedColor,
          // onPressed: controller.addPhoto,
          onPressed: () => onAddPhotoPressed(context),
          padding: EdgeInsets.zero,
          child: SizedBox(
            height: 56,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.photo_camera),
                  SizedBox(width: 16.0),
                  Text('Додати фото'),
                ],
              ),
            ),
          ),
        ),
        if (description.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(
              bottom: 8.0,
              top: 16.0,
            ),
            child: Text(
              description,
              style: TextStyle(
                fontSize: 14,
              ),
            ),
          ),
        Padding(
          padding: const EdgeInsets.only(
            bottom: 8.0,
            top: 4.0,
          ),
          child: StreamBuilder<bool>(
            stream: controller.isHasErroStream,
            initialData: false,
            builder: (context, snapshot) {
              if (snapshot.data)
                return Text(
                  'Потрібно додати фото',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.red,
                  ),
                );
              return const SizedBox.shrink();
            },
          ),
        ),
      ],
    );
  }

  void onAddPhotoPressed(BuildContext context) {
    if (controller.isFullContainer)
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Увага'),
          content: Text('Максимальна кількість фото ${controller.length} шт.'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: Text('OK'),
            )
          ],
        ),
      );
    else
      showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(25.0),
          ),
        ),
        builder: (ctx) => SizedBox(
          height: 250,
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              children: <Widget>[
                Text(
                  'Додати фото',
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                SizedBox(height: 25),
                OutlineButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  borderSide: BorderSide(
                    color: StandardColors.selectedColor,
                    width: 2,
                    style: BorderStyle.solid,
                  ),
                  textColor: StandardColors.selectedColor,
                  highlightedBorderColor: StandardColors.selectedColor,
                  onPressed: () => controller
                      .addPhoto()
                      .whenComplete(() => Navigator.of(ctx).pop()),
                  padding: EdgeInsets.zero,
                  child: SizedBox(
                    height: 56,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.photo_library),
                          SizedBox(width: 16.0),
                          Text('Відкрити галерею'),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 25),
                OutlineButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  borderSide: BorderSide(
                    color: StandardColors.selectedColor,
                    width: 2,
                    style: BorderStyle.solid,
                  ),
                  textColor: StandardColors.selectedColor,
                  highlightedBorderColor: StandardColors.selectedColor,
                  onPressed: () => controller
                      .addPhoto(source: ImageSource.camera)
                      .whenComplete(() => Navigator.of(ctx).pop()),
                  padding: EdgeInsets.zero,
                  child: SizedBox(
                    height: 56,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.photo_camera),
                          SizedBox(width: 16.0),
                          Text('Відкрити камеру'),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
  }
}
