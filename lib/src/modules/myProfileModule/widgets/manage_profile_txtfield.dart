import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_project/src/configs/utils/app_colors.dart';

class txtfieldProfile extends StatefulWidget {
  final String hintText;
  final bool obs_text;
  final IconData prefixIcn;
  final VoidCallback? ontap;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const txtfieldProfile(
      {required this.obs_text,
      required this.hintText,
      this.ontap,
      required this.controller,
      required this.prefixIcn,
      Key? key,
      this.validator})
      : super(key: key);

  @override
  State<txtfieldProfile> createState() => _txtfieldProfileState();
}

class _txtfieldProfileState extends State<txtfieldProfile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: TextFormField(
        onTap: widget.ontap,
        obscureText: widget.obs_text,
        controller: widget.controller,
        validator: widget.validator,
        style: TextStyle(fontSize: 13),
        decoration: InputDecoration(
            hintText: widget.hintText,
            contentPadding: EdgeInsets.only(left: 20),
            hintStyle:
                TextStyle(color: Colors.black.withOpacity(0.4), fontSize: 13),
            suffixIcon: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.edit,
                color: AppColors.appcolor,
              ),
            ),
            labelStyle: GoogleFonts.notoSans(
              color: AppColors.blackColor,
            ),
            fillColor: AppColors.whitecolor,
            filled: true,
            border: const OutlineInputBorder(borderSide: BorderSide.none),
            prefixIcon: Container(
              margin: const EdgeInsets.all(8),
              //padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: AppColors.appcolor,
                borderRadius: BorderRadius.circular(8),
                //border: Border.all(width: 2, color: appBlueClr)
              ),
              child: Icon(
                widget.prefixIcn,
                color: Colors.white,
              ),
            )),
      ),
    );
  }
}
