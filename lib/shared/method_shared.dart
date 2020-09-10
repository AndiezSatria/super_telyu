part of 'shared.dart';

Future<File> getImage() async {
  var image = await ImagePicker.pickImage(source: ImageSource.gallery);
  return image;
}

Future<Map<String, Object>> getFile() async {
  File file;

  try {
    file = await FilePicker.getFile(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
  } on PlatformException catch (e) {
    print('Error: ${e.message}');
  }
  return {
    'file': file,
    'path': file != null ? file.path : 'Tidak Ada File',
    'fileName': file != null ? file.path.split('/').last : '...'
  };
}

Future<File> getFileFromUrl(String url, String fileName) async {
  try {
    var data = await http.get(url);
    var bytes = data.bodyBytes;
    var dir = await getApplicationDocumentsDirectory();
    File file = File('${dir.path}/$fileName');
    File urlFile = await file.writeAsBytes(bytes);
    print('Test path : ${urlFile.path}');
    return urlFile;
  } catch (e) {
    throw ('Error opening url file');
  }
}

// Future<File> downloadFileFromUrl(String url, String fileName) async {
//   var dir = await getApplicationDocumentsDirectory();
//   try {
//     Dio dio = Dio();

//     await dio
//         .download(
//           url,
//           "${dir.path}/$fileName",
//         )
//         .whenComplete(() => dio.close());
//   } on Exception catch (e) {
//     print(e);
//   }
//   return File('${dir.path}/$fileName');
// }

Future<String> uploadFile(File file, {String name}) async {
  String fileName = name ?? basename(file.path);

  StorageReference ref = FirebaseStorage.instance.ref().child(fileName);
  StorageUploadTask task = ref.putFile(file);
  StorageTaskSnapshot snapshot = await task.onComplete;
  return await snapshot.ref.getDownloadURL();
}

String addFileName(String url) {
  List<String> strings = url.split('.');
  String newName = '${strings[0]}${randomAlphaNumeric(5)}.${strings[1]}';
  print(newName);
  return newName;
}
