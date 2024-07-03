import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mmtransport/Components/custom_large_title.dart';
import 'package:mmtransport/Components/custom_primary_button.dart';
import 'package:mmtransport/Constant/app.color.dart';

class CustomDatePicker extends StatefulWidget {
  final DateTime date;
  final void Function(DateTime date)? onChange;
  final void Function(DateTime date)? onSave;

  const CustomDatePicker({
    Key? key,
    required this.date,
    required this.onSave,
    required this.onChange,
  }) : super(key: key);

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  late DateTime currentDate;

  @override
  void initState() {
    currentDate = widget.date;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        children: [
          const Spacer(),
          Container(
            height: Get.height / 2.5,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                textDirection: TextDirection.rtl,
                children: [
                  /// Days
                  Expanded(
                    child: CustomCupertinoDaysList(
                      date: widget.date,
                      onChange: (day) {
                        currentDate = DateTime(
                          currentDate.year,
                          currentDate.month,
                          day,
                          currentDate.hour,
                          currentDate.minute,
                          currentDate.second,
                          currentDate.millisecond,
                          currentDate.microsecond,
                        );
                        if (widget.onChange != null) widget.onChange!(currentDate);
                      },
                    ),
                  ),

                  /// Months
                  Expanded(
                    child: CustomCupertinoMonthsList(
                      date: widget.date,
                      onChange: (month) {
                        currentDate = DateTime(
                          currentDate.year,
                          month,
                          currentDate.day,
                          currentDate.hour,
                          currentDate.minute,
                          currentDate.second,
                          currentDate.millisecond,
                          currentDate.microsecond,
                        );
                        if (widget.onChange != null) widget.onChange!(currentDate);
                      },
                    ),
                  ),

                  /// Years
                  Expanded(
                    child: CustomCupertinoYearsList(
                      date: widget.date,
                      onChange: (year) {
                        currentDate = DateTime(
                          year,
                          currentDate.month,
                          currentDate.day,
                          currentDate.hour,
                          currentDate.minute,
                          currentDate.second,
                          currentDate.millisecond,
                          currentDate.microsecond,
                        );
                        if (widget.onChange != null) widget.onChange!(currentDate);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          CustomPrimaryButton(
            height: 60,
            bottomPadding: 15,
            color: Colors.white,
            textColor: AppColors.secondColor,
            buttonText: "حفض",
            onPressed: () {
              if (widget.onSave != null) widget.onSave!(currentDate);
            },
          )
        ],
      ),
    );
  }
}

class CustomCupertinoMonthsList extends StatefulWidget {
  final DateTime date;
  final void Function(int month) onChange;

  const CustomCupertinoMonthsList({
    Key? key,
    required this.date,
    required this.onChange,
  }) : super(key: key);

  @override
  State<CustomCupertinoMonthsList> createState() => _CustomCupertinoMonthsListState();
}

class _CustomCupertinoMonthsListState extends State<CustomCupertinoMonthsList> {
  int indexSelect = 1;
  List<int> months = [];

  @override
  void initState() {
    months = List.generate(31, (index) {
      int month = (index + 1);
      if (widget.date.month == month) {
        indexSelect = index;
      }
      return month;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CustomLargeTitle(
          title: "الشهر",
          color: AppColors.secondColor,
        ),
        const SizedBox(height: 10),
        Expanded(
          child: CupertinoPicker(
            looping: true,
            scrollController: FixedExtentScrollController(initialItem: indexSelect),
            selectionOverlay: CupertinoPickerDefaultSelectionOverlay(
              background: AppColors.secondColor.withOpacity(0.1),
            ),
            itemExtent: 50,
            onSelectedItemChanged: (index) {
              widget.onChange(months[index]);
              setState(() => indexSelect = index);
            },
            children: List.generate(
              12,
              (index) => Center(
                child: Text(
                  (months[index]).toString(),
                  style: TextStyle(
                    color: indexSelect == index ? AppColors.secondColor : Colors.black87,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CustomCupertinoYearsList extends StatefulWidget {
  final DateTime date;
  final void Function(int year) onChange;

  const CustomCupertinoYearsList({
    Key? key,
    required this.date,
    required this.onChange,
  }) : super(key: key);

  @override
  State<CustomCupertinoYearsList> createState() => _CustomCupertinoYearsListState();
}

class _CustomCupertinoYearsListState extends State<CustomCupertinoYearsList> {
  int indexSelect = -1;
  List<int> years = [];

  @override
  void initState() {
    years = List.generate(60, (index) {
      int year = (2018 + index);
      if (widget.date.year == year) {
        indexSelect = index;
      }
      return year;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CustomLargeTitle(
          title: "السنة",
          color: AppColors.secondColor,
        ),
        const SizedBox(height: 10),
        Expanded(
          child: CupertinoPicker(
            looping: true,
            scrollController: FixedExtentScrollController(initialItem: indexSelect),
            selectionOverlay: CupertinoPickerDefaultSelectionOverlay(
              background: AppColors.secondColor.withOpacity(0.1),
            ),
            itemExtent: 50,
            onSelectedItemChanged: (index) {
              widget.onChange(years[index]);
              setState(() {
                indexSelect = index;
              });
            },
            children: List.generate(
              years.length,
              (index) => Center(
                child: Text(
                  (years[index]).toString(),
                  style: TextStyle(
                    color: indexSelect == index ? AppColors.secondColor : Colors.black87,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CustomCupertinoDaysList extends StatefulWidget {
  final DateTime date;
  final void Function(int day) onChange;
  const CustomCupertinoDaysList({
    Key? key,
    required this.date,
    required this.onChange,
  }) : super(key: key);

  @override
  State<CustomCupertinoDaysList> createState() => _CustomCupertinoDaysListState();
}

class _CustomCupertinoDaysListState extends State<CustomCupertinoDaysList> {
  int indexSelect = -1;
  List<int> days = [];

  @override
  void initState() {
    days = List.generate(31, (index) {
      int day = (index + 1);
      if (widget.date.day == day) {
        indexSelect = index;
      }
      return day;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CustomLargeTitle(
          title: "اليوم",
          color: AppColors.secondColor,
        ),
        const SizedBox(height: 10),
        Expanded(
          child: CupertinoPicker(
            scrollController: FixedExtentScrollController(initialItem: indexSelect),
            looping: true,
            selectionOverlay: CupertinoPickerDefaultSelectionOverlay(
              background: AppColors.secondColor.withOpacity(0.1),
            ),
            itemExtent: 50,
            onSelectedItemChanged: (index) {
              widget.onChange(days[index]);
              setState(() => indexSelect = index);
            },
            children: List.generate(
              days.length,
              (index) {
                return Center(
                  child: Text(
                    (days[index]).toString(),
                    style: TextStyle(
                      color: indexSelect == index ? AppColors.secondColor : Colors.black87,
                    ),
                  ),
                );
              },
            ),
          ),
        )
      ],
    );
  }
}
