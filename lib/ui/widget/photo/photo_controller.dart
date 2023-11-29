import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:rxdart/rxdart.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class PhotoController {
  final int length;
  final BehaviorSubject<List<File>> _imageSubject =
      BehaviorSubject<List<File>>()..add(<File>[]);
  final BehaviorSubject<bool> _validationError = BehaviorSubject<bool>()
    ..add(false);
  final ImagePicker _picker = ImagePicker();

  PhotoController(this.length);

  Stream<List<File>> get imagesStream => _imageSubject.stream;
  Stream<bool> get isHasErroStream => _validationError.stream;

  Future<void> addPhoto({ImageSource source = ImageSource.gallery}) async {
    if (source == ImageSource.gallery) {
      final List<Asset> _images = await MultiImagePicker.pickImages(
        maxImages: length - _imageSubject.value.length,
        enableCamera: false,
        cupertinoOptions: CupertinoOptions(
          takePhotoIcon: "chat",
        ),
        materialOptions: MaterialOptions(
          actionBarColor: "#FF0000",
          actionBarTitle: "ForteLife",
          allViewTitle: "All Photos",
          useDetailsView: false,
          statusBarColor: "#FF0000",
          selectCircleStrokeColor: "#FF0000",
        ),
      );
      Future.forEach<Asset>(_images, (element) async {
        final byteData = await element.getByteData(quality: 50);
        final file = File(join(
          (await getTemporaryDirectory()).path,
          '${DateTime.now().millisecond}.jpg',
        ));
        await file.writeAsBytes(byteData.buffer
            .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

        _imageSubject.add(_imageSubject.value..add(file));
      });

      _validationError.add(false);
    } else {
      final PickedFile image = await _picker.getImage(
        source: source,
        imageQuality: 50,
      );
      if (image != null) {
        final imageFile = File(image.path);
        _imageSubject.add(_imageSubject.value..add(imageFile));
        _validationError.add(false);
      }
    }
  }

  void onDeletePhoto(File file) => _imageSubject.add(
        _imageSubject.value..remove(file),
      );

  bool get isFullContainer => _imageSubject.value.length == length;

  bool validate() {
    final isError = _imageSubject.value.isEmpty;
    _validationError.add(isError);
    return isError;
  }

  List<String> getBase64Images() => _imageSubject.value
      ?.map<String>((f) => base64Encode(f.readAsBytesSync()))
      ?.toList();

  void dispose() {
    _validationError?.close();
    _imageSubject?.close();
  }
}
