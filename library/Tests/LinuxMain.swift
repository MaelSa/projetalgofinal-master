import XCTest

import libraryTests

var tests = [XCTestCaseEntry]()
tests += libraryTests.allTests()
XCTMain(tests)