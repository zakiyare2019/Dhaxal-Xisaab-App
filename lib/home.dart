import 'package:flutter/material.dart';
import 'package:dhaxalxisaab/login.dart';
import 'identification.dart' as id;

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Islamic Inheritance System'),
        actions: [
          IconButton(
            icon: Icon(Icons.login),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => (MaterialApp(
                          debugShowCheckedModeBanner: false,
                          home: Scaffold(body: MyLogin()),
                        ))),
              );
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          Center(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  HomeCard(
                    icon: Icons.calculate,
                    title: 'Calculate Inheritance',
                    description:
                        'Effortlessly calculate inheritance shares based on Islamic principles.',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>id.Identify())
                      );
                    },
                  ),
                  SizedBox(height: 20),
                  HomeCard(
                    icon: Icons.book,
                    title: 'Learn About Inheritance',
                    description:
                        'Explore educational resources about Islamic inheritance laws and guidelines.',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LearnScreen()),
                      );
                    },
                  ),
                  SizedBox(height: 20),
                  HomeCard(
                    icon: Icons.question_answer,
                    title: 'FAQs and Help',
                    description:
                        'Get answers to common questions about inheritance.',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => FaqsScreen()),
                      );
                    },
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Developed with ❤️ by Your Company',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HomeCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final VoidCallback onPressed;

  const HomeCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Icon(icon, size: 48, color: Colors.blue),
                SizedBox(height: 12),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8),
                Text(
                  description,
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LearnScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Learn About Inheritance'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Text(
          '''Welcome to the "Learn About Inheritance" section of the Islamic Inheritance System app. Here, you can explore and educate yourself on the fundamental principles of Islamic inheritance.

**Understanding Islamic Inheritance**

Islamic inheritance is a crucial aspect of Islamic law (Sharia) that governs the distribution of assets among heirs after a person's passing. The distribution is guided by principles laid out in the Quran and Hadith, ensuring fairness and justice.

**Key Principles**

1. **Compulsory Heirs:** Certain family members, known as "compulsory heirs," have specific shares reserved for them. These include parents, spouses, and children.

2. **Calculation of Shares:** Inheritance shares are calculated based on fixed percentages of the deceased person's estate. The exact percentages vary depending on the relationship between the deceased and the heir.

3. **Preventing Injustice:** Islamic inheritance laws aim to prevent injustice by ensuring that each heir receives their rightful share, while also respecting the deceased person's wishes within the limits set by Sharia.

**Educational Resources**

We provide a range of educational resources, including articles, videos, and references, to help you gain a deeper understanding of Islamic inheritance. These resources cover topics such as inheritance calculation, legal processes, and the wisdom behind the rules.

**Getting Started**

To start learning, navigate through the various sections and explore the wealth of knowledge we have compiled for you. We believe that informed decision-making is essential, and we're here to empower you with accurate and reliable information.

Thank you for choosing the Islamic Inheritance System app as your source of knowledge on Islamic inheritance. Our goal is to facilitate your understanding and provide you with the tools to navigate this important aspect of your faith and legal obligations.

''',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}

class FaqsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FAQs and Help'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Text(
          '''

**FAQs and Help**

Welcome to the FAQs and Help section of the Islamic Inheritance System app. This section is designed to provide answers to common questions and offer assistance related to Islamic inheritance laws and guidelines. Whether you're seeking clarification or guidance, you've come to the right place.

**Understanding Islamic Inheritance**

If you're new to the concept of Islamic inheritance, this is the perfect place to start. Learn about the principles behind the distribution of assets among heirs and explore how shares are calculated according to Shariah principles.

**Common Questions**

We've compiled a list of frequently asked questions about Islamic inheritance. From inheritance shares for different family members to the legal documentation involved, find answers to the questions that matter most to you.

**Legal Processes and Resolutions**

Discover the legal processes that ensure a fair and just distribution of inheritance. Explore how disputes can be resolved and learn about the options available if you need to challenge inheritance decisions.

**Educational Resources**

Expand your knowledge with educational resources and references about Islamic inheritance. Dive deeper into the intricacies of this important aspect of Islamic law and gain a comprehensive understanding.

**Contact Us**

If you can't find the answers you're looking for or need personalized assistance, don't hesitate to reach out to our dedicated support team. We're here to help you navigate the complexities of Islamic inheritance and provide you with the guidance you need.

Thank you for choosing the Islamic Inheritance System app. Our goal is to empower you with knowledge and support, so you can make informed decisions regarding inheritance matters.
.''',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
