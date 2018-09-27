// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/src/dart/error/syntactic_errors.dart';

import 'partial_code_support.dart';

main() {
  new TryStatementTest().buildAll();
}

class TryStatementTest extends PartialCodeTest {
  buildAll() {
    buildTests(
        'try_statement',
        [
          //
          // No clauses.
          //
          new TestDescriptor(
              'keyword',
              'try',
              [
                ParserErrorCode.EXPECTED_TOKEN,
                ParserErrorCode.MISSING_CATCH_OR_FINALLY
              ],
              "try {} finally {}",
              allFailing: true),
          new TestDescriptor('noCatchOrFinally', 'try {}',
              [ParserErrorCode.MISSING_CATCH_OR_FINALLY], "try {} finally {}",
              allFailing: true),
          //
          // Single on clause.
          //
          new TestDescriptor(
              'on',
              'try {} on',
              [
                ParserErrorCode.EXPECTED_TYPE_NAME,
                ParserErrorCode.EXPECTED_TOKEN
              ],
              "try {} on _s_ {}",
              failing: [
                'block',
                'labeled',
                'localFunctionNonVoid',
                'localFunctionVoid'
              ]),
          new TestDescriptor('on_identifier', 'try {} on A',
              [ParserErrorCode.EXPECTED_TOKEN], "try {} on A {}",
              failing: ['block']),
          //
          // Single catch clause.
          //
          new TestDescriptor(
              'catch',
              'try {} catch',
              [ParserErrorCode.CATCH_SYNTAX, ParserErrorCode.EXPECTED_TOKEN],
              "try {} catch (e) {}",
              failing: ['block']),
          new TestDescriptor(
              'catch_leftParen',
              'try {} catch (',
              [
                ScannerErrorCode.EXPECTED_TOKEN,
                ParserErrorCode.CATCH_SYNTAX,
                ParserErrorCode.CATCH_SYNTAX,
                ParserErrorCode.MISSING_IDENTIFIER,
                ParserErrorCode.EXPECTED_TOKEN
              ],
              "try {} catch (e) {}",
              failing: [
                'eof',
                'block',
                'labeled',
                'localFunctionNonVoid',
                'localFunctionVoid',
                'localVariable'
              ]),
          new TestDescriptor(
              'catch_identifier',
              'try {} catch (e',
              [
                ParserErrorCode.CATCH_SYNTAX,
                ParserErrorCode.EXPECTED_TOKEN,
                ScannerErrorCode.EXPECTED_TOKEN
              ],
              "try {} catch (e) {}",
              failing: ['eof', 'block', 'labeled', 'localFunctionNonVoid']),
          new TestDescriptor(
              'catch_identifierComma',
              'try {} catch (e, ',
              [
                ParserErrorCode.CATCH_SYNTAX,
                ParserErrorCode.MISSING_IDENTIFIER,
                ParserErrorCode.EXPECTED_TOKEN,
                ScannerErrorCode.EXPECTED_TOKEN
              ],
              "try {} catch (e, _s_) {}",
              failing: [
                'eof',
                'block',
                'labeled',
                'localFunctionNonVoid',
                'localFunctionVoid',
                'localVariable'
              ]),
          new TestDescriptor(
              'catch_identifierCommaIdentifier',
              'try {} catch (e, s',
              [
                ParserErrorCode.CATCH_SYNTAX,
                ParserErrorCode.EXPECTED_TOKEN,
                ScannerErrorCode.EXPECTED_TOKEN
              ],
              "try {} catch (e, s) {}",
              failing: ['eof', 'block', 'labeled', 'localFunctionNonVoid']),
          new TestDescriptor('catch_rightParen', 'try {} catch (e, s)',
              [ParserErrorCode.EXPECTED_TOKEN], "try {} catch (e, s) {}",
              failing: ['block']),
          //
          // Single catch clause after an on clause.
          //
          new TestDescriptor(
              'on_catch',
              'try {} on A catch',
              [ParserErrorCode.CATCH_SYNTAX, ParserErrorCode.EXPECTED_TOKEN],
              "try {} on A catch (e) {}",
              failing: ['block']),
          new TestDescriptor(
              'on_catch_leftParen',
              'try {} on A catch (',
              [
                ParserErrorCode.CATCH_SYNTAX,
                ParserErrorCode.CATCH_SYNTAX,
                ParserErrorCode.MISSING_IDENTIFIER,
                ParserErrorCode.EXPECTED_TOKEN,
                ScannerErrorCode.EXPECTED_TOKEN
              ],
              "try {} on A catch (e) {}",
              failing: [
                'eof',
                'block',
                'labeled',
                'localFunctionNonVoid',
                'localFunctionVoid',
                'localVariable'
              ]),
          new TestDescriptor(
              'on_catch_identifier',
              'try {} on A catch (e',
              [
                ParserErrorCode.CATCH_SYNTAX,
                ParserErrorCode.EXPECTED_TOKEN,
                ScannerErrorCode.EXPECTED_TOKEN
              ],
              "try {} on A catch (e) {}",
              failing: ['eof', 'block', 'labeled', 'localFunctionNonVoid']),
          new TestDescriptor(
              'on_catch_identifierComma',
              'try {} on A catch (e, ',
              [
                ParserErrorCode.MISSING_IDENTIFIER,
                ParserErrorCode.CATCH_SYNTAX,
                ParserErrorCode.EXPECTED_TOKEN,
                ScannerErrorCode.EXPECTED_TOKEN
              ],
              "try {} on A catch (e, _s_) {}",
              failing: [
                'eof',
                'block',
                'labeled',
                'localFunctionVoid',
                'localFunctionNonVoid',
                'localVariable'
              ]),
          new TestDescriptor(
              'on_catch_identifierCommaIdentifier',
              'try {} on A catch (e, s',
              [
                ParserErrorCode.EXPECTED_TOKEN,
                ParserErrorCode.CATCH_SYNTAX,
                ScannerErrorCode.EXPECTED_TOKEN
              ],
              "try {} on A catch (e, s) {}",
              failing: ['eof', 'block', 'labeled', 'localFunctionNonVoid']),
          new TestDescriptor('on_catch_rightParen', 'try {} on A catch (e, s)',
              [ParserErrorCode.EXPECTED_TOKEN], "try {} on A catch (e, s) {}",
              failing: ['block']),
          //
          // Only a finally clause.
          //
          new TestDescriptor('finally_noCatch_noBlock', 'try {} finally',
              [ParserErrorCode.EXPECTED_TOKEN], "try {} finally {}",
              failing: ['block']),
          //
          // A catch and finally clause.
          //
          new TestDescriptor(
              'finally_catch_noBlock',
              'try {} catch (e) {} finally',
              [ParserErrorCode.EXPECTED_TOKEN],
              "try {} catch (e) {} finally {}",
              failing: ['block']),
        ],
        PartialCodeTest.statementSuffixes,
        head: 'f() { ',
        tail: ' }');
  }
}
