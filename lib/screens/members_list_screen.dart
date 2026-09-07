import "package:flutter/material.dart";
import "../models/umuntu.dart";

class MembersListScreen extends StatefulWidget {
  const MembersListScreen({super.key});

  @override
  _MembersListScreenState createState() => _MembersListScreenState();
}

class _MembersListScreenState extends State<MembersListScreen> {
  final List<Umuntu> _abantu = [
    Umuntu(
      id: "1",
      izina: "Rukundo Vivens",
      phone: "0788222333",
      umusanzu: 2000,
      ingoboka: 200,
      amande: 0,
      ideniKUmusanzuUtatanzwe: 700,
      igiteranyo: 3400,
      itariki: "06/07/2026",
    ),
    Umuntu(
      id: "2",
      izina: "Mugisha Eric",
      phone: "0788444555",
      umusanzu: 3000,
      ingoboka: 500,
      amande: 500,
      ideniKUmusanzuUtatanzwe: 0,
      igiteranyo: 3500,
      itariki: "06/07/2026",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: const Text(
          "Abanyamuryango",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: _abantu.length,
        itemBuilder: (context, index) {
          final umuntu = _abantu[index];
          return _buildNameTile(umuntu);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddUmusanzu(),
        backgroundColor: const Color(0xFF6C63FF),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildNameTile(Umuntu umuntu) {
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
              umuntu.izina.substring(0, 1).toUpperCase(),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        title: Text(
          umuntu.izina,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          "${umuntu.umusanzu.toStringAsFixed(0)} RWF",
          style: TextStyle(fontSize: 11, color: Colors.grey[600]),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.blue, size: 20),
              onPressed: () => _showEditForm(umuntu),
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red, size: 20),
              onPressed: () => _deleteUmuntu(umuntu.id),
            ),
          ],
        ),
        onTap: () => _showMemberDetails(umuntu),
      ),
    );
  }

  // ADD UMUSANZU - Kongera umusanzu
  void _showAddUmusanzu() {
    
    final amafarangaController = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Kongera Umusanzu"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Dropdown yo guhitamo umuntu
              DropdownButtonFormField(
                initialValue: _abantu.isNotEmpty ? _abantu[0].id : null,
                decoration: const InputDecoration(labelText: "Umuntu"),
                items: _abantu.map((m) {
                  return DropdownMenuItem(
                    value: m.id,
                    child: Text(m.izina),
                  );
                }).toList(),
                onChanged: (value) {},
              ),
              const SizedBox(height: 8),
              TextField(
                controller: amafarangaController,
                decoration: const InputDecoration(labelText: "Amafaranga yazanye (RWF)"),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("Cancel")),
          ElevatedButton(
            onPressed: () {
              final amafaranga = double.tryParse(amafarangaController.text) ?? 0.0;
              if (amafaranga > 0) {
                setState(() {
                  // Kongera ku musanzu w'umuntu wa mbere (demo)
                  _abantu[0].umusanzu += amafaranga;
                  _abantu[0].igiteranyo += amafaranga;
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

  // Details
  void _showMemberDetails(Umuntu umuntu) {
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
                umuntu.izina,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView(
                  controller: scrollController,
                  children: [
                    ListTile(
                      leading: const Icon(Icons.phone, color: Colors.blue),
                      title: const Text("Phone"),
                      subtitle: Text(umuntu.phone),
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.savings, color: Colors.teal),
                      title: const Text("Umusanzu"),
                      subtitle: Text("${umuntu.umusanzu.toStringAsFixed(0)} RWF"),
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.volunteer_activism, color: Colors.blue),
                      title: const Text("Ingoboka"),
                      subtitle: Text("${umuntu.ingoboka.toStringAsFixed(0)} RWF"),
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.gavel, color: Colors.orange),
                      title: const Text("Amande"),
                      subtitle: Text("${umuntu.amande.toStringAsFixed(0)} RWF"),
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.warning, color: Colors.red),
                      title: const Text("Ideni"),
                      subtitle: Text("${umuntu.ideniKUmusanzuUtatanzwe.toStringAsFixed(0)} RWF"),
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.account_balance, color: Colors.purple),
                      title: const Text("Igiteranyo"),
                      subtitle: Text("${umuntu.igiteranyo.toStringAsFixed(0)} RWF"),
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.calendar_today, color: Colors.grey),
                      title: const Text("Itariki"),
                      subtitle: Text(umuntu.itariki),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton.icon(
                    onPressed: () {
                      Navigator.pop(ctx);
                      _showEditForm(umuntu);
                    },
                    icon: const Icon(Icons.edit, color: Colors.blue),
                    label: const Text("Edit"),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      Navigator.pop(ctx);
                      _deleteUmuntu(umuntu.id);
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

  void _showEditForm(Umuntu umuntu) {
    final izinaController = TextEditingController(text: umuntu.izina);
    final phoneController = TextEditingController(text: umuntu.phone);

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Guhindura Umuntu"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: izinaController, decoration: const InputDecoration(labelText: "Izina")),
              const SizedBox(height: 8),
              TextField(controller: phoneController, decoration: const InputDecoration(labelText: "Phone")),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("Cancel")),
          ElevatedButton(
            onPressed: () {
              final izina = izinaController.text;
              if (izina.isNotEmpty) {
                setState(() {
                  final index = _abantu.indexWhere((m) => m.id == umuntu.id);
                  if (index != -1) {
                    _abantu[index].izina = izina;
                    _abantu[index].phone = phoneController.text;
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

  void _deleteUmuntu(String id) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Gusiba"),
        content: const Text("Urabyemeza ko ushaka gusiba uyu muntu?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("Cancel")),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              setState(() {
                _abantu.removeWhere((m) => m.id == id);
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
