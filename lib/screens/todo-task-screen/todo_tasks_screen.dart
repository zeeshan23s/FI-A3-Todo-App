import 'package:intl/intl.dart';

import '../../packages_export.dart';

part 'widgets/task_screen_tab.dart';
part 'widgets/task_container.dart';

class TodoTasksScreen extends StatefulWidget {
  const TodoTasksScreen({super.key});

  @override
  State<TodoTasksScreen> createState() => _TodoTasksScreenState();
}

class _TodoTasksScreenState extends State<TodoTasksScreen> {
  final Map<String, int> screenTabs = {'Completed': 65, 'To Do': 45};

  String selectedKey = 'Completed';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: Image.asset(appLogo, scale: 12),
        title: Text(
          'Task List',
          style: Theme.of(context)
              .textTheme
              .headlineLarge
              ?.copyWith(fontWeight: FontWeight.w700),
        ),
        actions: [
          PopupMenuButton(itemBuilder: (context) {
            return [
              PopupMenuItem<int>(
                value: 0,
                child: Text("My Profile",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontWeight: FontWeight.w600)),
              ),
              PopupMenuItem<int>(
                value: 1,
                child: Text("Logout",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontWeight: FontWeight.w600)),
              ),
            ];
          }, onSelected: (value) {
            if (value == 0) {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const TodoProfileScreen()));
            } else if (value == 1) {
              context.read<AuthProvider>().logout();
            }
          }),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: ScreenHelper.screenHeight(context) * 0.02,
              horizontal: ScreenHelper.screenWidth(context) * 0.04),
          child: StreamBuilder(
              stream: TaskController.read(selectedKey),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<QueryDocumentSnapshot> task = snapshot.data!.docs;
                  debugPrint(task.toString());
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          children: screenTabs.entries
                              .map(
                                (tab) => TaskScreenTab(
                                    tab: tab.key,
                                    totalItems: task.length.toString(),
                                    isSelected: selectedKey == tab.key,
                                    onTab: () {
                                      setState(() {
                                        selectedKey = tab.key;
                                      });
                                    }),
                              )
                              .toList(),
                        ),
                        SizedBox(
                            height: ScreenHelper.screenHeight(context) * 0.01),
                        ...task.asMap().entries.map((e) {
                          return TaskContainer(
                              task: Task.fromFirestore(e.value));
                        })
                      ],
                    ),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const TodoAddScreen())),
        backgroundColor: secondaryColor,
        child: const Icon(Icons.add, color: primaryColor),
      ),
    );
  }
}
