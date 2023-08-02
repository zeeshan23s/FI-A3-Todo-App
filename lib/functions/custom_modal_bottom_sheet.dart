import '../packages_export.dart';

void customModelBottomSheet(BuildContext context, Widget child) async {
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20), topRight: Radius.circular(20)),
    ),
    clipBehavior: Clip.hardEdge,
    builder: (context) => Material(
      child: SafeArea(
        top: false,
        child: child,
      ),
    ),
  );
}
