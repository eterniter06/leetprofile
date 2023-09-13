import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key, this.children, this.profileHeader});

  final List<Widget>? children;
  final String? profileHeader;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if (profileHeader != null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  profileHeader!,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color(0xff6F480C),
                  ),
                ),
              ),
            if (children != null) ...children!,
          ],
        ),
      ),
    );
  }
}
