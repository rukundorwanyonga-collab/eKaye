import "package:flutter/material.dart";
import "../models/inguzanyo.dart";

class LoansScreen extends StatefulWidget {
  const LoansScreen({super.key});

  @override
  _LoansScreenState createState() => _LoansScreenState();
}

class _LoansScreenState extends State<LoansScreen> {
  final List<Inguzanyo> _inguzanyo = [
    Inguzanyo(
      id: "1",
      izina: "Rukundo Vivens",
      inguzanyoAmafaranga: 50000,
      impamvu: "Kugura ifumbire",
      umwishingizi: "Mugisha Eric",
      akagari: "Kigarama",
      umudugudu: "Kabeza",
      itariki: "01/07/2026",
      itarikiNtarengwa: "01/10/2026",
      yarishyuye: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: const Text(
          "Inguzanyo",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: _inguzanyo.length,
        itemBuilder: (context, index) {
          final inguzanyo = _inguzanyo[index];
          return _buildNameTile(inguzanyo);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddLoanForm(),
        backgroundColor: const Color(0xFF6C63FF),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildNameTile(Inguzanyo inguzanyo) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF6C63FF), Color(0xFF5A52E5)],
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              inguzanyo.izina.substring(0, 1).toUpperCase(),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        title: Text(
          inguzanyo.izina,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          "${inguzanyo.inguzanyoAmafaranga.toStringAsFixed(0)} RWF",
          style: TextStyle(fontSize: 11, color: Colors.grey[600]),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (!inguzanyo.yarishyuye)
              IconButton(
                icon: const Icon(Icons.payments, color: Colors.green, size: 20),
                onPressed: () => _showPayLoan(inguzanyo),
              ),
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.blue, size: 20),
              onPressed: () => _showEditLoanForm(inguzanyo),
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red, size: 20),
              onPressed: () => _deleteInguzanyo(inguzanyo.id),
            ),
          ],
        ),
        onTap: () => _showLoanDetails(inguzanyo),
      ),
    );
  }

  // KWISHYURA GAKE GAKE
  void _showPayLoan(Inguzanyo inguzanyo) {
    final amafarangaController = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("Kwishyura - ${inguzanyo.izina}"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Asigaye: ${inguzanyo.inguzanyoAmafaranga.toStringAsFixed(0)} RWF",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: amafarangaController,
              decoration: const InputDecoration(labelText: "Amafaranga yishyura (RWF)"),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("Cancel")),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            onPressed: () {
              final amafaranga = double.tryParse(amafarangaController.text) ?? 0.0;
              if (amafaranga > 0 && amafaranga <= inguzanyo.inguzanyoAmafaranga) {
                setState(() {
                  inguzanyo.inguzanyoAmafaranga -= amafaranga;
                  if (inguzanyo.inguzanyoAmafaranga <= 0) {
                    inguzanyo.yarishyuye = true;
                  }
                });
                Navigator.pop(ctx);
              }
            },
            child: const Text("Kwishyura"),
          ),
        ],
      ),
    );
  }

  // Details
  void _showLoanDetails(Inguzanyo inguzanyo) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (ctx) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.3,
        maxChildSize: 0.9,
        expand: false,
        builder: (ctx, scrollController) => Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                inguzanyo.izina,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView(
                  controller: scrollController,
                  children: [
                    ListTile(
                      leading: const Icon(Icons.account_balance_wallet, color: Colors.purple),
                      title: const Text("Inguzanyo Amafaranga"),
                      subtitle: Text("${inguzanyo.inguzanyoAmafaranga.toStringAsFixed(0)} RWF"),
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.help_outline, color: Colors.blue),
                      title: const Text("Impamvu"),
                      subtitle: Text(inguzanyo.impamvu),
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.person, color: Colors.orange),
                      title: const Text("Umwishingizi"),
                      subtitle: Text(inguzanyo.umwishingizi),
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.location_city, color: Colors.teal),
                      title: const Text("Akagari"),
                      subtitle: Text(inguzanyo.akagari),
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.home, color: Colors.purple),
                      title: const Text("Umudugudu"),
                      subtitle: Text(inguzanyo.umudugudu),
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.calendar_today, color: Colors.grey),
                      title: const Text("Itariki Yafashe"),
                      subtitle: Text(inguzanyo.itariki),
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.event, color: Colors.red),
                      title: const Text("Itariki Ntarengwa"),
                      subtitle: Text(inguzanyo.itarikiNtarengwa),
                    ),
                    const Divider(),
                    ListTile(
                      leading: Icon(
                        inguzanyo.yarishyuye ? Icons.check_circle : Icons.cancel,
                        color: inguzanyo.yarishyuye ? Colors.green : Colors.red,
                      ),
                      title: const Text("Status"),
                      subtitle: Text(inguzanyo.yarishyuye ? "Yishyuye" : "Ntiyishyuye"),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (!inguzanyo.yarishyuye)
                    TextButton.icon(
                      onPressed: () {
                        Navigator.pop(ctx);
                        _showPayLoan(inguzanyo);
                      },
                      icon: const Icon(Icons.payments, color: Colors.green),
                      label: const Text("Kwishyura"),
                    ),
                  TextButton.icon(
                    onPressed: () {
                      Navigator.pop(ctx);
                      _showEditLoanForm(inguzanyo);
                    },
                    icon: const Icon(Icons.edit, color: Colors.blue),
                    label: const Text("Edit"),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      Navigator.pop(ctx);
                      _deleteInguzanyo(inguzanyo.id);
                    },
                    icon: const Icon(Icons.delete, color: Colors.red),
                    label: const Text("Delete"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAddLoanForm() {
    final izinaController = TextEditingController();
    final amafarangaController = TextEditingController();
    final impamvuController = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Kongera Inguzanyo"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: izinaController, decoration: const InputDecoration(labelText: "Izina")),
              const SizedBox(height: 8),
              TextField(controller: amafarangaController, decoration: const InputDecoration(labelText: "Amafaranga (RWF)"), keyboardType: TextInputType.number),
              const SizedBox(height: 8),
              TextField(controller: impamvuController, decoration: const InputDecoration(labelText: "Impamvu")),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("Cancel")),
          ElevatedButton(
            onPressed: () {
              final izina = izinaController.text;
              final amafaranga = double.tryParse(amafarangaController.text) ?? 0.0;

              if (izina.isNotEmpty && amafaranga > 0) {
                setState(() {
                  _inguzanyo.add(Inguzanyo(
                    id: DateTime.now().toString(),
                    izina: izina,
                    inguzanyoAmafaranga: amafaranga,
                    impamvu: impamvuController.text,
                    umwishingizi: "",
                    akagari: "",
                    umudugudu: "",
                    itariki: DateTime.now().toString().substring(0, 10),
                    itarikiNtarengwa: DateTime.now().toString().substring(0, 10),
                  ));
                });
                Navigator.pop(ctx);
              }
            },
            child: const Text("Kongera"),
          ),
        ],
      ),
    );
  }

  void _showEditLoanForm(Inguzanyo inguzanyo) {
    final izinaController = TextEditingController(text: inguzanyo.izina);
    final amafarangaController = TextEditingController(text: inguzanyo.inguzanyoAmafaranga.toString());

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Guhindura Inguzanyo"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: izinaController, decoration: const InputDecoration(labelText: "Izina")),
              const SizedBox(height: 8),
              TextField(controller: amafarangaController, decoration: const InputDecoration(labelText: "Amafaranga (RWF)"), keyboardType: TextInputType.number),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("Cancel")),
          ElevatedButton(
            onPressed: () {
              final izina = izinaController.text;
              final amafaranga = double.tryParse(amafarangaController.text) ?? 0.0;

              if (izina.isNotEmpty && amafaranga > 0) {
                setState(() {
                  final index = _inguzanyo.indexWhere((i) => i.id == inguzanyo.id);
                  if (index != -1) {
                    _inguzanyo[index].izina = izina;
                    _inguzanyo[index].inguzanyoAmafaranga = amafaranga;
                  }
                });
                Navigator.pop(ctx);
              }
            },
            child: const Text("Bika"),
          ),
        ],
      ),
    );
  }

  void _deleteInguzanyo(String id) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Gusiba"),
        content: const Text("Urabyemeza ko ushaka gusiba iyi nguzanyo?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("Cancel")),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              setState(() {
                _inguzanyo.removeWhere((i) => i.id == id);
              });
              Navigator.pop(ctx);
            },
            child: const Text("Gusiba"),
          ),
        ],
      ),
    );
  }
}
