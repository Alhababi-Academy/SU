import 'package:flutter/material.dart';

class AvailableRoomsPage extends StatefulWidget {
  @override
  _AvailableRoomsPageState createState() => _AvailableRoomsPageState();
}

class _AvailableRoomsPageState extends State<AvailableRoomsPage> {
  String? selectedRoom;
  List<String> rooms = [
    'Room 101',
    'Room 102',
    'Room 103',
    'Room 104',
    'Room 105',
    'Room 105',
  ];
  List<String> filteredRooms = [];
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredRooms = rooms; // Initially display all rooms
    searchController.addListener(() {
      filterRooms();
    });
  }

  void filterRooms() {
    List<String> _temp = [];
    _temp.addAll(rooms.where((room) =>
        room.toLowerCase().contains(searchController.text.toLowerCase())));
    setState(() {
      filteredRooms = _temp;
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select a Room'),
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: 'Search for a room',
                hintText: 'Enter room number',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: const BorderSide(),
                ),
                filled: true,
                contentPadding: const EdgeInsets.all(16),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredRooms.length,
              itemBuilder: (context, index) {
                return Card(
                  margin:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  child: ListTile(
                    title: Text(filteredRooms[index]),
                    onTap: () {
                      setState(() {
                        selectedRoom = filteredRooms[index];
                        print(selectedRoom);
                      });
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
