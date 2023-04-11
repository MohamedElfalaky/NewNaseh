import 'package:image_picker/image_picker.dart';

class Reisteration3Controller {
  final ImagePicker _picker = ImagePicker();

  Future pickImage(ImageSource source) async {
    await _picker.pickImage(source: source);
  }
}
