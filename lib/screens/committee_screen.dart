import "package:flutter/material.dart";
import "../models/umukozi.dart";

class CommitteeScreen extends StatefulWidget {
  const CommitteeScreen({super.key});

  @override
  _CommitteeScreenState createState() => _CommitteeScreenState();
}

class _CommitteeScreenState extends State<CommitteeScreen> {
  final List<Umukozi> _abakozi = [
    Umukozi(
      id: "1",
      izina: "Rukundo Vivens",
      umwanya: "Perezida",
      phone: "0788222333",
      email: "vivens@gmail.com",
      itarikiYatangiriye: "01/01/2026",
    ),
    Umukozi(
      id: "2",
      izina: "Mugisha Eric",
      umwanya: "Umubitsi",
      phone: "0788444555",
      email: "eric@gmail.com",
      itarikiYatangiriye: "01/01/2026",
    ),
    Umukozi(
      id: "3",
      izina: "Uwera Maria",
      umwanya: "Umwanditsi",
      phone: "0788666777",
      email: "maria@gmail.com",
      itarikiYatangiriye: "01/01/2026",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: const Text(
          "Komite",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF6C63FF), Color(0xFF5A52E5)],
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Column(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Icon(
                    Icons.groups,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Komite y'Itsinda",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "${_abakozi.length} Bayobozi",
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.8),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // List ya cards
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _abakozi.length,
              itemBuilder: (context, index) {
                final umukozi = _abakozi[index];
                return _buildCommitteeCard(umukozi);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddMemberForm(),
        backgroundColor: const Color(0xFF6C63FF),
        child: const Icon(Icons.person_add, color: Colors.white),
      ),
    );
  }

  // Card y'umukozi - Compact kandi isomeka neza
  Widget _buildCommitteeCard(Umukozi umukozi) {
    Color roleColor;
    IconData roleIcon;

    switch (umukozi.umwanya) {
      case "Perezida":
        roleColor = Colors.red;
        roleIcon = Icons.leaderboard;
        break;
      case "Umubitsi":
        roleColor = Colors.green;
        roleIcon = Icons.account_balance;
        break;
      case "Umwanditsi":
        roleColor = Colors.blue;
        roleIcon = Icons.edit;
        break;
      default:
        roleColor = Colors.grey;
        roleIcon = Icons.person;
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            // Avatar
            Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [roleColor, roleColor.withValues(alpha: 0.7)],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  umukozi.izina.substring(0, 1).toUpperCase(),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            // Izina + Umwanya
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    umukozi.izina,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Icon(roleIcon, color: roleColor, size: 14),
                      const SizedBox(width: 4),
                      Text(
                        umukozi.umwanya,
                        style: TextStyle(
                          color: roleColor,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    umukozi.phone,
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            // Actions: Edit + Delete
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.blue, size: 20),
              onPressed: () => _showEditMemberForm(umukozi),
              tooltip: "Edit",
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red, size: 20),
              onPressed: () => _deleteMember(umukozi.id),
              tooltip: "Delete",
            ),
          ],
        ),
      ),
    );
  }

  // ADD FORM
  void _showAddMemberForm() {
    final izinaController = TextEditingController();
    String selectedUmwanya = "Perezida";
    final phoneController = TextEditingController();
    final emailController = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setState) => AlertDialog(
          title: const Text("Kongera Umukozi"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: izinaController,
                  decoration: const InputDecoration(
                    labelText: "Izina",
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField(
                  initialValue: selectedUmwanya,
                  decoration: const InputDecoration(
                    labelText: "Umwanya",
                    prefixIcon: Icon(Icons.leaderboard),
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: "Perezida",
                      child: Text("Perezida"),
                    ),
                    DropdownMenuItem(
                      value: "Umubitsi",
                      child: Text("Umubitsi"),
                    ),
                    DropdownMenuItem(
                      value: "Umwanditsi",
                      child: Text("Umwanditsi"),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      selectedUmwanya = value ?? "Perezida";
                    });
                  },
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: phoneController,
                  decoration: const InputDecoration(
                    labelText: "Phone",
                    prefixIcon: Icon(Icons.phone),
                  ),
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: "Email",
                    prefixIcon: Icon(Icons.email),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                final izina = izinaController.text;
                if (izina.isNotEmpty) {
                  setState(() {
                    _abakozi.add(Umukozi(
                      id: DateTime.now().toString(),
                      izina: izina,
                      umwanya: selectedUmwanya,
                      phone: phoneController.text,
                      email: emailController.text,
                      itarikiYatangiriye: DateTime.now().toString().substring(0, 10),
                    ));
                  });
                  Navigator.pop(ctx);
                }
              },
              child: const Text("Kongera"),
            ),
          ],
        ),
      ),
    );
  }

  // EDIT FORM
  void _showEditMemberForm(Umukozi umukozi) {
    final izinaController = TextEditingController(text: umukozi.izina);
    String selectedUmwanya = umukozi.umwanya;
    final phoneController = TextEditingController(text: umukozi.phone);
    final emailController = TextEditingController(text: umukozi.email);

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setState) => AlertDialog(
          title: const Text("Guhindura Umukozi"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: izinaController,
                  decoration: const InputDecoration(
                    labelText: "Izina",
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField(
                  initialValue: selectedUmwanya,
                  decoration: const InputDecoration(
                    labelText: "Umwanya",
                    prefixIcon: Icon(Icons.leaderboard),
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: "Perezida",
                      child: Text("Perezida"),
                    ),
                    DropdownMenuItem(
                      value: "Umubitsi",
                      child: Text("Umubitsi"),
                    ),
                    DropdownMenuItem(
                      value: "Umwanditsi",
                      child: Text("Umwanditsi"),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      selectedUmwanya = value ?? umukozi.umwanya;
                    });
                  },
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: phoneController,
                  decoration: const InputDecoration(
                    labelText: "Phone",
                    prefixIcon: Icon(Icons.phone),
                  ),
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: "Email",
                    prefixIcon: Icon(Icons.email),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                final izina = izinaController.text;
                if (izina.isNotEmpty) {
                  setState(() {
                    final index = _abakozi.indexWhere((m) => m.id == umukozi.id);
                    if (index != -1) {
                      _abakozi[index].izina = izina;
                      _abakozi[index].umwanya = selectedUmwanya;
                      _abakozi[index].phone = phoneController.text;
                      _abakozi[index].email = emailController.text;
                    }
                  });
                  Navigator.pop(ctx);
                }
              },
              child: const Text("Bika"),
            ),
          ],
        ),
      ),
    );
  }

  // DELETE
  void _deleteMember(String id) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Gusiba"),
        content: const Text("Urabyemeza ko ushaka gusiba uyu mukozi?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              setState(() {
                _abakozi.removeWhere((m) => m.id == id);
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
