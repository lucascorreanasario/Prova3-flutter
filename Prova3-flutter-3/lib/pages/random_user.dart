import 'package:flutter/material.dart';
import 'package:random_user/models/random_user_model.dart';
import 'package:random_user/services/random_user_service.dart';

class RandomUserPage extends StatefulWidget {
  const RandomUserPage({Key? key}) : super(key: key);

  @override
  State<RandomUserPage> createState() => _RandomUserPageState();
}

class _RandomUserPageState extends State<RandomUserPage> {
  static const String defaultName = "Lucas";
  static const String defaultEmail = "Lucas@random.com";
  static const String defaultImage =
      "https://randomuser.me/api/portraits/thumb/men/5.jpg";

  String name = defaultName;
  String email = defaultEmail;
  String image = defaultImage;
  RandomUser? data;

  void handleGetRandomUser() async {
    final response = await getRandomUser();
    setState(() => data = response);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 151, 147, 147).withOpacity(0.94),
      appBar: AppBar(
        title: const Text("Usúarios Aleatórios"),
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(100),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildUserCard(),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => handleGetRandomUser(),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16),
                shape: const StadiumBorder(),
              ),
              child: const Text(
                "Gerar Usúario Aleatório",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Card(
        shape: const RoundedRectangleBorder(
          side: BorderSide(
            color: Color.fromARGB(255, 4, 4, 95),
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: _buildUserListTile(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserListTile() {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(
          data?.results[0].picture.thumbnail ?? image,
        ),
      ),
      title: Text(data?.results[0].name.first ?? name),
      subtitle: Text(data?.results[0].email ?? email),
    );
  }
}
