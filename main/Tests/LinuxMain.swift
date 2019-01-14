import XCTest

import mainTests

var tests = [XCTestCaseEntry]()
tests += mainTests.allTests()
XCTMain(tests)