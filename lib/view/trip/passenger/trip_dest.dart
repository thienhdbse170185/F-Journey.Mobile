import 'package:f_journey/core/utils/date_picker_util.dart';
import 'package:f_journey/core/utils/snackbar_util.dart';
import 'package:f_journey/model/request/trip_request/create_trip_request_request.dart';
import 'package:f_journey/view/auth/widgets/components/text_field_required.dart';
import 'package:f_journey/viewmodel/auth/auth_bloc.dart';
import 'package:f_journey/viewmodel/trip_request/trip_request_cubit.dart';
import 'package:f_journey/viewmodel/zone/zone_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class TripDestinationWidget extends StatefulWidget {
  const TripDestinationWidget({super.key});

  @override
  State<TripDestinationWidget> createState() => _TripDestinationWidgetState();
}

class _TripDestinationWidgetState extends State<TripDestinationWidget> {
  String? fromZone;
  String? toZone;
  int? userId;
  String? slot;
  DateTime? _tripDate;

  final TextEditingController tripDateController = TextEditingController();
  final TextEditingController startTimeController = TextEditingController();

  Map<int, String>? fromZones;
  Map<int, String>? toZones;
  Map<int, String> slots = {
    1: "Slot 1",
    2: "Slot 2",
    3: "Slot 3",
    4: "Slot 4",
  };

  bool get isButtonEnabled => fromZone != null && toZone != null;

  @override
  void initState() {
    super.initState();
    final authState = context.read<AuthBloc>().state;
    if (authState is ProfileUserApproved) {
      userId = authState.profile.id;
    }

    context.read<ZoneBloc>().add(GetAllZoneStarted());
  }

  void submitTripRequest() {
    if (isButtonEnabled) {
      final request = CreateTripRequestRequest(
        fromZoneId: fromZones!.entries
            .firstWhere((entry) => entry.value == fromZone)
            .key,
        toZoneId:
            toZones!.entries.firstWhere((entry) => entry.value == toZone).key,
        tripDate: tripDateController.text,
        startTime: startTimeController.text,
        slot: slots.entries.firstWhere((entry) => entry.value == slot).key,
        userId: userId!,
        status: 'PENDING',
      );
      context.read<TripRequestCubit>().createTripRequest(request);
    } else {
      SnackbarUtil.openFailureSnackbar(context, "Please fill in all fields");
    }
  }

  void _selectTripDate() {
    showDatePickerDialog(
      context: context,
      controller: tripDateController,
      initialDate: DateTime.now(),
      onDateSelected: (selectedDate) {
        setState(() {
          _tripDate = selectedDate;
        });
      },
    );
  }

  void _selectStartTime() {
    showTimeDialog(
      context: context,
      controller: startTimeController,
      initialTime: TimeOfDay.now(),
      onTimeSelected: (selectedTime) {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<TripRequestCubit, TripRequestState>(
            listener: (context, state) {
          if (state is CreateTripRequestFailure) {
            if (state.message.contains("Not enough balance")) {
              showAdaptiveDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("Không đủ tiền :(("),
                      content: const Text(
                          "Bạn vui lòng nạp thêm tiền vào ví để tạo chuyến đi nhé!"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text("OK"),
                        ),
                      ],
                    );
                  });
            }
          } else if (state is CreateTripRequestSuccess) {
            showAdaptiveDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text("Tạo chuyến thành công"),
                    content: const Text(
                        "Bạn vui lòng chờ điện thoại để Xế có thể liên lạc với bạn nhé!"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          context.pop();
                        },
                        child: const Text("Quay về trang chủ"),
                      ),
                    ],
                  );
                });
          } else if (state is CreateTripRequestFailure) {
            SnackbarUtil.openFailureSnackbar(context, state.message);
          }
        }),
        BlocListener<ZoneBloc, ZoneState>(
          listener: (context, state) {
            if (state is GetAllZoneSuccess) {
              setState(() {
                fromZones = {
                  for (var zone in state.zones) zone.id: zone.zoneName
                };
                toZones = {
                  for (var zone in state.zones) zone.id: zone.zoneName
                };
              });
            } else if (state is GetAllZoneFailure) {
              SnackbarUtil.openFailureSnackbar(context, "Failed to load zones");
            } else if (state is FilterZoneSuccess) {
              if (state.zones.isEmpty) {
                SnackbarUtil.openFailureSnackbar(
                    context, "Chưa hỗ trợ tuyến đường này");
                return;
              }
              setState(() {
                toZones = {
                  for (var zone in state.zones) zone.id: zone.zoneName
                };
              });
              if (kDebugMode) {
                print(
                    "Filtered zones: ${toZones!.entries.map((e) => e.value)}");
              }
            } else if (state is FilterZoneFailure) {
              SnackbarUtil.openFailureSnackbar(
                  context, "Failed to filter zones");
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Bạn cần đi nhờ đến đâu?'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: "From Zone | Điểm đi",
                  border: OutlineInputBorder(),
                ),
                value: fromZone,
                items: fromZones?.entries.map((entry) {
                  return DropdownMenuItem<String>(
                    value: entry.value,
                    child: Text(entry.value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    fromZone = newValue;
                  });
                  int fromZoneId = fromZones!.entries
                      .firstWhere((entry) => entry.value == newValue)
                      .key;
                  context
                      .read<ZoneBloc>()
                      .add(FilterZoneStarted(fromZoneId: fromZoneId));
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: "To Zone | Điểm đến",
                  helperText:
                      "Bạn cần chọn điểm đi và điểm đến để tụi mình \ntìm Xế cho bạn nha. Cảm ơn bạn!",
                  border: OutlineInputBorder(),
                ),
                value: toZone,
                items: toZones?.entries.map((entry) {
                  return DropdownMenuItem<String>(
                    value: entry.value,
                    child: Text(entry.value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    toZone = newValue;
                  });
                },
              ),
              const SizedBox(height: 16),
              TextFieldRequired(
                label: "Trip Date | Ngày khởi hành",
                hintText: "Chọn ngày khởi hành",
                suffixIcon: const Icon(Icons.calendar_month),
                isDisabled: true,
                onTap: () {
                  _selectTripDate();
                },
                controller: tripDateController,
              ),
              const SizedBox(height: 16),
              TextFieldRequired(
                label: "Start Time | Giờ khởi hành",
                hintText: "Chọn giờ khởi hành",
                suffixIcon: const Icon(Icons.access_time),
                isDisabled: true,
                onTap: () {
                  _selectStartTime();
                },
                controller: startTimeController,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: "Slot",
                  border: OutlineInputBorder(),
                ),
                value: slot,
                items: slots.entries.map((entry) {
                  return DropdownMenuItem<String>(
                    value: entry.value,
                    child: Text(entry.value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    slot = newValue;
                  });
                },
              ),
            ],
          ),
        ),
        bottomSheet: Container(
          padding: const EdgeInsets.all(16),
          width: MediaQuery.of(context).size.width,
          child: FilledButton(
            onPressed: isButtonEnabled
                ? () {
                    submitTripRequest();
                  }
                : null, // Disable the button when not enough fields are selected
            child: const Text('Bắt đầu tạo chuyến đi'),
          ),
        ),
      ),
    );
  }
}
