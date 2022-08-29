import 'dart:convert';
import 'dart:developer';

import 'package:flutter_notes/model/noteModel.dart';
import 'package:flutter_notes/services/Db.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxList<NoteModel> noteModelList = List<NoteModel>.empty().obs;
  RxBool deleteMode = false.obs;
  RxList<int> deleteNoteModelList = List<int>.empty().obs;
  DateTime? currentBackPressTime;

  void changeDeleteMode() {
    if (deleteMode.value) {
      deleteNoteModelList.value = [];
    }
    deleteMode.value = !deleteMode.value;
  }

  void updateNotesList() {
    noteModelList.value = Db.readNotes().map((e) => noteModelFromJson(jsonEncode(e))).toList();
    noteModelList.value = noteModelList.reversed.toList();
  }

  void addDeleteNoteModel(int value) {
    bool valueBool = false;
    if (deleteNoteModelList.isNotEmpty) {
      for (int i = 0; i < deleteNoteModelList.length; i++) {
        if (deleteNoteModelList[i] == value) {
          deleteNoteModelList.removeAt(i);
          valueBool = true;
          break;
        }
      }
    }
    if (!valueBool) {
      deleteNoteModelList.add(value);
    }
  }

  void deleteNote({bool changeDeleteM = false}) {
    Db.deleteNote(deleteNoteModelList);
    updateNotesList();
    if (noteModelList.isEmpty && changeDeleteM) {
      changeDeleteMode();
    }
  }

  Future<bool> onWillPop() async {
    if (deleteMode.value) {
      changeDeleteMode();
      return false;
    } else {
      DateTime now = DateTime.now();
      if (currentBackPressTime == null || now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
        currentBackPressTime = now;
        Get.showSnackbar(
          GetSnackBar(
            backgroundColor: Get.theme.primaryColor,
            duration: const Duration(seconds: 2),
            message: "Press one more time to exit",
          ),
        );
        return Future.value(false);
      }

      return Future.value(true);
    }
  }
}
