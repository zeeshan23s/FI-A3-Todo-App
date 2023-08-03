part of '../todo_tasks_screen.dart';

class TaskContainer extends StatelessWidget {
  final Task task;
  const TaskContainer({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      shadowColor: Colors.transparent,
      child: Container(
        height: ScreenHelper.screenHeight(context) * 0.185,
        padding: EdgeInsets.symmetric(
            vertical: ScreenHelper.screenHeight(context) * 0.01,
            horizontal: ScreenHelper.screenWidth(context) * 0.02),
        decoration: BoxDecoration(
          border: Border.all(color: secondaryColor),
          borderRadius:
              BorderRadius.circular(ScreenHelper.screenHeight(context) * 0.01),
        ),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: ScreenHelper.screenWidth(context) * 0.65,
                      child: Text(
                        task.title,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                    ),
                    SizedBox(height: ScreenHelper.screenHeight(context) * 0.01),
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal:
                                  ScreenHelper.screenWidth(context) * 0.005),
                          padding: EdgeInsets.all(
                              ScreenHelper.screenWidth(context) * 0.015),
                          decoration: BoxDecoration(
                            color: task.intensity == 'Low'
                                ? lowIntensity
                                : task.intensity == 'Medium'
                                    ? mediumIntensity
                                    : highIntensity,
                            borderRadius: BorderRadius.circular(
                                ScreenHelper.screenHeight(context) * 0.05),
                          ),
                          child: Text(
                            task.intensity,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(fontWeight: FontWeight.w600),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal:
                                  ScreenHelper.screenWidth(context) * 0.005),
                          padding: EdgeInsets.all(
                              ScreenHelper.screenWidth(context) * 0.015),
                          decoration: BoxDecoration(
                            color: task.isComplete
                                ? completedColor
                                : progressColor,
                            borderRadius: BorderRadius.circular(
                                ScreenHelper.screenHeight(context) * 0.05),
                          ),
                          child: Text(
                            task.isComplete ? 'Completed' : 'In Progress',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(fontWeight: FontWeight.w600),
                          ),
                        )
                      ],
                    )
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.calendar_month),
                    SizedBox(width: ScreenHelper.screenWidth(context) * 0.01),
                    Text(
                        DateFormat.yMMMd()
                            .format(DateTime.parse(task.createdAt)),
                        style: Theme.of(context).textTheme.bodyMedium),
                  ],
                )
              ],
            ),
            const VerticalDivider(thickness: 2),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            TodoAddScreen(isOld: true, task: task)));
                  },
                  icon: const Icon(Icons.edit, size: 22),
                ),
                IconButton(
                  color: Colors.red[400],
                  onPressed: () {
                    TaskController.delete(task.id).whenComplete(() {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(TaskController.status['message'],
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(color: primaryColor)),
                          backgroundColor: TaskController.status['code'] == 200
                              ? Colors.green
                              : Colors.red,
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    });
                  },
                  icon: const Icon(Icons.delete, size: 22),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
