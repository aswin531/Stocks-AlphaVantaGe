import 'dart:async';

import 'package:http/http.dart' as http;

const alphaVantageKey =
    'X2W7VW1B29X57LJK'; //'38R26NSHL0YBTSEY'; //'GR13M54HCXZXLNZ7';
const baseUrl = 'https://www.alphavantage.co/query?';

final http.Client httpClient = http.Client();

Timer? debouncer;
