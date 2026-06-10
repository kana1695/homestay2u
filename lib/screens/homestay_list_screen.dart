import 'package:flutter/material.dart';
import '../models/homestay.dart';
import '../services/api_service.dart';
import 'homestay_detail_screen.dart';

class HomestayListScreen extends StatefulWidget {
  const HomestayListScreen({super.key});

  @override
  State<HomestayListScreen> createState() => _HomestayListScreenState();
}

class _HomestayListScreenState extends State<HomestayListScreen> {
  List<Homestay> homestayList = [];

  bool isLoading = false;
  String message = '';

  final TextEditingController searchController = TextEditingController();

  // Feature: State and district filter variables
  String selectedState = 'All';
  String selectedDistrict = 'All';

  List<String> stateList = ['All'];
  List<String> districtList = ['All'];

  @override
  void initState() {
    super.initState();

    // Feature: Load all homestays when app opens
    loadHomestays();
  }

  // Feature: Load data from API
  void loadHomestays({String keyword = ''}) {
    setState(() {
      isLoading = true;
      message = '';
    });

    ApiService.fetchHomestays(keyword: keyword).then((value) {
      homestayList.clear();

      for (var item in value) {
        homestayList.add(item);
      }

      // Feature: Prepare state and district filter lists
      stateList = ['All'];
      districtList = ['All'];

      for (var homestay in homestayList) {
        if (homestay.state != null &&
            homestay.state!.isNotEmpty &&
            !stateList.contains(homestay.state)) {
          stateList.add(homestay.state!);
        }

        if (homestay.district != null &&
            homestay.district!.isNotEmpty &&
            !districtList.contains(homestay.district)) {
          districtList.add(homestay.district!);
        }
      }

      setState(() {
        isLoading = false;

        if (homestayList.isEmpty) {
          message = 'No homestay found';
        }
      });
    }).catchError((error) {
      setState(() {
        isLoading = false;
        homestayList.clear();
        message =
            'Unable to load data from server.\nPlease check your internet connection.';
      });
    });
  }

  // Feature: Search homestay
  void searchHomestay() {
    selectedState = 'All';
    selectedDistrict = 'All';

    loadHomestays(
      keyword: searchController.text.trim(),
    );
  }

  // Feature: Clear search and reload all homestays
  void clearSearch() {
    searchController.clear();
    selectedState = 'All';
    selectedDistrict = 'All';
    loadHomestays();
  }

  // Feature: Filter by state and district
  List<Homestay> getFilteredHomestays() {
    return homestayList.where((homestay) {
      bool matchState =
          selectedState == 'All' || homestay.state == selectedState;

      bool matchDistrict =
          selectedDistrict == 'All' || homestay.district == selectedDistrict;

      return matchState && matchDistrict;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    List<Homestay> filteredList = getFilteredHomestays();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Homestay2U Malaysia'),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),

      body: Column(
        children: [
          // Feature: Search bar
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: searchController,
              onSubmitted: (value) {
                searchHomestay();
              },
              decoration: InputDecoration(
                hintText: 'Search homestay',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: clearSearch,
                    ),
                    IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: searchHomestay,
                    ),
                  ],
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),

          // Feature: State and district dropdown filters
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Expanded(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: selectedState,
                    items: stateList.map((state) {
                      return DropdownMenuItem(
                        value: state,
                        child: Text(state),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedState = value!;
                        selectedDistrict = 'All';
                      });
                    },
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: selectedDistrict,
                    items: districtList.map((district) {
                      return DropdownMenuItem(
                        value: district,
                        child: Text(district),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedDistrict = value!;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 5),

          Expanded(
            child: isLoading
                // Feature: Loading indicator
                ? const Center(
                    child: CircularProgressIndicator(),
                  )

                // Feature: Empty or error message
                : filteredList.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.search_off,
                              size: 80,
                              color: Colors.grey,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              message.isEmpty
                                  ? 'No homestay found'
                                  : message,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      )

                    // Feature: Pull-to-refresh
                    : RefreshIndicator(
                        onRefresh: () async {
                          loadHomestays();
                        },

                        // Feature: ListView.builder
                        child: ListView.builder(
                          itemCount: filteredList.length,
                          itemBuilder: (context, index) {
                            Homestay homestay = filteredList[index];

                            // Feature: Card UI
                            return Card(
                              margin: const EdgeInsets.all(8),
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: ListTile(
                                // Feature: Go to detail page when tapped
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          HomestayDetailScreen(
                                        homestay: homestay,
                                      ),
                                    ),
                                  );
                                },

                                // Feature: Image display if image exists
                                leading: homestay.imageUrl == null
                                    ? const Icon(
                                        Icons.home,
                                        size: 50,
                                        color: Colors.teal,
                                      )
                                    : SizedBox(
                                        width: 70,
                                        child: Image.network(
                                          homestay.imageUrl!,
                                          fit: BoxFit.cover,
                                          errorBuilder:
                                              (context, error, stackTrace) =>
                                                  const Icon(
                                            Icons.broken_image,
                                            size: 50,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ),

                                title: Text(
                                  homestay.name ?? '',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('State: ${homestay.state}'),
                                    Text('District: ${homestay.district}'),
                                    Text('Price: ${homestay.price}'),
                                    Text(
                                      'Description: ${homestay.description}',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),

                                trailing: const Icon(
                                  Icons.arrow_forward_ios,
                                  size: 16,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
          ),
        ],
      ),
    );
  }
}