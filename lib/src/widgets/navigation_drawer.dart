import 'package:flutter/material.dart';

class NavigationDrawerWidget extends StatelessWidget {
  const NavigationDrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final name = 'Sarah Abs';
    final email = 'sarah@abs.com';
    return Drawer(
        child: Material(
      color: Colors.grey[300],
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          buildHeader(
            name: name,
            email: email,
          ),
          const SizedBox(
            height: 40,
          ),
          buildMenuItem(
            text: 'Latest',
            icon: Icons.people_alt_outlined,
          )
        ],
      ),
    ));
  }

  Widget buildMenuItem({
    required String text,
    required IconData icon,
  }) {
    final color = Colors.black;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text, style: TextStyle(color: color)),
    );
  }

  Widget buildHeader({required String name, required String email}) {
    return InkWell(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 40),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(
                  'https://w7.pngwing.com/pngs/122/453/png-transparent-computer-icons-user-profile-avatar-female-profile-heroes-head-woman.png'),
            ),
            const SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(fontSize: 20, color: Colors.black),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  email,
                  style: const TextStyle(fontSize: 20, color: Colors.black),
                )
              ],
            )
          ],
        ),
      ),
      onTap: () {},
    );
  }
}
