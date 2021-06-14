//
//  SensorData.swift
//  BSPWon
//
//  Created by Jihwan Kim on 2021/02/21.
//

import Foundation

/*
    t u v w x y z
    
 
*/

struct SensorData : SensorDataFormat
{
    
    private var _w : UInt16 = 0 
    private var _x : UInt16 = 0
    private var _y : UInt16 = 0
    private var _z : UInt16 = 0
    
    var dataW: UInt16
    {
        get
        {
            return self._w
        }
        set(value)
        {
            self._w = value
        }
    }
    
    var dataX: UInt16
    {
        get
        {
            return self._x
        }
        set(value)
        {
            self._x = value
        }
    }
    
    var dataY: UInt16
    {
        get
        {
            return self._y
        }
        set(value)
        {
            self._y = value
        }
    }
    
    var dataZ: UInt16
    {
        get
        {
            return self._z
        }
        set(value)
        {
            self._z = value
        }
    }
    
}
