// Copyright (c) 2011, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
// Test mismatch in argument counts.

class ConstructorCallWrongArgumentCountNegativeTest {
  static void testMain() {
    Stockhorn nh = new Stockhorn(1);
    nh.goodCall(1, 2, 3);
    nh = new Stockhorn();
  }
}

class Stockhorn {
  Stockhorn(int a) {}
  int goodCall(int a, int b, int c) {
    return a + b;
  }
}

main() {
  ConstructorCallWrongArgumentCountNegativeTest.testMain();
}
