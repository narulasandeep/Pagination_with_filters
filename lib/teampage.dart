import 'package:flutter/material.dart';
import 'package:heliverse_project/model/Data.dart';
class TeamPage extends StatelessWidget {
  final List<Data> selectedItems;
  const TeamPage({super.key, required this.selectedItems});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Team Page"),
      ),
   body: selectedItems.isEmpty ?
   const Center(
       child:  Text("Please select People to make team")) :
   ListView.builder(
   itemCount: selectedItems.length,
  itemBuilder: (BuildContext context, int i) {
    Data data = selectedItems[i];
     return Padding(
      padding: const EdgeInsets.all(12),
      child: Card(
        child: Row(
          children: [

            Row(
              children: [
                Row(
                  children: [
                    Column(
                      children: [
                        CircleAvatar(
                          backgroundImage:
                          NetworkImage(data.avatar ?? ""),
                        ),
                      ],
                    ),
                    const SizedBox(width: 10),
                  ],
                ),
                Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("S.no- ${data.id}"),
                        Text(
                            "Name- ${data.firstName} ${data.lastName}"),
                        Text("Email- ${data.email}"),
                        Text("Gender- ${data.gender}"),
                        Text("Domain-${data.domain}"),
                        Text(
                            "Available - ${data.available == true ? 'Yes' : 'No'}"),
                      ],
                    )
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  },
),
    );
  }
}
