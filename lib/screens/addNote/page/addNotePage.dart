import 'package:flutter/material.dart';
import 'package:flutter_notes/appConfigs/appColors.dart';
import 'package:flutter_notes/appConfigs/appImages.dart';
import 'package:flutter_notes/model/noteModel.dart';
import 'package:flutter_notes/screens/addNote/controller/addNoteController.dart';
import 'package:flutter_notes/screens/home/controller/homeController.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AddNotePage extends StatefulWidget {
  static const String routeName = "/addNotePage";
  const AddNotePage({Key? key}) : super(key: key);

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  AddNoteController controller = Get.find();
  HomeController homeController = Get.find();

  @override
  void initState() {
    NoteModel? model = Get.arguments;
    if (model != null) {
      controller.titleController.text = model.title!;
      controller.subTitleController.text = model.subTitle!;
      controller.changeColorId(int.parse(model.colorId!));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        NoteModel? model = Get.arguments;
        controller.submitNote(model);
        homeController.updateNotesList();
        Get.back(canPop: true);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          leadingWidth: 80.w,
          leading: Row(
            children: [
              SizedBox(
                width: 5.w,
              ),
              GestureDetector(
                onTap: () {
                  NoteModel? model = Get.arguments;
                  controller.submitNote(model);
                  homeController.updateNotesList();
                  Get.back(canPop: false);
                },
                child: Container(
                  margin: EdgeInsets.symmetric(
                    vertical: 8.h,
                    horizontal: 10.w,
                  ),
                  padding: EdgeInsets.only(
                    left: 10.w,
                  ),
                  height: 40.h,
                  width: 40.w,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: 20.h,
                  ),
                ),
              ),
            ],
          ),
          actions: [
            Builder(
              builder: (context) {
                return IconButton(
                  onPressed: () {
                    showBottomSheet(
                      enableDrag: true,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.r),
                          topRight: Radius.circular(20.r),
                        ),
                      ),
                      context: context,
                      builder: (context) => Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 20.h,
                          horizontal: 20.w,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Select Theme',
                                  style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.close),
                                  onPressed: () {
                                    Get.back();
                                  },
                                )
                              ],
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            GridView.builder(
                              shrinkWrap: true,
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 5,
                                crossAxisSpacing: 5.0,
                                mainAxisSpacing: 5.0,
                              ),
                              itemCount: AppColors.themeList.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    controller.changeColorId(index);
                                  },
                                  child: CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Color(
                                      AppColors.themeList[index],
                                    ),
                                    child: Obx(
                                      () => Visibility(
                                        visible: controller.colorId.value == index,
                                        child: Icon(
                                          Icons.done,
                                          color: Colors.white,
                                          size: 30.r,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  icon: Obx(
                    () => Image.asset(
                      AppImages.shirt,
                      color: Color(
                        AppColors.themeList[controller.colorId.value],
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(
              width: 5.w,
            )
          ],
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.only(
            left: 16.w,
            right: 16.w,
            bottom: 10.h,
          ),
          child: Form(
            key: controller.formkey,
            child: Column(
              children: [
                TextFormField(
                  controller: controller.titleController,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  cursorColor: Colors.white,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.sp,
                  ),
                  decoration: InputDecoration(
                    hintText: "Title",
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 24.sp,
                    ),
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                TextFormField(
                  controller: controller.subTitleController,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  cursorColor: Colors.white,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.sp,
                    height: 1.3,
                  ),
                  decoration: InputDecoration(
                    hintText: "Start typing",
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 19.sp,
                    ),
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.titleController.clear();
    controller.subTitleController.clear();
    controller.changeColorId(0);
    super.dispose();
  }
}
