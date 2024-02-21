import 'package:first_project/database/database.dart';
import 'package:flutter/material.dart';

// gpt one //
class ChoiceChipsWidget extends StatefulWidget {
  ChoiceChipsWidget({Key? key, required this.inputDetails});
  final inputDetails;

  @override
  State<ChoiceChipsWidget> createState() => _ChoiceChipsWidgetState();
}

class _ChoiceChipsWidgetState extends State<ChoiceChipsWidget> {
  List<IconData> iconsChoice = [
    Icons.phone_android_rounded,
    Icons.battery_3_bar_outlined,
    Icons.touch_app_rounded,
    Icons.developer_board_sharp,
    Icons.speaker_outlined,
    Icons.help_outline_sharp,
  ];
  List<String> choice = [
    'Display',
    'Battery',
    'Touch',
    'Board',
    'Speaker',
    'Other',
  ];

  List<int> selectedChoices = [];
  String selectedCountsForDatabase = '';

  @override
  void initState() {
    super.initState();
    getSelectedValuesFromDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: choice.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 1 / 0.5,
          ),
          itemBuilder: (context, index) {
            final isSelected = selectedChoices.contains(index);

            return ChoiceChip(
              backgroundColor: isSelected
                  ? const Color.fromARGB(255, 41, 161, 110)
                  : const Color(0xFFECECEC),
              selectedColor: const Color.fromARGB(255, 41, 161, 110),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(14),
                ),
              ),
              label: SizedBox(
                height: 35,
                width: 76,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      iconsChoice[index],
                      color: isSelected
                          ? Colors.white
                          : const Color.fromARGB(255, 41, 161, 110),
                    ),
                    Text(
                      choice[index],
                      style: TextStyle(
                        color: isSelected
                            ? Colors.white
                            : const Color.fromARGB(255, 41, 161, 110),
                      ),
                    ),
                  ],
                ),
              ),
              selected: isSelected,
              onSelected: (isSelected) async {
                setState(() {
                  if (isSelected) {
                    selectedChoices.add(index);
                  } else {
                    selectedChoices.remove(index);
                  }
                  // Update the string
                  selectedCountsForDatabase = selectedChoices.join(', ');
                });

                await DatabaseHelper.instance.UpdateChoiceChipsValues(
                  id: widget.inputDetails[DatabaseHelper.detailscoloumId],
                  selectedCounts: selectedCountsForDatabase,
                );
              },
            );
          },
        ),
      ),
    );
  }

  void getSelectedValuesFromDatabase() async {
    final tempSelectedCount = await DatabaseHelper.instance
        .getColumnChoiceChipsValue(
            widget.inputDetails[DatabaseHelper.detailscoloumId]);

    if (tempSelectedCount != null && tempSelectedCount.isNotEmpty) {
      List<String> selectedCountList = tempSelectedCount.split(', ');
      print(tempSelectedCount);
      setState(() {
        selectedChoices =
            selectedCountList.map((element) => int.parse(element)).toList();
      });
    } else {
      selectedChoices = [];
    }
  }
}
