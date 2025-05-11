import 'package:code_quest/core/local_storage/storage_helper.dart';
import 'package:code_quest/core/theme/color_manager.dart';
import 'package:code_quest/core/theme/text_styles_manager.dart';
import 'package:code_quest/features/providers_screen/presentation/bloc/specialists_state.dart';
import 'package:code_quest/features/providers_screen/presentation/specialist_bottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/utils/constants.dart';
import '../../../core/service_injection/injection_imports.dart';
import '../../../core/utils/popup_dialogs.dart';
import '../data/models/specialist_model.dart';
import 'bloc/specialists_bloc.dart';
import 'bloc/specialists_event.dart';
import 'package:intl/intl.dart';

class SpecialistsScreen extends StatefulWidget {
  SpecialistsScreen({super.key});

  @override
  State<SpecialistsScreen> createState() => _SpecialistsScreenState();
}

class _SpecialistsScreenState extends State<SpecialistsScreen> {
  List<SpecialistModel> specialists = [];
  bool loadingBookAppointment = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) {
          return sl<SpecialistsBloc>()..add(const FetchAllSpecialistsEvent());
        },
        child: BlocConsumer<SpecialistsBloc, SpecialistsState>(
            listener: (BuildContext context, state) {
          if (state is SpecialistsErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
          if (state is SpecialistsSuccessState) {
            specialists = state.specialists;
          }
          if (state is MakeAppointmentSuccessState) {
            PopupDialogs.showToast(
              "Appointment Booked Successfully",
            );
            Navigator.pop(context);
          }
          if (state is MakeAppointmentErrorState) {
            PopupDialogs.showToast(state.message);
            Navigator.pop(context);
          }
        }, builder: (context, state) {
          SpecialistsBloc specialistsBloc = context.read<SpecialistsBloc>();
          return SizedBox(
            height: 1.sh,
            width: 1.sw,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (state is SpecialistsLoadingState)
                  const Center(
                    child: CircularProgressIndicator(color: ColorManager.primaryColor,),
                  )
                else
                Expanded(
                  child: ListView.builder(
                    itemCount: specialists.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final specialist = specialists[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 1.sw,
                          height: 0.1.sh,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: ColorManager.lightPrimary,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (context) {
                                    return SpecialistBottomSheet(
                                      specialist: specialist,
                                      onMakeAppointment: (date) {
                                        specialistsBloc.add(BookAppointmentEvent(
                                          specialistModel: specialist,
                                            specialistId: specialist.id,
                                            user: LocalStorage.getData(key: Constants.loggedInUser),
                                            date: date,));
                                      },
                                    );
                                  });
                            },
                            child: Row(
                              children: [
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      specialist.image,
                                      height: 60,
                                      width: 60,
                                    )),
                                5.horizontalSpace,
                                Expanded(
                                  child: ListTile(
                                    title: Text(specialist.name,
                                        style:
                                            getSemiBoldStyle(fontSize: 0.018.sh)),
                                    subtitle: Text(specialist.specialization,
                                        style:
                                            getRegularStyle(fontSize: 0.016.sh)),
                                  ),
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
