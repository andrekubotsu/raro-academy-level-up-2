class CalcController {
  RegExp _regexDivOperation = RegExp(r"(^([\-0-9.]+)\/([0-9.]+))");
  RegExp _regexMultOperation = RegExp(r"(^([\-0-9.]+)\*([0-9.]+))");
  RegExp _regexSumOperation = RegExp(r"(^([\-0-9.]+)\+([0-9.]+))");
  RegExp _regexMinusOperation = RegExp(r"(^([\-0-9.]+)\-([0-9.]+))");

  //RegExp regexPercentSingle = RegExp(r"(^([0-9.]+)\%)");

  //RegExp regexHasAnyOperation = RegExp(r"(^([\-0-9.]+)[\-\+\*\/]([0-9.]+))");

  RegExp _regexDivOperator = RegExp(r"[\/]");
  RegExp _regexMultOperator = RegExp(r"[\*]");
  RegExp _regexSumOperator = RegExp(r"[\+]");
  RegExp _regexMinusOperator = RegExp(r"\-(?!.*\-)");
  //RegExp regexPecentOperator = RegExp(r"[\%]");

  RegExp _regexMultDivOperators = RegExp(r"[\*\/]");
  RegExp _regexSumSubOperators = RegExp(r"[\+\-]");

  bool _toBeChecked(RegExp toBeCheckedRegex, String results) {
    bool hasChecked = toBeCheckedRegex.hasMatch(results);
    return hasChecked;
  }

  _singleOperation(
    String results,
    RegExp operationRegex,
    RegExp operatorRegex,
    operationFunction,
  ) {
    String match = '';
    double result;

    String currentOperaton = results;
    Iterable<Match> matches = operationRegex.allMatches(currentOperaton);
    for (var m in matches) {
      match = m[0]!;
    }

    var numbers = match.split(operatorRegex);

    print(numbers);

    var a = double.tryParse(numbers[0]);
    var b = double.tryParse(numbers[1]);

    print(a);
    print(b);

    if (a != null && b != null) {
      result = operationFunction(a, b);
      results = results.replaceAll(operationRegex, result.toString());
      print(results);

      return results;
    } else {
      print("Algo deu errado!");
    }
  }

  calculator(operation) {
    String results = operation;
    bool checkMultDivPresence;
    do {
      int multIndex;
      int divIndex;
      checkMultDivPresence = _toBeChecked(_regexMultDivOperators, results);
      if (checkMultDivPresence == true) {
        multIndex = results.indexOf("*");
        divIndex = results.indexOf("/");

        print(multIndex);
        print(divIndex);

        if (multIndex > -1 && divIndex > multIndex || divIndex == -1) {
          results = _singleOperation(
              results, _regexMultOperation, _regexMultOperator, _mult);
        } else {
          results = _singleOperation(
              results, _regexDivOperation, _regexDivOperator, _div);
        }
      }
    } while (checkMultDivPresence == true);

    bool checkSumSubPresence;

    do {
      int sumIndex;
      int subIndex;
      checkSumSubPresence = _toBeChecked(_regexSumSubOperators, results);
      if (checkSumSubPresence == true) {
        sumIndex = results.indexOf("+");
        subIndex = results.indexOf("-");

        print(sumIndex);
        print(subIndex);

        if (sumIndex > -1 && subIndex > sumIndex ||
            subIndex == -1 ||
            subIndex == 0) {
          results = _singleOperation(
              results, _regexSumOperation, _regexSumOperator, _sum);
        } else {
          results = _singleOperation(
              results, _regexMinusOperation, _regexMinusOperator, _sub);
        }
      }
    } while (checkSumSubPresence == true);

    return results;
  }

  _sum(a, b) {
    return a + b;
  }

  _sub(a, b) {
    return a - b;
  }

  _mult(a, b) {
    return a * b;
  }

  _div(a, b) {
    return a / b;
  }
}
