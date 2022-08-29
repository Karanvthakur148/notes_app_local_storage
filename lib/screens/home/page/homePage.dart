import 'package:flutter/material.dart';
import 'package:flutter_notes/appConfigs/appColors.dart';
import 'package:flutter_notes/model/noteModel.dart';
import 'package:flutter_notes/screens/addNote/controller/addNoteController.dart';
import 'package:flutter_notes/screens/addNote/page/addNotePage.dart';
import 'package:flutter_notes/screens/home/controller/homeController.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  static const String routeName = "/homePage";
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    controller.updateNotesList();
  }

  HomeController controller = Get.find();
  AddNoteController addNoteController = Get.find();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: controller.onWillPop,
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          toolbarHeight: 70.h,
          title: Text(
            "Notes",
            style: TextStyle(fontSize: 24.sp),
          ),
          actions: [
            Obx(
              () => AnimatedOpacity(
                duration: const Duration(seconds: 1),
                opacity: controller.deleteMode.value ? 1.0 : 0.0,
                child: controller.deleteMode.value
                    ? IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          controller.changeDeleteMode();
                          controller.deleteNoteModelList.clear();
                        },
                      )
                    : const SizedBox(),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 15.w,
          ),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Obx(
              () => StaggeredGrid.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10.w,
                mainAxisSpacing: 10.h,
                children: controller.noteModelList
                    .map(
                      (element) => noteCard(element),
                    )
                    .toList(),
              ),
            ),
          ),
        ),
        floatingActionButton: Obx(
          () => FloatingActionButton(
            child: AnimatedSwitcher(
              duration: const Duration(seconds: 1),
              child: controller.deleteMode.value
                  ? Icon(
                      Icons.delete,
                      size: 25.r,
                    )
                  : Icon(
                      Icons.add,
                      size: 25.r,
                    ),
            ),
            onPressed: () {
              if (controller.deleteMode.value) {
                controller.deleteNote(changeDeleteM: true);
              } else {
                Get.toNamed(
                  AddNotePage.routeName,
                );
              }
            },
          ),
        ),
      ),
    );
  }

  GestureDetector noteCard(NoteModel element) {
    return GestureDetector(
      onLongPress: () {
        controller.addDeleteNoteModel(int.parse(element.id!));
        controller.changeDeleteMode();
      },
      onTap: () {
        if (controller.deleteMode.value) {
          controller.addDeleteNoteModel(int.parse(element.id!));
        } else {
          Get.toNamed(AddNotePage.routeName, arguments: element);
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 10.h,
          horizontal: 5.w,
        ).copyWith(left: 10.w),
        decoration: BoxDecoration(
          color: Color(AppColors.themeList[int.parse(element.colorId!)]),
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: const [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Visibility(
              visible: element.title != "",
              child: Text(
                element.title!,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.sp,
                ),
              ),
              replacement: const SizedBox(),
            ),
            Visibility(
              visible: element.subTitle! != "",
              child: Column(
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    element.subTitle!,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              replacement: const SizedBox(),
            ),
            SizedBox(
              height: 15.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  element.date.toString(),
                  style: TextStyle(
                    color: Colors.grey.shade700,
                  ),
                ),
                Visibility(
                  visible: controller.deleteMode.value,
                  child: GestureDetector(
                    onTap: () {
                      controller.addDeleteNoteModel(int.parse(element.id!));
                    },
                    child: Container(
                      margin: const EdgeInsets.only(
                        right: 5,
                      ),
                      height: 17.h,
                      width: 17.w,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: controller.deleteNoteModelList.contains(int.parse(element.id!))
                          ? const FittedBox(
                              child: Icon(
                                Icons.done,
                              ),
                            )
                          : const SizedBox(),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
