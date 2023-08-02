import '../../packages_export.dart';

class CustomizedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  final Color backgroundColor;

  const CustomizedButton(
      {super.key,
      required this.onPressed,
      required this.child,
      this.backgroundColor = Colors.transparent});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPressed(),
      child: Container(
          height: ScreenHelper.screenHeight(context) * 0.09,
          width: ScreenHelper.screenHeight(context) -
              (ScreenHelper.screenHeight(context) * 0.07),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius:
                BorderRadius.circular(ScreenHelper.screenHeight(context) * 0.1),
            border: Border.all(color: secondaryColor, width: 1.5),
          ),
          child: child),
    );
  }
}
