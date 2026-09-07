import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "../providers/app_provider.dart";
import "members_list_screen.dart";
import "loans_screen.dart";
import "history_screen.dart";
import "committee_screen.dart";

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    _DashboardHome(),
    const MembersListScreen(),
    const LoansScreen(),
    const HistoryScreen(),
    const CommitteeScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        selectedItemColor: const Color(0xFF6C63FF),
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Ahabanza"),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: "Abantu"),
          BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet), label: "Inguzanyo"),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: "Amateka"),
          BottomNavigationBarItem(icon: Icon(Icons.groups), label: "Komite"),
        ],
      ),
    );
  }
}

class _DashboardHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ============================
              // HEADER + ILLUSTRATION
              // ============================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFF6C63FF), Color(0xFF5A52E5)],
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "iKayi+",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Illustration
                    Container(
                      width: double.infinity,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: CustomPaint(painter: _LandscapePainter()),
                    ),
                  ],
                ),
              ),

              // ============================
              // CARDS 6 - TINY
              // ============================
              Padding(
                padding: const EdgeInsets.all(8),
                child: GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                  childAspectRatio: 2.8,
                  children: [
                    _buildTinyCard(Icons.savings, "Cash", "${provider.cashInBox.toStringAsFixed(0)}", const Color(0xFF4CAF50)),
                    _buildTinyCard(Icons.trending_up, "Imisanzu", "${provider.imisanzuYose.toStringAsFixed(0)}", const Color(0xFF2196F3)),
                    _buildTinyCard(Icons.account_balance, "Igikorwa", "${provider.igikorwamari.toStringAsFixed(0)}", const Color(0xFF9C27B0)),
                    _buildTinyCard(Icons.receipt_long, "Inguzanyo", "${provider.inguzanyoZisigaye.toStringAsFixed(0)}", const Color(0xFFFF9800)),
                    _buildTinyCard(Icons.card_giftcard, "Inyungu", "${provider.inyunguZagabanijwe.toStringAsFixed(0)}", const Color(0xFF00BCD4)),
                    _buildTinyCard(Icons.gavel, "Ibihano", "${provider.ibihano.toStringAsFixed(0)}", const Color(0xFFF44336)),
                  ],
                ),
              ),

              // ============================
              // PANEL - Abantu + Raporo
              // ============================
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withValues(alpha: 0.08),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Raporo y'Itsinda",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Abantu (Clickable)
                    _buildPersonItem(context, "Rukundo Vivens", "0788222333", "2000 RWF"),
                    _buildPersonItem(context, "Mugisha Eric", "0788444555", "3000 RWF"),
                    const Divider(height: 10),
                    // Raporo
                    _buildReportRow(Icons.people, "Abanyamuryango", "2"),
                    _buildReportRow(Icons.account_balance_wallet, "Inguzanyo", "${provider.inguzanyoZatanzwe}"),
                    _buildReportRow(Icons.savings, "Imisanzu Yose", "${provider.imisanzuYose.toStringAsFixed(0)} RWF"),
                    _buildReportRow(Icons.account_balance, "Igikorwamari", "${provider.igikorwamari.toStringAsFixed(0)} RWF"),
                  ],
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  // Person Item - Clickable
  Widget _buildPersonItem(BuildContext context, String name, String phone, String amount) {
    return InkWell(
      onTap: () {
        // Kanda ukabona details
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          builder: (ctx) => Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF6C63FF), Color(0xFF5A52E5)],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      name.substring(0, 1),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  name,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                ListTile(
                  leading: const Icon(Icons.phone, color: Colors.blue, size: 16),
                  title: const Text("Phone", style: TextStyle(fontSize: 12)),
                  subtitle: Text(phone),
                ),
                ListTile(
                  leading: const Icon(Icons.savings, color: Colors.teal, size: 16),
                  title: const Text("Umusanzu", style: TextStyle(fontSize: 12)),
                  subtitle: Text(amount),
                ),
              ],
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 6),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color(0xFFF5F7FA),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF6C63FF), Color(0xFF5A52E5)],
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  name.substring(0, 1),
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    phone,
                    style: TextStyle(fontSize: 9, color: Colors.grey[500]),
                  ),
                ],
              ),
            ),
            Text(
              amount,
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF6C63FF)),
            ),
          ],
        ),
      ),
    );
  }

  // Report Row
  Widget _buildReportRow(IconData icon, String title, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F7FA),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF6C63FF), size: 12),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontSize: 10, color: Colors.black87),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: Color(0xFF6C63FF),
            ),
          ),
        ],
      ),
    );
  }

  // Tiny Card
  Widget _buildTinyCard(IconData icon, String title, String value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.05),
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Icon(icon, color: color, size: 9),
          ),
          const SizedBox(width: 3),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 7,
                    color: Colors.grey[600],
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LandscapePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final sunPaint = Paint()..color = Colors.yellow.withValues(alpha: 0.7);
    canvas.drawCircle(Offset(size.width - 25, 15), 10, sunPaint);

    final mountainPaint = Paint()..color = Colors.white.withValues(alpha: 0.25);
    final mountainPath = Path()
      ..moveTo(0, size.height)
      ..lineTo(size.width * 0.25, size.height * 0.4)
      ..lineTo(size.width * 0.5, size.height)
      ..lineTo(size.width * 0.7, size.height * 0.3)
      ..lineTo(size.width, size.height)
      ..close();
    canvas.drawPath(mountainPath, mountainPaint);

    final treePaint = Paint()..color = Colors.green.withValues(alpha: 0.4);
    canvas.drawCircle(Offset(size.width * 0.4, size.height - 8), 5, treePaint);
    canvas.drawCircle(Offset(size.width * 0.6, size.height - 6), 6, treePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
