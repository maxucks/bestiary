import 'package:bestiary/ui/ext.dart';
import 'package:flutter/material.dart';

class BokuNoInput extends StatelessWidget {
  const BokuNoInput({
    super.key,
    required this.placeholder,
    this.controller,
  });

  final TextEditingController? controller;
  final String placeholder;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      child: TextField(
        controller: controller,
        cursorColor: context.theme.color.accent.star,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide(width: 0, style: BorderStyle.none),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 24),
          filled: true,
          fillColor: context.theme.color.bg.cover.secondary,
          hintText: placeholder,
          hintStyle: context.theme.font.body.copyWith(color: context.theme.color.fg.cover.hint),
        ),
        maxLines: 1,
        style: context.theme.font.body.copyWith(color: context.theme.color.fg.cover.active),
      ),
    );
  }
}
