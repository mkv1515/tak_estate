import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:tak/core/utils/colors.dart';

class GenderField extends StatefulWidget {
  final Function callback;
  const GenderField({
    super.key,
    required this.callback,
  });

  @override
  State<GenderField> createState() => _GenderFieldState();
}

class _GenderFieldState extends State<GenderField> {
  String _selectedGender = "Male";
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Gender', style: Theme.of(context).textTheme.titleSmall),
              Gap(4.h),
              DropdownButtonFormField<String>(
                value: _selectedGender,
                items: const <DropdownMenuItem<String>>[
                  DropdownMenuItem<String>(
                    value: "Male",
                    child: Text("Male"),
                  ),
                  DropdownMenuItem<String>(
                    value: "Female",
                    child: Text("Female"),
                  ),
                ],
                onChanged: (newValue) {
                  setState(() {
                    _selectedGender = newValue!;
                    widget.callback(_selectedGender);
                  });
                },
                validator: (value) =>
                    value == null ? 'Please select a gender' : null,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? white
                          : dark,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
