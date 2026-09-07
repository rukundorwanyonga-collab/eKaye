import "package:flutter/material.dart";
import "../models/amateka.dart";

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  String _selectedFilter = "Byose";

  final List<Amateka> _amateka = [
    Amateka(
      id: "1",
      izina: "Rukundo Vivens",
      ubwoko: "Umusanzu",
      amafaranga: 2000,
      ibisobanuro: "Yatanze umusanzu w'icyumweru",
      itariki: "06/07/2026 10:30",
      icon: Icons.savings,
    ),
    Amateka(
      id: "2",
      izina: "Mugisha Eric",
      ubwoko: "Inguzanyo",
      amafaranga: 50000,
      ibisobanuro: "Yafashe inguzanyo yo kugura ifumbire",
      itariki: "06/07/2026 11:00",
      icon: Icons.account_balance_wallet,
    ),
    Amateka(
      id: "3",
      izina: "Uwera Maria",
      ubwoko: "Amande",
      amafaranga: 500,
      ibisobanuro: "Yasibye inama, acibwa amande",
      itariki: "06/07/2026 11:15",
      icon: Icons.gavel,
    ),
    Amateka(
      id: "4",
      izina: "Mugisha Eric",
      ubwoko: "Kwishyura",
      amafaranga: 50000,
      ibisobanuro: "Yishyuye inguzanyo ye yose",
      itariki: "07/07/2026 09:00",
      icon: Icons.check_circle,
    ),
    Amateka(
      id: "5",
      izina: "Itsinda ryose",
      ubwoko: "Dividend",
      amafaranga: 5000,
      ibisobanuro: "Inyungu zagabanijwe abanyamuryango",
      itariki: "07/07/2026 10:00",
      icon: Icons.card_giftcard,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: const Text(
          "Amateka",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            height: 50,
            margin: const EdgeInsets.symmetric(vertical: 12),
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _buildFilterChip("Byose"),
                _buildFilterChip("Umusanzu"),
                _buildFilterChip("Inguzanyo"),
                _buildFilterChip("Amande"),
                _buildFilterChip("Kwishyura"),
                _buildFilterChip("Dividend"),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _filteredAmateka.length,
              itemBuilder: (context, index) {
                final amateka = _filteredAmateka[index];
                return _buildHistoryCard(amateka);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    bool selected = _selectedFilter == label;
    return Container(
      margin: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(label),
        selected: selected,
        onSelected: (value) {
          setState(() {
            _selectedFilter = label;
          });
        },
        selectedColor: const Color(0xFF6C63FF),
        labelStyle: TextStyle(
          color: selected ? Colors.white : Colors.black,
          fontWeight: selected ? FontWeight.bold : FontWeight.normal,
        ),
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }

  List<Amateka> get _filteredAmateka {
    if (_selectedFilter == "Byose") {
      return _amateka;
    }
    return _amateka.where((a) => a.ubwoko == _selectedFilter).toList();
  }

  Widget _buildHistoryCard(Amateka amateka) {
    Color iconColor;
    Color backgroundColor;

    switch (amateka.ubwoko) {
      case "Umusanzu":
        iconColor = Colors.green;
        backgroundColor = Colors.green.withValues(alpha: 0.1);
        break;
      case "Inguzanyo":
        iconColor = Colors.deepPurple;
        backgroundColor = Colors.deepPurple.withValues(alpha: 0.1);
        break;
      case "Amande":
        iconColor = Colors.red;
        backgroundColor = Colors.red.withValues(alpha: 0.1);
        break;
      case "Kwishyura":
        iconColor = Colors.blue;
        backgroundColor = Colors.blue.withValues(alpha: 0.1);
        break;
      case "Dividend":
        iconColor = Colors.orange;
        backgroundColor = Colors.orange.withValues(alpha: 0.1);
        break;
      default:
        iconColor = Colors.grey;
        backgroundColor = Colors.grey.withValues(alpha: 0.1);
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(amateka.icon, color: iconColor, size: 22),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          amateka.izina,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: backgroundColor,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Text(
                          amateka.ubwoko,
                          style: TextStyle(
                            color: iconColor,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    amateka.ibisobanuro,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${amateka.amafaranga.toStringAsFixed(0)} RWF",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          color: iconColor,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            size: 12,
                            color: Colors.grey[400],
                          ),
                          const SizedBox(width: 4),
                          Text(
                            amateka.itariki,
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.grey[500],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
