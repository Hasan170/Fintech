import 'package:flutter/material.dart';

class BusinessLoan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.blue,
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionWidget(
              heading: 'Business Loan',
              details:
                  "Fast approval, minimal documentation. Borrow up to 50,00,000 with flexible tenure and competitive interest rates.",
            ),
            SectionWidget(
              heading: 'Documents',
              details: 'Submit ID proof, address proof, and income statements',
            ),
            SectionWidget(
              heading: 'Eligibility Criteria',
              details: 'Minimum age 21, salaried or self-employed',
            ),
            SectionWidget(
              heading: 'Loan Amount',
              details: 'Upto 50,00,000.',
            ),
            SectionWidget(
              heading: 'Tenure',
              details: 'Flexible repayment tenure from 1 to 5 years',
            ),
            SectionWidget(
              heading: 'Interest',
              details: 'Competitive rates starting from 9.99% p.a.',
            ),
            SectionWidget(
              heading: 'Processing Fee',
              details: 'Processing Fee ranges from Rs 500 to Rs 3500',
            ),
            // Add more SectionWidgets for additional sections
          ],
        ),
      ),
    );
  }
}

class SectionWidget extends StatelessWidget {
  final String heading;
  final String details;

  const SectionWidget({
    required this.heading,
    required this.details,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          heading,
          style: const TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          details,
          style: const TextStyle(
            fontSize: 15.0,
          ),
        ),
        const SizedBox(height: 16.0), // Adjust spacing as needed
      ],
    );
  }
}
