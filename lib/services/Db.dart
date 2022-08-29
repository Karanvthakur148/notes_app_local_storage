import 'dart:convert';

import 'package:flutter_notes/model/noteModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Db {
  static late final SharedPreferences _storage;

  static Future<void> init() async {
    _storage = await SharedPreferences.getInstance();
  }

  static const String _notesList = "NotesList";

  static Future<void> writeNotes(NoteModel noteModel) async {
    String? notesListString = _storage.getString(_notesList);

    List notesList = [];
    if (notesListString == null) {
    } else {
      notesList = jsonDecode(notesListString);
    }
    if (notesListString == "") {
      _storage.setString(_notesList, jsonEncode([noteModel.toJson()]));
    } else {
      notesList.add(noteModel.toJson());
      _storage.setString(_notesList, jsonEncode(notesList));
    }
  }

  static List readNotes() {
    List noteModelList = [];
    String? notesListString = _storage.getString(_notesList);
    if (notesListString == null) {
    } else {
      noteModelList = jsonDecode(notesListString);
    }
    return noteModelList;
  }

  static updateNotes({required NoteModel previousModel, required NoteModel newModel}) {
    List<NoteModel> listNotes = readNotes().map((e) => noteModelFromJson(jsonEncode(e))).toList();
    for (int i = 0; i < listNotes.length; i++) {
      if (listNotes[i].id == previousModel.id) {
        NoteModel noteModel = newModel;
        noteModel.id = previousModel.id;
        listNotes.removeAt(i);
        listNotes.insert(i, noteModel);
        break;
      }
    }
    _storage.setString(_notesList, jsonEncode(listNotes.map((e) => e.toJson()).toList()));
  }

  static void deleteNote(List<int> listId) {
    List<NoteModel> listNotes = readNotes().map((e) => noteModelFromJson(jsonEncode(e))).toList();
    List<NoteModel> tempListNotes = listNotes;
    for (int j = 0; j < listId.length; j++) {
      for (int i = 0; i < listNotes.length; i++) {
        if (listId[j] == int.parse(listNotes[i].id!)) {
          tempListNotes.removeAt(i);
          break;
        }
      }
    }
    _storage.setString(_notesList, jsonEncode(tempListNotes.map((e) => e.toJson()).toList()));
  }

  static void clearDb() {
    _storage.clear();
  }
}
