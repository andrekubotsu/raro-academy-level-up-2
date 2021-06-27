class CalcController {
  RegExp _regexDivOperation = RegExp(r"(([\-0-9.]+)\/([0-9.\%]+))");
  RegExp _regexMultOperation = RegExp(r"(([\-0-9.]+)\*([0-9.\%]+))");
  RegExp _regexSumOperation = RegExp(r"(^([\-0-9.]+)\+([0-9.\%]+))");
  RegExp _regexMinusOperation = RegExp(r"(^([\-0-9.]+)\-([0-9.\%]+))");

  RegExp _regexPercentSingle = RegExp(r"(^([0-9.]+)\%)");

  RegExp _regexDivPercentOperation = RegExp(r"[\/\%]");
  RegExp _regexMultPercentOperation = RegExp(r"[\*\%]");
  RegExp _regexSumPercentOperation = RegExp(r"[\+\%]");
  RegExp _regexMinusPercentOperation = RegExp(r"[\-\%]");

  RegExp _regexHasAnyOperation = RegExp(r"(^([\-0-9.]+)[\-\+\*\/]([0-9.]+))");

  RegExp _regexDivOperator = RegExp(r"[\/]");
  RegExp _regexMultOperator = RegExp(r"[\*]");
  RegExp _regexSumOperator = RegExp(r"[\+]");
  RegExp _regexMinusOperator = RegExp(r"\-(?!.*\-)");
  RegExp _regexPecentOperator = RegExp(r"[\%]");

//TODO: operações com porcentagem não estão 100%

  _singleOperation(
    String results,
    RegExp operationRegex,
    RegExp operatorRegex,
    RegExp operatorPercentRegex,
    operationFunction,
  ) {
    String match = '';

    String currentOperaton = results;
    Iterable<Match> matches = operationRegex.allMatches(currentOperaton);
    for (var m in matches) {
      match = m[0]!;
    }

    var checkPercent = _regexPecentOperator.hasMatch(match);

    print(checkPercent);

    if (checkPercent) {
      var numbers = match.split(operatorPercentRegex);

      var a = double.tryParse(numbers[0]);
      var b = double.tryParse(numbers[1]);

      if (operationFunction == _sum || operationFunction == _sub) {
        var percent = _percent(a, b);

        var result = operationFunction(a, percent);

        results = results.replaceAll(operationRegex, result.toString());

        print(results);

        return results;
      } else {
        var percentmd;
        if (b != null) {
          percentmd = b / 100;
        }
        var result = operationFunction(a, percentmd);

        results = results.replaceAll(operationRegex, result.toString());

        print(results);

        return results;
      }
    } else {
      var numbers = match.split(operatorRegex);

      var a = double.tryParse(numbers[0]);
      var b = double.tryParse(numbers[1]);

      var result = operationFunction(a, b);

      results = results.replaceAll(operationRegex, result.toString());

      print(results);

      return results;
    }
  }

  _checkOperation(operationRegex, results) {
    var hasOperation = operationRegex.hasMatch(results);
    return hasOperation;
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

  _percent(a, b) {
    return (b / 100) * a;
  }

  calculator(String operation) {
    String results = operation;

    var checkPercentSingle = _checkOperation(_regexPercentSingle, results);
    if (checkPercentSingle) {
      String match = '';
      RegExp exp = RegExp(r"(^([0-9.]+)\%)");

      String currentOperaton = results;

      Iterable<Match> matches = exp.allMatches(currentOperaton);
      for (var m in matches) {
        match = m[0]!;
      }

      var numbers = match.split(RegExp(r"[\%]"));

      var result;
      var n = double.tryParse(numbers[0]);
      if (n != null) {
        result = n / 100;
      }

      results =
          results.replaceAll(RegExp(r"(^([0-9.]+)\%)"), result.toString());

      print(result);
    }

    var checkDivOperation = _checkOperation(_regexDivOperation, results);
    if (checkDivOperation) {
      results = _singleOperation(results, _regexDivOperation, _regexDivOperator,
          _regexDivPercentOperation, _div);
    }

    var checkMultOperation = _checkOperation(_regexMultOperation, results);
    if (checkMultOperation) {
      results = _singleOperation(results, _regexMultOperation,
          _regexMultOperator, _regexMultPercentOperation, _mult);
    }

    var checkSumOperation = _checkOperation(_regexSumOperation, results);
    if (checkSumOperation) {
      results = _singleOperation(results, _regexSumOperation, _regexSumOperator,
          _regexSumPercentOperation, _sum);
    }

    var checkMinusOperation = _checkOperation(_regexMinusOperation, results);
    if (checkMinusOperation) {
      results = _singleOperation(results, _regexMinusOperation,
          _regexMinusOperator, _regexMinusPercentOperation, _sub);
    }

    var check = _checkOperation(_regexHasAnyOperation, results);

    if (check == false) {
      return results;
    } else {
      return calculator(results);
    }
  }
}
