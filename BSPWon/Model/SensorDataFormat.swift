//
//  SensorData.swift
//  BSPWon
//
//  Created by Jihwan Kim on 2021/02/21.
//

import Foundation

protocol SensorDataFormat {
    
    var dataW : Int16
    {
        get set
    }
    
    var dataX : Int16
    {
        get set
    }
    
    var dataY : Int16
    {
        get set
    }
    
    var dataZ : Int16
    {
        get set
    }

}
