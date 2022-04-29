//
//  BSPWonTests.swift
//  BSPWonTests
//
//  Created by Jihwan Kim on 2021/01/22.
//

import XCTest
@testable import BSPWon

class SensorDataTest : XCTestCase
{
    
    override func setUp()
    {
        super.setUp()
    }
    
    override func tearDown()
    {
        super.tearDown()
    }
    
    
    func testSensorDataStructure()
    {
        var sensorData = SensorData()
        sensorData.dataW = 4
        sensorData.dataX = 5
        sensorData.dataY = 6
        sensorData.dataZ = 7
        
        XCTAssertEqual(4, sensorData.dataW)
        XCTAssertEqual(5, sensorData.dataX)
        XCTAssertEqual(6, sensorData.dataY)
        XCTAssertEqual(7, sensorData.dataZ)
    }
    
    //MARK: - Test Singleton only once to avoid problems
    func testSingletonBlackboard_DataStructure()
    {
        SingletonBlackboard.shared.data.dataW = 1
        SingletonBlackboard.shared.data.dataX = 2
        SingletonBlackboard.shared.data.dataY = 3
        SingletonBlackboard.shared.data.dataZ = 4
        
        XCTAssertEqual(1, SingletonBlackboard.shared.data.dataW)
        XCTAssertEqual(2, SingletonBlackboard.shared.data.dataX)
        XCTAssertEqual(3, SingletonBlackboard.shared.data.dataY)
        XCTAssertEqual(4, SingletonBlackboard.shared.data.dataZ)
    }
    
    
}
