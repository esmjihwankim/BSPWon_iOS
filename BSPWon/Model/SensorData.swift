//
//  SensorData.swift
//  BSPWon
//
//  Created by Jihwan Kim on 2021/02/21.
//

import Foundation



struct SensorData : SensorDataFormat
{
    private var _u : Int32 = 0
    private var _v : Int32 = 0
    private var _w : Int32 = 0
    private var _x : Int32 = 0
    private var _y : Int32 = 0
    private var _z : Int32 = 0
    private var _pulseInfo : Int32 = 0
    
    var dataU: Int32
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
    
    var dataV: Int32
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
    
    
    var dataW: Int32
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
    
    var dataX: Int32
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
    
    var dataY: Int32
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
    
    var dataZ: Int32
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
    
    var pulseInfo: Int32
    {
        get
        {
            return self._pulseInfo
        }
        set(value)
        {
            self._pulseInfo = value
        }
    }
    
}
