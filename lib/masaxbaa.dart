import 'dart:convert';
import 'dart:io';
import 'result.dart';

void main(List<String> args) {
  final inheritance = calculateIslamicInheritance(
      100, 0, 0, 1, 2 / 3, 1 / 8, 0, 0, 0, 1 / 3, 0, 0);
  final json = jsonEncode(
      inheritance.map((h) => {'name': h.name, 'share': h.share}).toList());
  InheritanceScreen(
    jsonData: json,
  );
  

  // print('Inheritance written to file: $filename');
}

class Heir {
  final String name;
  double share;

  Heir(this.name, this.share);

  Heir updateShare(double newShare) {
    return Heir(name, newShare);
  }
}

List<Heir> calculateIslamicInheritance(
    double estateValue,
    double debts,
    double funeralExpenses,
    double son,
    double daughter,
    double wife,
    double brother,
    double sister,
    double father,
    double mother,
    double uncle,
    double husband) {
  final double total = estateValue - debts - funeralExpenses;

  final List<Heir> heirs = [
    Heir('Son', son),
    Heir('Daughter', daughter),
    Heir('Wife', wife),
    Heir('Brother', brother),
    Heir('Sister', sister),
    Heir('Father', father),
    Heir('Mother', mother),
    Heir('Uncle', uncle),
    Heir('Husband', husband),
  ];

  // Remove heirs with zero shares
  heirs.removeWhere((heir) => heir.share == 0);

  // Calculate total shares
  double totalShares = heirs.fold<double>(0, (prev, curr) => prev + curr.share);

  // If total shares are less than 1, add the remaining share to the closest male relative
  if (totalShares < 1) {
    Heir maleRelative = heirs.firstWhere(
      (heir) =>
          heir.name == 'Son' ||
          heir.name == 'Brother' ||
          heir.name == 'Father' ||
          heir.name == 'Uncle' ||
          heir.name == 'Husband',
      orElse: () => Heir('', 0),
    );

    if (maleRelative != null) {
      maleRelative =
          maleRelative.updateShare(maleRelative.share + (1 - totalShares));
      totalShares = 1;
    }
  }

  // If total shares are greater than 1, adjust the shares proportionally
  if (totalShares > 1) {
    heirs.forEach((heir) {
      if (heir.share > 1 / totalShares) {
        heir.share = heir.share / totalShares;
      }
    });

    totalShares = heirs.fold<double>(0, (prev, curr) => prev + curr.share);
  }

  // Calculate inheritance for each heir
  final List<Heir> inheritance = [];
  heirs.forEach((heir) {
    double amount = double.parse((total * heir.share).toStringAsFixed(2));
    inheritance.add(Heir(heir.name, double.parse((amount.toStringAsFixed(2)))));
  });

  return inheritance;
}
