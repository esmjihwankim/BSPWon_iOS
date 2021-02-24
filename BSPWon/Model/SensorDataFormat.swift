//
//  SensorData.swift
//  BSPWon
//
//  Created by Jihwan Kim on 2021/02/21.
//

import Foundation

protocol SensorDataFormat {
    
    var dataW : UInt16 {
        get set
    }
    
    var dataX : UInt16 {
        get set
    }
    
    var dataY : UInt16 {
        get set
    }
    
    var dataZ : UInt16 {
        get set
    }

}
