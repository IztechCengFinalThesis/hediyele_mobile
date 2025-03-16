import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> userData = {
      "name": "Murat Deli",
      "birthday": "25.08",
      "age": 24,
      "phone": "+90 (543) 555-555-1227",
      "email": "murat.deli@example.com",
      "interests": [
        {"icon": Icons.sports_soccer, "label": "Football"},
        {"icon": Icons.menu_book, "label": "Book"},
        {"icon": Icons.local_florist, "label": "Flower"},
        {"icon": Icons.computer, "label": "Computer Games"},
        {"icon": Icons.photo_camera, "label": "Photography"},
      ],
      "wishlist": [
        {
          "image": "https://m.media-amazon.com/images/I/71i2XhHU3pL._AC_SX679_.jpg",
          "name": "iPhone 15 Pro Max, 256GB"
        },
        {
          "image": "https://m.media-amazon.com/images/I/81vDZyJQ-4L._AC_SX679_.jpg",
          "name": "Samsung Galaxy S23 Ultra"
        },
        {
          "image": "https://m.media-amazon.com/images/I/61RUcXGP7GL._AC_SX679_.jpg",
          "name": "Sony WH-1000XM5 Headphones"
        },
      ]
    };

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2EA5B7),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔹 Üst Profil Alanı
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 160,
                  color: const Color(0xFF2EA5B7),
                ),
                Column(
                  children: [
                    CircleAvatar(
                      radius: 55,
                      backgroundColor: Colors.black,
                      child: const Icon(Icons.person, color: Colors.white, size: 50),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      userData["name"],
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            // 🔹 Kullanıcı Bilgileri
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoBlock("Age - Birthday Date", "${userData["age"]} / ${userData["birthday"]}"),
                  _buildInfoBlock("Phone Number", userData["phone"]),
                  _buildInfoBlock("Email", userData["email"]),
                ],
              ),
            ),

            // 🔹 İlgi Alanları (Interest)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                "Interest",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: userData["interests"].map<Widget>((interest) {
                  return Chip(
                    avatar: Icon(interest["icon"], size: 18),
                    label: Text(interest["label"]),
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: const BorderSide(color: Colors.black),
                    ),
                  );
                }).toList(),
              ),
            ),

            // 🔹 Wishlist (İstediği Ürünler)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                "Wishlist",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 230, // ✅ Fotoğrafların yüksekliği artırıldı
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                itemCount: userData["wishlist"].length,
                separatorBuilder: (_, __) => const SizedBox(width: 10),
                itemBuilder: (context, index) {
                  final item = userData["wishlist"][index];
                  return Container(
                    width: 160, // ✅ Biraz daha genişletildi
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: const Color(0xFF37C5DA),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 6,
                          spreadRadius: 2,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.all(8), // ✅ Kenarlardan mavi görünmesi için boşluk bırakıldı
                            decoration: BoxDecoration(
                              color: Colors.white, // ✅ Fotoğrafın arkasında beyaz çerçeve
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.black, width: 2), // ✅ Siyah çerçeve eklendi
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                item["image"],
                                width: double.infinity,
                                height: double.infinity,
                                fit: BoxFit.cover, // ✅ Fotoğraf tam oturacak
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    color: Colors.grey[300],
                                    child: const Center(
                                      child: Icon(Icons.image_not_supported, size: 40, color: Colors.grey),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            color: Color(0xFF37C5DA),
                            borderRadius: BorderRadius.vertical(bottom: Radius.circular(12)), // ✅ Alt köşeler yuvarlatıldı
                          ),
                          child: Text(
                            item["name"],
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // 🔹 Bilgi Alanı (Başlık ve Altına Değer)
  Widget _buildInfoBlock(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
