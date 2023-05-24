import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HeadAccount extends ConsumerWidget {
  const HeadAccount(
    this.title, {
    Key? key,
  }) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Container(
        alignment: Alignment.centerLeft,
        height: 60,
        child: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Text(
            title,
            style: const TextStyle(fontSize: 25),
          ),
        ),
      ),
    );
  }
}

class HeadAccountOption extends ConsumerWidget {
  const HeadAccountOption(
    this.title, {
    Key? key,
  }) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Container(
        alignment: Alignment.centerLeft,
        height: 60,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(fontSize: 25),
                ),
              ),
              Expanded(
                child: InkWell(
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: Icon(
                      Icons.cancel_outlined,
                      size: 40,
                      color: Colors.black.withOpacity(0.3),
                    ),
                  ),
                  onTap: () => Navigator.pop(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
