import 'package:code_quest/core/local_storage/storage_helper.dart';
import 'package:code_quest/core/utils/constants.dart';
import 'package:code_quest/core/utils/extension.dart';
import 'package:code_quest/core/utils/popup_dialogs.dart';
import 'package:code_quest/shared_widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../core/theme/color_manager.dart';
import '../../../core/theme/text_styles_manager.dart';
import '../data/models/specialist_model.dart';

class SpecialistBottomSheet extends StatefulWidget {
  final SpecialistModel specialist;
  final Function(String) onMakeAppointment;
  const SpecialistBottomSheet(
      {super.key, required this.specialist, required this.onMakeAppointment});

  @override
  State<SpecialistBottomSheet> createState() => _SpecialistBottomSheetState();
}

class _SpecialistBottomSheetState extends State<SpecialistBottomSheet> {
  String? selectedDate;
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 800,
      width: 1.sw,
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.bottomLeft,
                  children: [
                    Image.network(
                      widget.specialist.image,
                      height: 0.3.sh,
                      width: 1.sw,
                      fit: BoxFit.fill,
                    ),
                    Container(
                      height: 0.3.sh,
                      width: 1.sw,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: <Color>[
                              Colors.white.withOpacity(0.05),
                              Colors.white.withOpacity(0.5),
                              Colors.white
                            ]),
                      ),
                    ),
                    ListTile(
                      title: Text(widget.specialist.name,
                          style: getSemiBoldStyle(fontSize: 0.018.sh)),
                      subtitle: Text(widget.specialist.specialization,
                          style: getRegularStyle(fontSize: 0.016.sh)),
                    ),
                  ],
                ),
                5.verticalSpace,
                Center(
                  child: Text(widget.specialist.bio,
                      textAlign: TextAlign.center,
                      style: getRegularStyle(
                          fontSize: 0.018.sh,
                          color: ColorManager.subTitleColor)),
                ),
                15.verticalSpace,
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ExpansionTile(
                      key: GlobalKey(),
                      dense: true,
                      backgroundColor: ColorManager.lightPrimary,
                      collapsedBackgroundColor: ColorManager.lightPrimary,
                      shape: const ContinuousRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      collapsedShape: const ContinuousRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      title: Container(
                        width: 1.sw,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            if (selectedDate == null)
                              Text(
                                'Select Date',
                                style: getRegularStyle(fontSize: 0.018.sh),
                              )
                            else
                              Text(
                                selectedDate!.toFormattedDateTime(),
                                style: getRegularStyle(fontSize: 0.016.sh),
                              ),
                          ],
                        ),
                      ),
                      // showTrailingIcon: false,
                      children: List.generate(
                          widget.specialist.availability.length, (i) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24.0, vertical: 16),
                          child: InkWell(
                            onTap: () {
                              if (widget.specialist.availability[i].available) {
                                setState(() {
                                  selectedDate =
                                      widget.specialist.availability[i].date;
                                });
                              }
                            },
                            child: Row(
                              children: [
                                if (widget.specialist.availability[i].date !=
                                    null)
                                  Text(
                                    widget.specialist.availability[i].date!
                                        .toFormattedDateTime(),
                                    style: getRegularStyle(fontSize: 0.016.sh)
                                        .copyWith(
                                            decoration: widget.specialist
                                                    .availability[i].available
                                                ? null
                                                : TextDecoration.lineThrough),
                                  ),
                              ],
                            ),
                          ),
                        );
                      })),
                ),
              ],
            ),
          ),
          if (loading)
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: CircularProgressIndicator(
                  color: ColorManager.primary,
                ),
              ),
            )
          else
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: DefaultButton(
                    fontSize: 0.02.sh,
                    radius: 12,
                    height: 0.06.sh,
                    width: 1.sw,
                    color: ColorManager.primary,
                    textStyle: getMediumStyle(color: Colors.white),
                    title: 'Make Appointment',
                    onTap: () {
                      if (selectedDate == null) {
                        PopupDialogs.showToast(
                          "Please select date",
                        );
                      } else {
                        int limit =
                            LocalStorage.getData(key: Constants.limit) ?? 0;
                        if (limit < 5) {
                          LocalStorage.saveData(
                              key: Constants.limit, value: limit + 1);
                          widget.onMakeAppointment.call(
                            selectedDate!,
                          );
                          setState(() {
                            loading = true;
                          });
                        } else {
                          PopupDialogs.showToast(
                              "You have reached the maximum number of appointments");
                        }
                      }
                    }),
              ),
            )
        ],
      ),
    );
  }
}
