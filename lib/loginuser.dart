import 'dart:math';
import 'dart:convert';

void main(List<String> args) {
  Map<String, double> shares = IslamicInheritance.calculate(1000);

// Print the share of each heir
  print('Share of sons: ${shares['son']}');
  print('Share of daughters: ${shares['daughter']}');
  print('Share of wives: ${shares['wife']}');
  print('Share of brothers: ${shares['brother']}');
  print('Share of sisters: ${shares['sister']}');
}
// import 'dart:math';

enum Gender {
  male,
  female,
}

class Heir {
  final Gender gender;
  final bool isAlive;
  final double share;

  Heir(this.gender, this.isAlive, this.share);
}

class IslamicInheritance {
  static const double husbandShare = 0.25;
  static const double wifeShare = 0.125;
  static const double sonShare = 0.5;
  static const double daughterShare = 0.5;
  static const double motherShare = 0.333;
  static const double fatherShare = 0.167;
  static const double brotherShare = 0.167;
  static const double sisterShare = 0.083;

  static Map<String, double> calculate(
    double estateValue, {
    int husband = 0,
    int wife = 0,
    int son = 0,
    int daughter = 0,
    int father = 0,
    int mother = 0,
    int brother = 0,
    int sister = 0,
    int paternalGrandfather = 0,
    int paternalGrandmother = 0,
    int maternalGrandfather = 0,
    int maternalGrandmother = 0,
  }) {
    final heirs = <Heir>[
      Heir(Gender.male, true, husbandShare * estateValue * husband),
      Heir(Gender.female, true, wifeShare * estateValue * wife),
      Heir(Gender.male, true, sonShare * estateValue * son),
      Heir(Gender.female, true, daughterShare * estateValue * daughter),
      Heir(Gender.male, mother > 0, motherShare * estateValue * mother),
      Heir(Gender.male, father > 0, fatherShare * estateValue * father),
      Heir(Gender.male, brother > 0, brotherShare * estateValue * brother),
      Heir(Gender.female, sister > 0, sisterShare * estateValue * sister),
      Heir(Gender.male, paternalGrandfather > 0,
          shareByAsabah(paternalGrandfather, 2, estateValue)),
      Heir(Gender.female, paternalGrandmother > 0,
          shareByAsabah(paternalGrandmother, 2, estateValue)),
      Heir(Gender.male, maternalGrandfather > 0,
          shareByAsabah(maternalGrandfather, 3, estateValue)),
      Heir(Gender.female, maternalGrandmother > 0,
          shareByAsabah(maternalGrandmother, 3, estateValue)),
    ];

    final totalShares =
        heirs.fold<double>(0.0, (acc, heir) => acc + heir.share);

    final distribution = (heirs.where((heir) => heir.isAlive).map((heir) =>
        MapEntry(heir.gender == Gender.male ? 'male' : 'female',
            heir.share / totalShares))).toList();

    print(distribution);
    dynamic t = {1: 1};
    return t;
  }

  static double shareByAsabah(
      int numberOfHeirs, int degreeOfRelationship, double estateValue) {
    final shares = [1, 1, 2, 4, 8, 16];
    final share = shares[min(numberOfHeirs, 5)];
    final hajbiShare = degreeOfRelationship * share / 36;
    return hajbiShare * estateValue;
  }
}

/////////////////// version 7 ////////

// Map<String, double> calculateIslamicInheritanceWithLiveHeirs(
// int son,
// int daughter,
// int wife,
// int brother,
// int sister,
// int father,
// int mother,
// int uncle,
// double estateValue,
// double debts,
// double funeralExpenses,
// ) {
//   double netEstateValue = estateValue - debts - funeralExpenses;
//   double totalShares = 0.0;

//   // Calculate the total number of live heirs
//   int liveHeirsCount =
//       son + daughter + wife + brother + sister + father + mother + uncle;

//   // If there are no live heirs, the entire estate will be distributed according to Islamic laws of inheritance
//   if (liveHeirsCount == 0) {
//     totalShares = 1.0;
//   } else {
//     // Calculate the total shares of live heirs
//     if (son > 0) {
//       // if(daughter== and wife == and brother == and sister == and father == and father== and mother == and uncle ==){

//       // }
//       totalShares += 2.0 * son;
//     }
//     if (daughter > 0) {
//       totalShares += daughter;
//     }
//     if (wife > 0) {
//       totalShares += 1.0;
//     }
//     if (brother > 0) {
//       totalShares += 1.0 * brother;
//     }
//     if (sister > 0) {
//       totalShares += 0.5 * sister;
//     }
//     if (father > 0) {
//       totalShares += 1.0;
//     }
//     if (mother > 0) {
//       totalShares += 0.6667;
//     }
//     if (uncle > 0) {
//       totalShares += 0.1667 * uncle;
//     }
//   }

//   // Calculate the share of each heir
//   Map<String, double> shares = {
//     'son': son > 0 ? (2.0 * son / totalShares) * netEstateValue : 0.0,
//     'daughter': daughter > 0 ? (daughter / totalShares) * netEstateValue : 0.0,
//     'wife': wife > 0 ? (1.0 / totalShares) * netEstateValue : 0.0,
//     'brother':
//         brother > 0 ? (1.0 * brother / totalShares) * netEstateValue : 0.0,
//     'sister': sister > 0 ? (0.5 * sister / totalShares) * netEstateValue : 0.0,
//     'father': father > 0 ? (1.0 / totalShares) * netEstateValue : 0.0,
//     'mother': mother > 0 ? (0.6667 / totalShares) * netEstateValue : 0.0,
//     'uncle': uncle > 0 ? (0.1667 * uncle / totalShares) * netEstateValue : 0.0,
//   };
//   // print();
//   return shares;
// }

////    version six//////////
// Map<String, double> calculateIslamicInheritanceWithLiveHeirs(
//   int son,
//   int daughter,
//   int wife,
//   int brother,
//   int sister,
//   int father,
//   int mother,
//   int uncle,
//   int husband,
//   double estateValue,
// ) {
//   double netEstateValue = estateValue;
//   double totalShares = 1.0;

//   // Calculate the total number of live heirs
//   int liveHeirsCount = son +
//       daughter +
//       wife +
//       brother +
//       sister +
//       father +
//       mother +
//       uncle +
//       husband;

//   // If there are no live heirs, the entire estate will be distributed according to Islamic laws of inheritance
//   if (liveHeirsCount == 0) {
//     totalShares = 1.0;
//   } else {
//     // Calculate the total shares of live heirs
//     if (son > 0) {
//       totalShares += 2.0 * son;
//     }
//     if (daughter > 0) {
//       totalShares += daughter;
//     }
//     if (wife > 0) {
//       totalShares += 1.0;
//     }
//     if (brother > 0) {
//       totalShares += 1.0 * brother;
//     }
//     if (sister > 0) {
//       totalShares += 0.5 * sister;
//     }
//     if (father > 0) {
//       totalShares += 1.0;
//     }
//     if (mother > 0) {
//       totalShares += 0.6667;
//     }
//     if (uncle > 0) {
//       totalShares += 0.1667 * uncle;
//     }
//     if (husband > 0) {
//       totalShares += 1.0;
//     }
//   }

//   // Calculate the share of each heir
//   Map<String, double> shares = {
//     'son': son > 0 ? 2.0 * son / totalShares * netEstateValue : 0.0,
//     'daughter':
//         daughter > 0 ? (1.0 * daughter / totalShares) * netEstateValue : 0.0,
//     'wife': wife > 0 ? (1.0 / totalShares) * netEstateValue : 0.0,
//     'brother': brother > 0 ? (1.0 * brother / totalShares) * netEstateValue : 0.0,
//     'sister': sister > 0 ? (0.5 * sister / totalShares) * netEstateValue : 0.0,
//     'father': father > 0 ? (1.0 / totalShares) * netEstateValue : 0.0,
//     'mother': mother > 0 ? (0.6667 / totalShares) * netEstateValue : 0.0,
//     'uncle': uncle > 0 ? (0.1667 * uncle / totalShares) * netEstateValue : 0.0,
//     'husband': husband > 0 ? (1.0 / totalShares) * netEstateValue : 0.0,
//   };

//   return shares;
// }

////      version five //////////
// Map<String, double> calculateIslamicInheritanceWithLiveHeirs(
//   int son,
//   int daughter,
//   int wife,
//   int brother,
//   int sister,
//   int father,
//   int mother,
//   int uncle,
//   double estateValue,
// ) {
//   double netEstateValue = estateValue;
//   double totalShares = 1.0;

//   // Calculate the total number of live heirs
//   int liveHeirsCount =
//       son + daughter + wife + brother + sister + father + mother + uncle;

//   // If there are no live heirs, the entire estate will be distributed according to Islamic laws of inheritance
//   if (liveHeirsCount == 0) {
//     totalShares = 1.0;
//   } else {
//     // Calculate the total shares of live heirs
//     if (son > 0) {
//       totalShares += 2.0 * son;
//     }
//     if (daughter > 0) {
//       totalShares += daughter;
//     }
//     if (wife > 0) {
//       totalShares += 1.0;
//     }
//     if (brother > 0) {
//       totalShares += 1.0 * brother;
//     }
//     if (sister > 0) {
//       totalShares += 0.5 * sister;
//     }
//     if (father > 0) {
//       totalShares += 1.0;
//     }
//     if (mother > 0) {
//       totalShares += 0.6667;
//     }
//     if (uncle > 0) {
//       totalShares += 0.1667 * uncle;
//     }
//   }

//   // Calculate the share of each heir
//   Map<String, double> shares = {
//     'son': son > 0 ? 1.0 * netEstateValue : 0.0,
//     'daughter': daughter > 0 ? 0.5 * netEstateValue : 0.0,
//     'wife': wife > 0 ? 0.0 : 0.0,
//     'brother': brother > 0 ? 0.0 : 0.0,
//     'sister': sister > 0 ? 0.0 : 0.0,
//     'father': father > 0 ? 0.0 : 0.0,
//     'mother': mother > 0 ? 0.0 : 0.0,
//     'uncle': uncle > 0 ? 0.0 : 0.0,
//   };

//   return shares;
// }

////////////////////////  version four /////////
// Map<String, double> calculateIslamicInheritanceWithLiveHeirs(
//   int son,
//   int daughter,
//   int wife,
//   int brother,
//   int sister,
//   int father,
//   int mother,
//   int uncle,
//   double estateValue,
//   double debts,
//   double funeralExpenses,
// ) {
//   double netEstateValue = estateValue - debts - funeralExpenses;
//   double totalShares = 1.0;

//   // Calculate the total number of live heirs
//   int liveHeirsCount =
//       son + daughter + wife + brother + sister + father + mother + uncle;

//   // If there are no live heirs, the entire estate will be distributed according to Islamic laws of inheritance
//   if (liveHeirsCount == 0) {
//     totalShares = 1.0;
//   } else {
//     // Calculate the total shares of live heirs
//     if (son > 0) {
//       totalShares += 2.0 * son;
//     }
//     if (daughter > 0) {
//       totalShares += daughter;
//     }
//     if (wife > 0) {
//       totalShares += 1.0;
//     }
//     if (brother > 0) {
//       totalShares += 1.0 * brother;
//     }
//     if (sister > 0) {
//       totalShares += 0.5 * sister;
//     }
//     if (father > 0) {
//       totalShares += 1.0;
//     }
//     if (mother > 0) {
//       totalShares += 0.6667;
//     }
//     if (uncle > 0) {
//       totalShares += 0.1667 * uncle;
//     }
//   }

//   // Calculate the share of each heir
//   Map<String, double> shares = {
//     'son': son > 0 ? 2.0 * son / totalShares * netEstateValue : 0.0,
//     'daughter':
//         daughter > 0 ? 1.0 * daughter / totalShares * netEstateValue : 0.0,
//     'wife': wife > 0 ? 1.0 / totalShares * netEstateValue : 0.0,
//     'brother': brother > 0 ? 1.0 * brother / totalShares * netEstateValue : 0.0,
//     'sister': sister > 0 ? 0.5 * sister / totalShares * netEstateValue : 0.0,
//     'father': father > 0 ? 1.0 / totalShares * netEstateValue : 0.0,
//     'mother': mother > 0 ? 0.6667 / totalShares * netEstateValue : 0.0,
//     'uncle': uncle > 0 ? 0.1667 * uncle / totalShares * netEstateValue : 0.0,
//   };

//   return shares;
// }
///////////////////  version three ////////////////////
// Map<String, double> calculateIslamicInheritanceWithLiveHeirs(
//   int son,
//   int daughter,
//   int wife,
//   int brother,
//   int sister,
//   int father,
//   int mother,
//   int uncle,
//   double estateValue,
// ) {
//   Map<String, int> heirs = {
//     'son': son,
//     'daughter': daughter,
//     'wife': wife,
//     'brother': brother,
//     'sister': sister,
//     'father': father,
//     'mother': mother,
//     'uncle': uncle,
//   };

//   // Calculate total number of heirs
//   int totalHeirs =
//       son + daughter + wife + brother + sister + father + mother + uncle;

//   // Calculate share for each heir
//   double baseShare =
//       estateValue / 1.0; // 1.0 represents the total share of the deceased
//   double sonShare =
//       son > 0 ? baseShare * 2 / (8 - totalHeirs) : 0; // Son's share
//   double daughterShare =
//       daughter > 0 ? baseShare / (8 - totalHeirs) : 0; // Daughter's share

//   // Calculate the remaining inheritance after giving shares to son and daughter
//   double remainingInheritance =
//       estateValue - (son * sonShare) - (daughter * daughterShare);

//   // Calculate share for other heirs
//   double wifeShare = wife > 0 ? remainingInheritance / 8 : 0; // Wife's share
//   double brotherShare = brother > 0
//       ? remainingInheritance / (6 + totalHeirs)
//       : 0; // Brother's share
//   double sisterShare = sister > 0
//       ? remainingInheritance / (6 + totalHeirs)
//       : 0; // Sister's share
//   double fatherShare =
//       father > 0 ? remainingInheritance / 6 : 0; // Father's share
//   double motherShare =
//       mother > 0 ? remainingInheritance / 6 : 0; // Mother's share
//   double uncleShare =
//       uncle > 0 ? remainingInheritance / (6 + totalHeirs) : 0; // Uncle's share

//   // Store the shares in a map
//   Map<String, double> shares = {
//     'son': sonShare,
//     'daughter': daughterShare,
//     'wife': wifeShare,
//     'brother': brotherShare,
//     'sister': sisterShare,
//     'father': fatherShare,
//     'mother': motherShare,
//     'uncle': uncleShare,
//   };

//   return shares;
// }

// ////////////// version two ///////////////////

// Map<String, double> calculateIslamicInheritanceWithLiveHeirs(
//   int son,
//   int daughter,
//   int wife,
//   int brother,
//   int sister,
//   int father,
//   int mother,
//   int uncle,
//   double estateValue,
// ) {
//   Map<String, int> heirs = {
//     'son': son,
//     'daughter': daughter,
//     'wife': wife,
//     'brother': brother,
//     'sister': sister,
//     'father': father,
//     'mother': mother,
//     'uncle': uncle,
//   };

//   // Calculate the total number of eligible heirs
//   int totalEligibleHeirs = 0;
//   for (var count in heirs.values) {
//     if (count > 0) {
//       totalEligibleHeirs += count;
//     }
//   }

//   // Calculate the shares for each eligible heir
//   Map<String, double> shares = {};
//   for (var heir in heirs.keys) {
//     int count = heirs[heir]!;
//     if (count > 0) {
//       switch (heir) {
//         case 'son':
//           if (totalEligibleHeirs > 1) {
//             shares[heir] = (2 / 3) * estateValue / count;
//           } else {
//             shares[heir] = estateValue;
//           }
//           break;
//         case 'daughter':
//           if (totalEligibleHeirs > 1) {
//             shares[heir] = (1 / 3) * estateValue / count;
//           } else {
//             shares[heir] = (1 / 2) * estateValue / count;
//           }
//           break;
//         case 'wife':
//           if (totalEligibleHeirs > 1) {
//             shares[heir] = (1 / 8) * estateValue;
//           } else {
//             shares[heir] = (1 / 4) * estateValue;
//           }
//           break;
//         case 'brother':
//           shares[heir] = (1 / 6) * estateValue / count;
//           break;
//         case 'sister':
//           shares[heir] = (1 / 6) * estateValue / count;
//           break;
//         case 'father':
//           shares[heir] = (1 / 6) * estateValue;
//           break;
//         case 'mother':
//           shares[heir] = (1 / 6) * estateValue;
//           break;
//         case 'uncle':
//           shares[heir] = (5 / 24) * estateValue / count;
//           break;
//         default:
//           shares[heir] = 0.0;
//       }
//     }
//   }

//   return shares;
// }

////////////////////////// version One //////////////////////////////////////
///
///
///

// Map<String, double> calculateIslamicInheritanceWithLiveHeirs(
//   var wiilal,
//   var gabdho,
//   var marwo,
//   var aboowe,
//   var abaayo,
//   var xaasle,
//   var aabo,
//   var hooyo,
//   var adeer,
//   var hanti,
// ) {
//   Map<String, dynamic> heirs = {
//     'wiilal': wiilal,
//     'gabdho': gabdho,
//     'marwo': marwo,
//     'aboowe': aboowe,
//     'abaayo': abaayo,
//     'xaasle': xaasle,
//     'aabo': aabo,
//     'hooyo': hooyo,
//     'adeer': adeer,
//     'hanti': hanti
//   };

//   double maleShare = 1;
//   double femaleShare = 0.5;

//   Map<String, double> shares = {};

//   if (heirs.containsKey('wiilal')) {
//     var numSons = heirs['wiilal'];
//     double sonShare = numSons > 0 ? 0.666666666666667 * maleShare : 0;
//     shares['wiilal'] = numSons * sonShare * hanti;
//   }

//   if (heirs.containsKey('gabdho')) {
//     var numDaughters = heirs['gabdho'];
//     double daughterShare =
//         numDaughters > 0 ? 0.333333333333333 * femaleShare : 0;
//     shares['gabdho'] = numDaughters * daughterShare * hanti;
//   }

//   if (heirs.containsKey('marwo')) {
//     var numWives = heirs['marwo'];
//     double wifeShare = numWives > 0 ? 0.125 : 0;
//     shares['marwo'] = numWives * wifeShare * hanti;
//   }

//   if (heirs.containsKey('aboowe')) {
//     var numFullBrothers = heirs['aboowe'];
//     double fullBrotherShare = numFullBrothers > 0 ? 1 * maleShare : 0;
//     shares['aboowe'] = numFullBrothers * fullBrotherShare * hanti;
//   }

//   if (heirs.containsKey('abaayo')) {
//     var numFullSisters = heirs['abaayo'];
//     double fullSisterShare = numFullSisters > 0 ? 0.5 * femaleShare : 0;
//     shares['abaayo'] = numFullSisters * fullSisterShare * hanti;
//   }

//   if (heirs.containsKey('xaasle')) {
//     var numHusbands = heirs['xaasle'];
//     double husbandShare = numHusbands > 0 ? 0.25 * maleShare : 0;
//     shares['xaasle'] = numHusbands * husbandShare * hanti;
//   }

//   if (heirs.containsKey('aabo')) {
//     var numFathers = heirs['aabo'];
//     double fatherShare = numFathers > 0 ? 0.166666666666667 * maleShare : 0;
//     shares['aabo'] = numFathers * fatherShare;
//   }

//   if (heirs.containsKey('hooyo')) {
//     var numMothers = heirs['hooyo'];
//     double motherShare = numMothers > 0 ? 0.166666666666667 * femaleShare : 0;
//     shares['hooyo'] = numMothers * motherShare * hanti;
//   }

//   if (heirs.containsKey('adeer')) {
//     var numUncles = heirs['adeer'];
//     double uncleShare = numUncles > 0 ? 0.166666666666667 * maleShare : 0;
//     shares['adeer'] = numUncles * uncleShare * hanti;
//   }

//   return shares;
// }
