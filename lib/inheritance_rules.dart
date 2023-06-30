class InheritanceCalculator {
  double calculateInheritance(String gender, int daughters, int sons,
      int sonDaughters, bool fatherExists, bool motherExists) {
    double husbandShare = 0.0;
    double wifeShare = 0.0;
    double daughterShare = 0.0;
    double fatherShare = 0.0;
    double motherShare = 0.0;
    double sonDaughterShare = 0.0;
    double fullBrotherShare = 0.0;
    double fullSisterShare = 0.0;
    double consanguineSisterShare = 0.0;
    double trueGrandmotherShare = 0.0;
    double trueGrandfatherShare = 0.0;
    double uncleAuntShare = 0.0;

    // Calculate husband's share
    if (sons == 0 && sonDaughters == 0) {
      husbandShare = 0.5;
    } else {
      husbandShare = 0.25;
    }

    // Calculate wife's share
    if (sons == 0 && sonDaughters == 0) {
      wifeShare = 0.25;
    } else {
      wifeShare = 0.125;
    }

    // Calculate daughter's share
    if (daughters == 1 && sons == 0) {
      daughterShare = 0.5;
    } else if (daughters > 1 && sons == 0) {
      daughterShare = 2 / 3;
    } else if (sons > 0) {
      daughterShare = 1;
    }

    // Calculate father's share
    if (sons > 0 || sonDaughters > 0) {
      fatherShare = 1 / 6;
    } else if (fatherExists && sons == 0 && sonDaughters == 0) {
      fatherShare = 1 / 6 + calculateResidue();
    } else if (!fatherExists && sons == 0 && sonDaughters == 0) {
      fatherShare = calculateResidue();
    }

    // Calculate mother's share
    if ((sons > 0 || daughters > 0 || sonDaughters > 0) && fatherExists) {
      motherShare = 1 / 6;
    } else if (!fatherExists && !motherExists) {
      motherShare = 1 / 3;
    } else if ((sons > 0 || daughters > 0 || sonDaughters > 0) &&
        !fatherExists &&
        motherExists) {
      motherShare = 1 / 3 * calculateResidue();
    }

    // Calculate son's daughter's share
    if (sonDaughters == 1 && daughters == 0) {
      if (sons == 0) {
        sonDaughterShare = 0.5;
      } else {
        sonDaughterShare = 1 / 3 * calculateSonShare() / 2;
      }
    } else if (sonDaughters > 1 && daughters == 0) {
      if (sons == 0) {
        sonDaughterShare = 2 / 3;
      } else {
        sonDaughterShare = 1 / 3 * calculateSonShare() / 2;
      }
    }

    // Calculate full brother's share
    if (!fatherExists && daughters == 0 && sonDaughters == 0) {
      if (gender == "male") {
        fullBrotherShare = 0.5;
      }
    } else if (fatherExists && daughters == 0 && sonDaughters == 0) {
      if (gender == "male") {
        fullBrotherShare = 1;
      }
    }

    // Calculate full sister's share
    if (!fatherExists && daughters == 0 && sonDaughters == 0) {
      if (gender == "female") {
        fullSisterShare = 0.5;
      }
    } else if (fatherExists && daughters == 0 && sonDaughters == 0) {
      if (gender == "female") {
        fullSisterShare = 1 / 2 * calculateResidue();
      }
    }

    // Calculate consanguine sister's share
    if (fatherExists && daughters == 0 && sonDaughters == 0) {
      if (gender == "female") {
        consanguineSisterShare = 1 / 2 * calculateResidue();
      }
    }

    // Calculate true grandmother's share
    if (sons > 0 || sonDaughters > 0) {
      if (!fatherExists && !motherExists) {
        trueGrandmotherShare = 1 / 6;
      } else if (!fatherExists && motherExists) {
        trueGrandmotherShare = 1 / 6 * calculateResidue();
      }
    }

    // Calculate true grandfather's share
    if (sons > 0 || sonDaughters > 0) {
      if (fatherExists && !motherExists) {
        trueGrandfatherShare = 1 / 6;
      } else if (!fatherExists && motherExists) {
        trueGrandfatherShare = 1 / 3;
      } else if (fatherExists && motherExists) {
        trueGrandfatherShare = 1 / 6;
      }
    }

    // Calculate uncle/aunt's share
    if (sons > 0 || sonDaughters > 0) {
      uncleAuntShare = 1 / 6 * calculateResidue();
    }

    // Calculate total inheritance
    double totalInheritance = husbandShare +
        wifeShare +
        daughterShare +
        fatherShare +
        motherShare +
        sonDaughterShare +
        fullBrotherShare +
        fullSisterShare +
        consanguineSisterShare +
        trueGrandmotherShare +
        trueGrandfatherShare +
        uncleAuntShare;

    return totalInheritance;
  }

  double calculateResidue() {
    return 1 - 0.5;
  }

  double calculateSonShare() {
    return 1 - 0.25;
  }
}

void main() {
  InheritanceCalculator calculator = InheritanceCalculator();

  // Example usage
  double inheritance =
      calculator.calculateInheritance('male', 2, 1, 1, true, true);
  print('Total inheritance: $inheritance');
}
