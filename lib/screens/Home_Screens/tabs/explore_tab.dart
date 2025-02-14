import 'package:flutter/material.dart';

class ExploreTab extends StatelessWidget {
  const ExploreTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DefaultTabController(
          length: 9,
          initialIndex: 0,
          child: TabBar(tabs: [
            Expanded(
              child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Theme.of(context).primaryColor),
                      ),
                      child: Text("data"),
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(width: 8),
                  itemCount: 9),
            )
          ]),
        ),
      ],
    );
  }
}
