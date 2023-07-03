//
//  Utils.swift
//  VinmoAppTests
//
//  Created by asif hussain on 3/25/23.
//

import Foundation
import UIKit
import XCTest
extension XCTestCase {
    func assert<T>(expected: T?, actual: T?, dataSet: Any?) where T: Equatable {
        let errorMsg = "\nExpected: (\"\(String(describing: expected))\") but got: (\"\(String(describing: actual))\") data: (\"\(dataSet ?? "nil")\")"
        XCTAssertEqual(expected, actual, errorMsg)
    }
}
