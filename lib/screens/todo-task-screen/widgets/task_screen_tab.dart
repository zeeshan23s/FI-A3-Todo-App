part of '../todo_tasks_screen.dart';

class TaskScreenTab extends StatelessWidget {
  final String tab;
  final String totalItems;
  final bool isSelected;
  final VoidCallback onTab;

  const TaskScreenTab(
      {super.key,
      required this.tab,
      required this.totalItems,
      required this.isSelected,
      required this.onTab});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTab,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 800),
        margin:
            EdgeInsets.only(right: ScreenHelper.screenWidth(context) * 0.01),
        padding: EdgeInsets.all(ScreenHelper.screenWidth(context) * 0.02),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? secondaryColor : Colors.transparent,
          border: Border.all(color: secondaryColor),
          borderRadius:
              BorderRadius.circular(ScreenHelper.screenHeight(context) * 0.05),
        ),
        child: Row(
          children: [
            Text(
              tab,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: isSelected ? primaryColor : secondaryColor,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(width: ScreenHelper.screenWidth(context) * 0.02),
            isSelected
                ? AnimatedContainer(
                    duration: const Duration(milliseconds: 800),
                    padding: EdgeInsets.symmetric(
                        horizontal: ScreenHelper.screenWidth(context) * 0.01),
                    decoration: BoxDecoration(
                      color:
                          isSelected ? selectedTabColor(tab) : unselectedColor,
                      borderRadius: BorderRadius.circular(
                          ScreenHelper.screenHeight(context) * 0.05),
                    ),
                    child: Text(
                      totalItems,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                  )
                : const SizedBox()
          ],
        ),
      ),
    );
  }

  Color selectedTabColor(String tab) {
    switch (tab) {
      case 'To Do':
        {
          return progressColor;
        }
      default:
        {
          return completedColor;
        }
    }
  }
}
