//
//  DataConversion.swift
//  BSPWon
//
//  Created by Jihwan Kim on 2021/02/14.
//

import Foundation
import CoreBluetooth


/*
 Converting incoming data type
"CHO: %d\nCH1: %d\nCH2: %d\nCH3: %d\n
 */

class DataConversion
{
    static func bleSensorStringToNumberArray(data : String) -> [Int16]
    {
        var recordFlag : Bool = false
        var charBuffer : [Character] = []
        var numberArray : [Int16] = []
        charBuffer.removeAll()
        numberArray.removeAll()
        
        for c in data
        {
            if c == " "
            {
                recordFlag = true
                continue
            }
            else if c == "\n"
            {
                recordFlag = false
                let number : Int16? = Int16(String(charBuffer))
                if let safeNumber = number
                {
                    numberArray.append(safeNumber)
                    charBuffer.removeAll()
                }
                continue
            }
            if recordFlag
            {
                charBuffer.append(c)
            }
            
        }
        
        return numberArray
    }
}
