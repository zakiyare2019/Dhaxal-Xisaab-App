// class InheritanceRules {
//   static List<CalculationResult> calculateShares(
//       int husbandCount,
//       int wifeCount,
//       int sonCount,
//       int daughterCount,
//       int sonGrandchildCount,
//       int daughterGrandchildCount,
//       int fatherCount,
//       int motherCount,
//       int fullBrotherCount,
//       int fullSisterCount,
//       int consanguineSisterCount,
//       int trueGrandmotherCount) {
//     final List<CalculationResult> results = [];

//     // Share of Husband
//     if (sonCount == 0 && daughterCount == 0 && sonGrandchildCount == 0 && daughterGrandchildCount == 0) {
//       double husbandShare = 1 / 2;
//       results.add(CalculationResult(heir: Heir(name: 'Husband'), share: husbandShare));
//     } else {
//       double husbandShare = 1 / 4;
//       results.add(CalculationResult(heir: Heir(name: 'Husband'), share: husbandShare));
//     }

//     // Share of Wife
//     if (sonCount == 0 && daughterCount == 0 && sonGrandchildCount == 0 && daughterGrandchildCount == 0) {
//       double wifeShare = 1 / 4;
//       results.add(CalculationResult(heir: Heir(name: 'Wife'), share: wifeShare));
//     } else {
//       double wifeShare = 1 / 8;
//       results.add(CalculationResult(heir: Heir(name: 'Wife'), share: wifeShare));
//     }

//     // Share of Daughter(s)
//     if (sonCount == 0 && daughterCount == 1) {
//       double daughterShare = 1 / 2;
//       results.add(CalculationResult(heir: Heir(name: 'Daughter(s)'), share: daughterShare));
//     } else if (sonCount == 0 && daughterCount > 1) {
//       double daughterShare = 2 / 3;
//       results.add(CalculationResult(heir: Heir(name: 'Daughter(s)'), share: daughterShare));
//     } else if (sonCount > 0 && daughterCount > 0) {
//       double sonShare = 2;
//       double daughterShare = 1;
//       results.add(CalculationResult(heir: Heir(name: 'Son(s)'), share: sonShare));
//       results.add(CalculationResult(heir: Heir(name: 'Daughter(s)'), share: daughterShare));
//     }

//     // Share of Father
//     if (sonCount > 0 || daughterCount > 0 || sonGrandchildCount > 0 || daughterGrandchildCount > 0) {
//       double fatherShare = 1 / 6;
//       results.add(CalculationResult(heir: Heir(name: 'Father'), share: fatherShare));
//     } else if (fatherCount == 0) {
//       double fatherShare = 1 / 6 + (1 % 6);
//       results.add(CalculationResult(heir: Heir(name: 'Father (plus residue)'), share: fatherShare));
//     } else {
//       double fatherShare = 1;
//       results.add(CalculationResult(heir: Heir(name: 'Father (residue)'), share: fatherShare));
//     }

//     // Share of Mother
//     if (sonCount > 0 || daughterCount > 0 || sonGrandchildCount > 0 || daughterGrandchildCount > 0 ||
//         fullBrotherCount > 0 || fullSisterCount > 0 || consanguineSisterCount > 0) {
//       double motherShare = 1 / 6;
//       results.add(CalculationResult(heir: Heir(name: 'Mother'), share: motherShare));
//     } else if (motherCount == 0 && fullBrotherCount == 0 && fullSisterCount == 0 && husbandCount == 0) {
//       double motherShare = 1 / 3;
//       results.add(CalculationResult(heir: Heir(name: 'Mother'), share: motherShare));
//     } else {
//       double motherShare = 1 / 3;
//       results.add(CalculationResult(heir: Heir(name: 'Mother (of the residue)'), share: motherShare));
//     }

//     // Share of Son's Daughter
//     if (sonCount == 0 && daughterCount == 0 && sonGrandchildCount > 0) {
//       double sonGrandchildShare = 1 / 6;
//       results.add(CalculationResult(heir: Heir(name: "Son's Daughter(s)"), share: sonGrandchildShare));
//     }

//     // Share of Daughter's Daughter
//     if (sonCount == 0 && daughterCount > 0 && daughterGrandchildCount > 0) {
//       double daughterGrandchildShare = 1 / 6;
//       results.add(CalculationResult(heir: Heir(name: "Daughter's Daughter(s)"), share: daughterGrandchildShare));
//     }

//     // Share of True Grandmother
//     if (fatherCount > 0 && trueGrandmotherCount > 0) {
//       double trueGrandmotherShare = 1 / 6;
//       results.add(CalculationResult(heir: Heir(name: 'True Grandmother'), share: trueGrandmotherShare));
//     } else if (fatherCount > 0 && motherCount > 0 && trueGrandmotherCount == 0) {
//       double trueGrandmotherShare = 1 / 3;
//       results.add(CalculationResult(heir: Heir(name: 'True Grandmother'), share: trueGrandmotherShare));
//     }

//     return results;
//   }
// }

// void main() {
//   // Example inheritance scenario with counts of family members
//   int husbandCount = 1;
//   int wifeCount = 0;
//   int sonCount = 2;
//   int daughterCount = 1;
//   int sonGrandchildCount = 0;
//   int daughterGrandchildCount = 0;
//   int fatherCount = 0;
//   int motherCount = 0;
//   int fullBrotherCount = 0;
//   int fullSisterCount = 0;
//   int consanguineSisterCount = 0;
//   int trueGrandmotherCount = 0;

//   final results = InheritanceRules.calculateShares(
//     husbandCount,
//     wifeCount,
//     sonCount,
//     daughterCount,
//     sonGrandchildCount,
//     daughterGrandchildCount,
//     fatherCount,
//     motherCount,
//     fullBrotherCount,
//     fullSisterCount,
//     consanguineSisterCount,
//     trueGrandmotherCount,
//   );

//   for (var result in results) {
//     print("Share of ${result.heir.name}: ${result.share}");
//   }
// }
