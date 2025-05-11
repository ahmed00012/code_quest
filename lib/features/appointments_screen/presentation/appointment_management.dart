import 'package:code_quest/core/utils/extension.dart';
import 'package:code_quest/core/utils/popup_dialogs.dart';
import 'package:code_quest/features/appointments_screen/data/models/appointments_model.dart';
import 'package:code_quest/shared_widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../../core/theme/color_manager.dart';
import '../../../core/theme/text_styles_manager.dart';
import '../../providers_screen/data/models/specialist_model.dart';

class AppointmentBottomSheet extends StatefulWidget {
  final AppointmentsModel appointment;
  final Function(String) onEditAppointment;
  final VoidCallback onDelete;
  const AppointmentBottomSheet(
      {super.key,
      required this.appointment,
      required this.onEditAppointment,
      required this.onDelete});

  @override
  State<AppointmentBottomSheet> createState() => _AppointmentBottomSheetState();
}

class _AppointmentBottomSheetState extends State<AppointmentBottomSheet> {
  String? selectedDate;
  bool loading = false;

  @override
  void initState() {
    selectedDate = widget.appointment.date;
    super.initState();
  }

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
                      widget.appointment.specialist!.image,
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
                      title: Text(widget.appointment.specialist!.name,
                          style: getSemiBoldStyle(fontSize: 0.018.sh)),
                      subtitle: Text(
                          widget.appointment.specialist!.specialization,
                          style: getRegularStyle(fontSize: 0.016.sh)),
                    ),
                  ],
                ),
                5.verticalSpace,
                Center(
                  child: Text(widget.appointment.specialist!.bio,
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
                                'Select Day',
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
                          widget.appointment.specialist!.availability.length,
                          (i) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24.0, vertical: 16),
                          child: InkWell(
                            onTap: () {
                              if (widget.appointment.specialist!.availability[i]
                                  .available) {
                                setState(() {
                                  selectedDate = widget.appointment.specialist!
                                      .availability[i].date;
                                });
                              }
                            },
                            child: Row(
                              children: [
                                if (widget.appointment.specialist!
                                        .availability[i].date !=
                                    null)
                                  Text(
                                    widget.appointment.specialist!
                                        .availability[i].date!
                                        .toFormattedDateTime(),
                                    style: getRegularStyle(fontSize: 0.016.sh)
                                        .copyWith(
                                            decoration: widget
                                                    .appointment
                                                    .specialist!
                                                    .availability[i]
                                                    .available
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    DefaultButton(
                      fontSize: 0.02.sh,
                      radius: 12,
                      height: 0.06.sh,
                      width: 0.42.sw,
                      color: selectedDate != widget.appointment.date
                          ? ColorManager.primary
                          : ColorManager.inActive,
                      textStyle: getMediumStyle(color: Colors.white),
                      title: 'Edit Appointment',
                      onTap: () {
                        if (selectedDate == widget.appointment.date) {
                          PopupDialogs.showToast(
                            "Please select date and time",
                          );
                        } else {
                          widget.onEditAppointment.call(selectedDate!);
                          setState(() {
                            loading = true;
                          });
                        }
                      },
                    ),
                    DefaultButton(
                      fontSize: 0.02.sh,
                      radius: 12,
                      height: 0.06.sh,
                      width: 0.42.sw,
                      color: DateTime.parse(selectedDate!).day <
                                  DateTime.now().day ||
                              DateTime.parse(selectedDate!).month <
                                  DateTime.now().month ||
                              DateTime.parse(selectedDate!).year <
                                  DateTime.now().year
                          ? ColorManager.inActive
                          : ColorManager.redSelected,
                      textStyle: getMediumStyle(color: Colors.white),
                      title: 'Cancel Appointment',
                      onTap: () {
                        if (DateTime.parse(selectedDate!).day >
                                DateTime.now().day ||
                            DateTime.parse(selectedDate!).month >
                                DateTime.now().month ||
                            DateTime.parse(selectedDate!).year >
                                DateTime.now().year) {
                          widget.onDelete.call();
                        } else {
                          PopupDialogs.showToast(
                            "You can not cancel this appointment",
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            )
        ],
      ),
    );
  }
}
