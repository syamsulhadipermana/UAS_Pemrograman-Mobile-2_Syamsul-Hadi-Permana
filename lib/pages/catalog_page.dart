import 'package:flutter/material.dart';
import '../data/dummy_guitars.dart';
import '../core/app_routes.dart';

class CatalogPage extends StatefulWidget {
  const CatalogPage({super.key});

  @override
  State<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  String searchQuery = "";
  String selectedBrand = "All";
  late RangeValues priceRange;
  String sortBy = "Default";

  final List<String> brands = [
    "All",
    "Gibson",
    "Fender",
    "Ibanez",
  ];

  final List<String> sortOptions = [
    "Default",
    "Price: Low to High",
    "Price: High to Low",
    "A to Z",
    "Highest Discount",
  ];

  @override
  void initState() {
    super.initState();
    // Initialize priceRange with actual max price from dummy data
    final maxPrice = dummyGuitars.isNotEmpty
        ? dummyGuitars
            .map((g) => g.price.toDouble())
            .reduce((a, b) => a > b ? a : b)
        : 10000000.0;
    priceRange = RangeValues(0, maxPrice);
  }

  @override
  Widget build(BuildContext context) {
    // Get min and max price from dummy data
    final maxPrice = dummyGuitars.isNotEmpty
        ? dummyGuitars
            .map((g) => g.price.toDouble())
            .reduce((a, b) => a > b ? a : b)
        : 10000000.0;

    final filteredGuitars = dummyGuitars.where((guitar) {
      final q = searchQuery.toLowerCase();

      final matchesSearch = guitar.name.toLowerCase().contains(q) ||
          guitar.brand.toLowerCase().contains(q);

      final matchesBrand =
          selectedBrand == "All" || guitar.brand == selectedBrand;

      final matchesPrice = guitar.price.toDouble() >= priceRange.start &&
          guitar.price.toDouble() <= priceRange.end;

      return matchesSearch && matchesBrand && matchesPrice;
    }).toList();

    // Apply sorting
    switch (sortBy) {
      case "Price: Low to High":
        filteredGuitars.sort((a, b) => a.price.compareTo(b.price));
        break;
      case "Price: High to Low":
        filteredGuitars.sort((a, b) => b.price.compareTo(a.price));
        break;
      case "A to Z":
        filteredGuitars.sort((a, b) => a.name.compareTo(b.name));
        break;
      case "Highest Discount":
        filteredGuitars.sort((a, b) => b.discount.compareTo(a.discount));
        break;
      default:
        break;
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Collections"),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        children: [
          // 🔍 SEARCH BAR
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Search guitar...",
                hintStyle: const TextStyle(color: Colors.white54),
                prefixIcon: const Icon(Icons.search, color: Colors.white54),
                filled: true,
                fillColor: const Color(0xFF111111),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
          ),

          // 🏷️ CATEGORY CHIPS
          SizedBox(
            height: 46,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: brands.length,
              itemBuilder: (context, index) {
                final brand = brands[index];
                final isSelected = brand == selectedBrand;

                return Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: ChoiceChip(
                    label: Text(brand),
                    selected: isSelected,
                    onSelected: (_) {
                      setState(() {
                        selectedBrand = brand;
                      });
                    },
                    selectedColor: Colors.white,
                    backgroundColor: const Color(0xFF111111),
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.black : Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 16),

          // 💰 PRICE FILTER
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Price Range",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      "Rp ${priceRange.start.toStringAsFixed(0)} - Rp ${priceRange.end.toStringAsFixed(0)}",
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                RangeSlider(
                  values: priceRange,
                  min: 0,
                  max: maxPrice.toDouble(),
                  onChanged: (RangeValues values) {
                    setState(() {
                      priceRange = values;
                    });
                  },
                  activeColor: Colors.white,
                  inactiveColor: Colors.white24,
                  labels: RangeLabels(
                    "Rp ${priceRange.start.toStringAsFixed(0)}",
                    "Rp ${priceRange.end.toStringAsFixed(0)}",
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),

          // 📊 SORT DROPDOWN
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: DropdownButton<String>(
              value: sortBy,
              isExpanded: true,
              dropdownColor: const Color(0xFF111111),
              style: const TextStyle(color: Colors.white),
              underline: Container(
                height: 1,
                color: Colors.white24,
              ),
              onChanged: (String? value) {
                setState(() {
                  sortBy = value ?? "Default";
                });
              },
              items: sortOptions.map((String option) {
                return DropdownMenuItem<String>(
                  value: option,
                  child: Text(option),
                );
              }).toList(),
            ),
          ),

          const SizedBox(height: 8),
          Expanded(
            child: filteredGuitars.isEmpty
                ? const Center(
                    child: Text(
                      "No product found",
                      style: TextStyle(color: Colors.white54),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: GridView.builder(
                      itemCount: filteredGuitars.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                        childAspectRatio: 0.68,
                      ),
                      itemBuilder: (context, index) {
                        final guitar = filteredGuitars[index];

                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.detail,
                              arguments: guitar,
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFF111111),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Stack(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.vertical(
                                          top: Radius.circular(20)),
                                      child: Image.asset(
                                        guitar.image,
                                        height: 180,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error, stackTrace) {
                                          return Container(
                                            height: 180,
                                            color: Colors.grey[800],
                                            child: const Center(
                                              child: Icon(Icons.music_note, size: 50, color: Colors.white30),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(12),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            guitar.name,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(height: 6),
                                          Text(
                                            guitar.brand,
                                            style: const TextStyle(
                                              color: Colors.white54,
                                              fontSize: 12,
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          if (guitar.discount > 0)
                                            Row(
                                              children: [
                                                Text(
                                                  guitar.formattedPrice,
                                                  style: const TextStyle(
                                                    color: Colors.white54,
                                                    fontSize: 12,
                                                    decoration: TextDecoration
                                                        .lineThrough,
                                                  ),
                                                ),
                                                const SizedBox(width: 8),
                                                Text(
                                                  guitar.formattedDiscountedPrice,
                                                  style: const TextStyle(
                                                    color: Colors.greenAccent,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            )
                                          else
                                            Text(
                                              guitar.formattedPrice,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          const SizedBox(height: 6),
                                          Text(
                                            guitar.isInStock
                                                ? "In Stock (${guitar.stock})"
                                                : "Out of Stock",
                                            style: TextStyle(
                                              color: guitar.isInStock
                                                  ? Colors.greenAccent
                                                  : Colors.redAccent,
                                              fontSize: 11,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                // Discount Badge
                                if (guitar.discount > 0)
                                  Positioned(
                                    top: 12,
                                    right: 12,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Text(
                                        "-${guitar.discount}%",
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
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
