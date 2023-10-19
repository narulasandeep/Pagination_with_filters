import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:heliverse_project/teampage.dart';
import 'controller/data_controller.dart';
import 'model/Data.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Data? data;
  List<Data> items = [];
  int currentPage = 0; // Initialize the current page
  int itemsPerPage = 10;
  List<Data> filteredItems = [];
  String selectedGender = ''; // To store selected gender filter
  bool selectedAvailability = false; // To store selected availability filter
  String selectedDomain = ''; // To store selected domain filter
  List<Data> selectedItems = [];
  Future<void> readJson() async {
    final String response = await rootBundle.loadString("asssets/sample.json");
    final List<dynamic> jsonData = json.decode(response);
    final List<Data> dataItems =
        jsonData.map((json) => Data.fromJson(json)).toList();

    setState(() {
      items = dataItems;
      filteredItems = dataItems;
      debugPrint("Data items: $items");
    });
  }
  void toggleSelection(Data data) {
    setState(() {
      if (selectedItems.contains(data)) {
        selectedItems.remove(data);
      } else {
        selectedItems.add(data);
      }
    });
  }
  void filterItems(String nameQuery) {
    setState(() {
      filteredItems = items.where((data) {
        final fullName = '${data.firstName} ${data.lastName}'.toLowerCase();
        return fullName.contains(nameQuery.toLowerCase());
      }).toList();
    });
  }

  void applyFilters() {
    setState(() {
      filteredItems = items.where((data) {
        bool genderMatch =
            selectedGender.isEmpty || data.gender == selectedGender;
        bool availabilityMatch =
            !selectedAvailability || data.available == true;
        bool domainMatch =
            selectedDomain.isEmpty || data.domain == selectedDomain;
        return genderMatch && availabilityMatch && domainMatch;
      }).toList();
    });
  }

  void showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FilterChip(
                    label: const Text('Male'),
                    selected: selectedGender == 'Male',
                    onSelected: (isSelected) {
                      setState(() {
                        selectedGender = isSelected ? 'Male' : '';
                      });
                    },
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  FilterChip(
                    label: const Text('Female'),
                    selected: selectedGender == 'Female',
                    onSelected: (isSelected) {
                      setState(() {
                        selectedGender = isSelected ? 'Female' : '';
                      });
                    },
                  ),
                ],
              ),
              FilterChip(
                label: const Text('Available'),
                selected: selectedAvailability,
                onSelected: (isSelected) {
                  setState(() {
                    selectedAvailability = isSelected;
                  });
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FilterChip(
                    label: const Text("Sales"),
                    selected: selectedDomain == "Sales",
                    onSelected: (isSelected) {
                      setState(() {
                        selectedDomain = isSelected ? "Sales" : '';
                      });
                    },
                  ),
                  FilterChip(
                    label: const Text("IT"),
                    selected: selectedDomain == "IT",
                    onSelected: (isSelected) {
                      setState(() {
                        selectedDomain = isSelected ? "IT" : '';
                      });
                    },
                  ),
                  FilterChip(
                    label: const Text("Marketing"),
                    selected: selectedDomain == "Marketing",
                    onSelected: (isSelected) {
                      setState(() {
                        selectedDomain = isSelected ? "Marketing" : '';
                      });
                    },
                  ),
                ],
              ),
              FilterChip(
                label: const Text("Finance"),
                selected: selectedDomain == "Finance",
                onSelected: (isSelected) {
                  setState(() {
                    selectedDomain = isSelected ? "Finance" : '';
                  });
                },
              ),
              FilterChip(
                label: const Text("Management"),
                selected: selectedDomain == "Management",
                onSelected: (isSelected) {
                  setState(() {
                    selectedDomain = isSelected ? "Management" : '';
                  });
                },
              ),
              FilterChip(
                label: const Text("UI Designing"),
                selected: selectedDomain == "UI Designing",
                onSelected: (isSelected) {
                  setState(() {
                    selectedDomain = isSelected ? "UI Designing" : '';
                  });
                },
              ),
              FilterChip(
                label: const Text("Business Development"),
                selected: selectedDomain == "Business Development",
                onSelected: (isSelected) {
                  setState(() {
                    selectedDomain = isSelected ? "Business Development" : '';
                  });
                },
              ),
              const SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    applyFilters();
                    Navigator.of(context).pop();
                  },
                  child: const Text('Apply Filters'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    readJson();
  }

  final DataController dataController = Get.put(DataController());

  @override
  Widget build(BuildContext context) {
    debugPrint("70-->> $items");

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              showFilterDialog(context);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              onChanged: (value) {
                filterItems(value);
                applyFilters(); // Apply filters whenever the name query changes
              },
              decoration: const InputDecoration(
                labelText: 'Search by Name',
                hintText: 'Enter a name',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Showing ${currentPage + 1} out of 100 Pages"),

            ],
          ),

          Expanded(
            child:
            ListView.builder(
              itemCount: itemsPerPage,
              itemBuilder: (BuildContext context, int i) {
                final dataIndex = currentPage * itemsPerPage + i;
                if (dataIndex >= filteredItems.length) {
                  return null; // Return null for the items beyond the available data.
                }
                Data data = filteredItems[dataIndex];
                final bool isSelected = selectedItems.contains(data);

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
                                    Checkbox(
                                      value: isSelected,
                                      onChanged: (value) {
                                        toggleSelection(data);
                                      },
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
                                    SizedBox(
                                      width: 200,
                                      child: Text("Email- ${data.email} ", overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      ),
                                    ),
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
          ),
          ElevatedButton(
              onPressed: ()
              {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>TeamPage(selectedItems: selectedItems)));
              },
              child: const Text("Add To Team")),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (currentPage > 0) {
                      setState(() {
                        currentPage--; // Move to the next page
                      });
                    }
                  },
                  child: const Text('Previous Page'),
                ),

                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      currentPage++; // Move to the next page
                    });
                  },
                  child: const Text('Next Page'),
                )
              ],
            ),
          ),
        ],
      ),

    );
  }
}
