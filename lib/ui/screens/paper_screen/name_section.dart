part of 'paper_screen.dart';

class _NameSection extends StatelessWidget {
  const _NameSection({
    required this.title,
    this.originalTitle,
  });

  final String title;
  final String? originalTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: context.theme.font.header.copyWith(color: context.theme.color.fg.body),
        ),
        if (originalTitle != null)
          Text(
            originalTitle!,
            style: context.theme.font.subtitle.copyWith(
              color: context.theme.color.fg.body.muted,
            ),
          ),
      ],
    );
  }
}
