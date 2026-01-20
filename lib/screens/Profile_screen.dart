// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:remixicon/remixicon.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // --- REFINED PREMIUM CLIENT COLOR PALETTE ---
    const Color brandBlue = Color(0xFF002366); // Royal Navy
    const Color accentRed = Color(0xFFE60000); // High-End Crimson
    const Color softBlueBg = Color(
      0xFFF0F4F8,
    ); // Premium light grayish-blue background

    return Scaffold(
      backgroundColor: softBlueBg,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ================= 1. PREMIUM BRANDED HEADER =================
            _buildHeader(context, brandBlue, accentRed),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  // ================= 2. MODERN STATS CARD =================
                  _buildQuickStats(brandBlue, accentRed),

                  const SizedBox(height: 25),

                  // ================= 3. ACCOUNT SETTINGS =================
                  _buildSectionTitle("Account Settings"),
                  _buildMenuCard([
                    _buildMenuItem(
                      Remix.file_list_3_line,
                      'Your Orders',
                      "Check status",
                      brandBlue,
                    ),
                    _buildMenuItem(
                      Remix.map_pin_2_line,
                      'Address Book',
                      "2 saved addresses",
                      brandBlue,
                    ),
                    _buildMenuItem(
                      Remix.wallet_3_line,
                      'Payments',
                      "Cards & UPI",
                      brandBlue,
                    ),
                  ]),

                  const SizedBox(height: 20),

                  // ================= 4. OFFERS & PREFERENCES =================
                  _buildSectionTitle("Offers & More"),
                  _buildMenuCard([
                    _buildMenuItem(
                      Remix.heart_3_line,
                      'Favourites',
                      null,
                      brandBlue,
                    ),
                    _buildMenuItem(
                      Remix.gift_2_line,
                      'Refer a Friend',
                      "Get \$10",
                      accentRed,
                    ), // Highlighted in red
                    _buildMenuItem(
                      Remix.star_line,
                      'Claim Gift Card',
                      null,
                      brandBlue,
                    ),
                  ]),

                  const SizedBox(height: 20),

                  // ================= 5. SUPPORT & LOGOUT =================
                  _buildMenuCard([
                    _buildMenuItem(
                      Remix.customer_service_2_line,
                      'Help & Support',
                      null,
                      brandBlue,
                    ),
                    _buildMenuItem(
                      Remix.settings_4_line,
                      'Settings',
                      null,
                      brandBlue,
                    ),
                    _buildMenuItem(
                      Remix.logout_circle_line,
                      'Log Out',
                      null,
                      accentRed,
                      isLast: true,
                    ),
                  ]),

                  const SizedBox(height: 40),
                  const Text(
                    "Version 1.0.2",
                    style: TextStyle(
                      color: Color(0xFF94A3B8),
                      fontSize: 12,
                      letterSpacing: 1.2,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- LUXURY HEADER WITH BRAND BLUE ---
  Widget _buildHeader(BuildContext context, Color primary, Color accent) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 60, 20, 50),
      decoration: BoxDecoration(
        color: primary,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
        boxShadow: [
          BoxShadow(
            color: primary.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white.withOpacity(0.2),
                    width: 2,
                  ),
                ),
                child: const CircleAvatar(
                  radius: 55,
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage('assets/food images/9440461.jpg'),
                ),
              ),
              Positioned(
                bottom: 5,
                right: 5,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(color: Colors.black26, blurRadius: 10),
                    ],
                  ),
                  child: Icon(Iconsax.camera, color: accent, size: 18),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          const Text(
            'Sharan Kumaran G',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 0.5,
            ),
          ),
          Text(
            'sarankumaran3025@gmail.com',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withOpacity(0.7),
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  // --- STATS WITH BALANCED BRAND COLORS ---
  Widget _buildQuickStats(Color blue, Color red) {
    return Transform.translate(
      offset: const Offset(0, -30),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 22),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.white),
          boxShadow: [
            BoxShadow(
              color: blue.withOpacity(0.08),
              blurRadius: 25,
              offset: const Offset(0, 15),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildStatItem(Remix.shopping_bag_3_line, "Orders", "12", blue),
            _buildVerticalDivider(),
            _buildStatItem(
              Remix.wallet_line,
              "Wallet",
              "\$45",
              red,
            ), // Red for money/wallet highlight
            _buildVerticalDivider(),
            _buildStatItem(Remix.coupon_3_line, "Coupons", "4", blue),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(
    IconData icon,
    String label,
    String value,
    Color color,
  ) {
    return Column(
      children: [
        Icon(icon, color: color, size: 26),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: color, // Value matches the icon color for better look
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF64748B),
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildVerticalDivider() {
    return Container(height: 40, width: 1.5, color: const Color(0xFFF1F5F9));
  }

  Widget _buildSectionTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 5, bottom: 15),
        child: Text(
          title.toUpperCase(), // Uppercase for professional look
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w800,
            color: Color(0xFF64748B),
            letterSpacing: 1.1,
          ),
        ),
      ),
    );
  }

  Widget _buildMenuCard(List<Widget> children) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }

  Widget _buildMenuItem(
    IconData icon,
    String title,
    String? subtitle,
    Color themeColor, {
    bool isLast = false,
    Color? color,
  }) {
    final Color itemColor = color ?? const Color(0xFF1E293B);
    return Column(
      children: [
        ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 4,
          ),
          leading: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: (color ?? themeColor).withOpacity(0.08),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color ?? themeColor, size: 20),
          ),
          title: Text(
            title,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: itemColor,
            ),
          ),
          subtitle: subtitle != null
              ? Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF94A3B8),
                  ),
                )
              : null,
          trailing: const Icon(
            Icons.arrow_forward_ios,
            size: 14,
            color: Color(0xFFCBD5E1),
          ),
          onTap: () {},
        ),
        if (!isLast)
          Divider(
            indent: 75,
            endIndent: 20,
            height: 1,
            color: const Color(0xFFF1F5F9),
          ),
      ],
    );
  }
}
