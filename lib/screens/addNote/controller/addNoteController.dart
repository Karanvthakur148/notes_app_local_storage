import 'package:flutter/cupertino.dart';
import 'package:flutter_notes/model/noteModel.dart';
import 'package:flutter_notes/screens/home/controller/homeController.dart';
import 'package:flutter_notes/services/Db.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddNoteController extends GetxController {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController subTitleController = TextEditingController();
  HomeController homeController = Get.find();
  Rx<int> colorId = 0.obs;

  void changeColorId(int i) {
    colorId.value = i;
  }

  void submitNote(NoteModel? model) {
    NoteModel noteModel = NoteModel(
      title: titleController.text,
      subTitle: subTitleController.text,
      date: DateFormat("MMMM dd, yyyy").format(DateTime.now()),
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      colorId: colorId.value.toString(),
    );
    if (titleController.text != "" || subTitleController.text != "") {
      if (model != null) {
        Db.updateNotes(previousModel: model, newModel: noteModel);
      } else {
        Db.writeNotes(noteModel);
      }
    } else {
      if (model != null) {
        homeController.addDeleteNoteModel(int.parse(model.id!));
        homeController.deleteNote();
      }
    }
  }
}
