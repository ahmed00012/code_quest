import 'package:code_quest/core/theme/color_manager.dart';
import 'package:code_quest/core/theme/text_styles_manager.dart';
import 'package:code_quest/core/utils/extension.dart';
import 'package:code_quest/features/providers_screen/presentation/bloc/specialists_state.dart';
import 'package:code_quest/features/providers_screen/presentation/specialist_bottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/service_injection/injection_imports.dart';
import '../../../core/utils/popup_dialogs.dart';
import '../data/models/appointments_model.dart';
import 'appointment_management.dart';
import 'bloc/appointments_bloc.dart';
import 'bloc/appointments_event.dart';
import 'package:intl/intl.dart';

import 'bloc/appointments_state.dart';

class AppointmentsScreen extends StatefulWidget {
  const AppointmentsScreen({super.key});

  @override
  State<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {
  List<AppointmentsModel> appointments = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) {
          return sl<AppointmentsBloc>()..add(const FetchAllAppointmentsEvent());
        },
        child: BlocConsumer<AppointmentsBloc, AppointmentsState>(
            listener: (BuildContext context, state) {
          if (state is AppointmentsErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
          if (state is AppointmentsSuccessState) {
            appointments = state.appointments;
          }

          if (state is DeleteAppointmentSuccessState) {
            PopupDialogs.showToast(
              "Appointment Deleted Successfully",
            );
            Navigator.pop(context);
            appointments.removeWhere((e) => e.id == state.appointmentId);
          }
          if (state is DeleteAppointmentErrorState) {
            PopupDialogs.showToast(state.message);
            Navigator.pop(context);
          }

          if (state is UpdateAppointmentSuccessState) {
            PopupDialogs.showToast(
              "Appointment Updated Successfully",
            );
            Navigator.pop(context);
            int index =
                appointments.indexWhere((e) => e.id == state.appointmentId);
            appointments[index].date = state.date;
          }
          if (state is UpdateAppointmentErrorState) {
            PopupDialogs.showToast(state.message);
            Navigator.pop(context);
          }
        }, builder: (context, state) {
          AppointmentsBloc appointmentsBloc = context.read<AppointmentsBloc>();
          return Container(
            height: 1.sh,
            width: 1.sw,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (state is AppointmentsLoadingState)
                  const Center(
                    child: CircularProgressIndicator(
                      color: ColorManager.primaryColor,
                    ),
                  )
                else
                  Expanded(
                    child: ListView.builder(
                      itemCount: appointments.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final appointment = appointments[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 1.sw,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: ColorManager.lightPrimary,
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            child: InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    builder: (context) {
                                      return AppointmentBottomSheet(
                                        appointment: appointment,
                                        onEditAppointment: (date) {
                                          appointmentsBloc.add(
                                              UpdateAppointmentEvent(
                                                  date: date,
                                                  appointmentId:
                                                      appointment.id));
                                        },
                                        onDelete: () {
                                          appointmentsBloc.add(
                                              DeleteAppointmentEvent(
                                                  appointmentId:
                                                      appointment.id));
                                        },
                                      );
                                    });
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(appointment.specialist!.name,
                                      style:
                                          getSemiBoldStyle(fontSize: 0.018.sh)),
                                  Text(appointment.specialist!.specialization,
                                      style:
                                          getRegularStyle(fontSize: 0.016.sh)),
                                  Row(
                                    children: [
                                      Spacer(),
                                      const Icon(
                                        Icons.calendar_today,
                                        color: ColorManager.inActive,
                                      ),
                                      5.horizontalSpace,
                                      Text(
                                        appointment.date!.toFormattedDateTime(),
                                        style: getHintStyle(fontSize: 0.018.sh),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
