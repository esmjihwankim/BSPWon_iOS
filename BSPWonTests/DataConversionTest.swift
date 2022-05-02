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
        let input : String = "D: 485. 453. 343. 345. 341. 434."
        var my_type : BLEReceivedDataType?
        var substr : String?
        
        (my_type, substr) = DataConversion.sortChannel(input: input)
        XCTAssertEqual(my_type, BLEReceivedDataType.Data)
        XCTAssertEqual(substr, " 485. 453. 343. 345. 341. 434.")
    }
    
    
    func testDataConversion()
    {
        let input = " 485. 453. 343. 345. 341. 434."
        let expected : [Int32] = [485, 453, 343, 345, 341, 434]
        var output : [Int32]?
        
        output = DataConversion.bleSensorStringToNumberArray(data: input)
        
        XCTAssertEqual(output!, expected)
        
        
    }
    
}
