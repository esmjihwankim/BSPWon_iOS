//
//  SensorData.swift
//  BSPWon
//
//  Created by Jihwan Kim on 2021/02/21.
//

import Foundation



struct SensorData : SensorDataFormat
{
    private var _u : Int16 = 0
    private var _v : Int16 = 0
    private var _w : Int16 = 0
    private var _x : Int16 = 0
    private var _y : Int16 = 0
    private var _z : Int16 = 0
    
    var dataU: Int16
    {
        get
        {
            return self._u
        }
        set(value)
        {
            self._u = value
        }
    }
    
    var dataV: Int16
    {
        get
        {
            return self._v
        }
        set(value)
        {
            self._v = value
        }
    }
    
    
    var dataW: Int16
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
    
    var dataX: Int16
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
    
    var dataY: Int16
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
    
    var dataZ: Int16
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
