//
//  PulsingTest.swift
//  BSPWonTests
//
//  Created by skkuwon on 2022/04/29.
//

import Foundation
import XCTest
@testable import BSPWon

class DataConversionTest : XCTestCase
{
    override func setUp()
    {
        super.setUp()
    }
    
    override func tearDown()
    {
        super.tearDown()
    }
    
    func testDataSorting()
    {
        let input : String = "D: 485. 453. 343. 345. 341. 434. 33."
        var my_type : BLEReceivedDataType?
        var substr : String?
        
        (my_type, substr) = DataConversion.sortChannel(input: input)
        XCTAssertEqual(my_type, BLEReceivedDataType.Data)
        XCTAssertEqual(substr, " 485. 453. 343. 345. 341. 434. 33.")
    }
    
    
    func testDataConversion()
    {
        let input = " 485. 453. 343. 345. 341. 434. 33."
        let expected : [Int32] = [485, 453, 343, 345, 341, 434, 33]
        var output : [Int32]?
        
        output = DataConversion.bleSensorStringToNumberArray(data: input)
        
        XCTAssertEqual(output!, expected)
    }
    
    func testLogConversion()
    {
        let input = "L:Testing Log Conversion"
        let expected_string = "Testing Log Conversion"
        let expected_type = BLEReceivedDataType.Log
        
        var my_type : BLEReceivedDataType?
        var my_substring : String?
        
        (my_type, my_substring) = DataConversion.sortChannel(input: input)
        
        XCTAssertEqual(my_type, expected_type)
        XCTAssertEqual(my_substring, expected_string)
    }
    
    func testStateConversion()
    {
        let input = "S:NMPD"
        let expected_string = "NMPD"
        let expected_type = BLEReceivedDataType.State
        
        var my_type : BLEReceivedDataType?
        var my_substring : String?
        
        (my_type, my_substring) = DataConversion.sortChannel(input: input)
        
        XCTAssertEqual(my_type, expected_type)
        XCTAssertEqual(my_substring, expected_string)
            
    }
    
}
