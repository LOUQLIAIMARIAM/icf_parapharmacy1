import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:icf_parapharmacy1/paimant/paiment_en_ligne.dart';
import 'package:icf_parapharmacy1/paimant/paiment_livraison.dart';

class paimethode extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Paiement'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30),
            Text(
              'Choisissez une méthode de paiement',
              style: TextStyle(
                fontSize: 26,
                color: Colors.black,
                fontFamily: 'Raleway',
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 50),
            OptionCard(
              title: 'Paiement en ligne',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PaymentScreen()),
                );
              },
            ),
            SizedBox(height: 10), // Adjust the spacing between options
            OptionCard(
              title: 'Paiemant a la livrasion',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyForm()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class OptionCard extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  OptionCard({required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue, // Set the background color for the options
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(
            color: Colors.white, // Set the text color for the options
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}


