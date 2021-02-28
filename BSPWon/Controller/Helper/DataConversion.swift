//
//  DataConversion.swift
//  BSPWon
//
//  Created by Jihwan Kim on 2021/02/14.
//

import Foundation
import CoreBluetooth



class DataConversion
{
    
    static func bleSensorStringToNumberArray(data : String) -> [UInt16]?
    {
        
        var spaceFlag : Bool = false
        var newlineFlag : Bool = false
        var charBuffer : [Character] = []
        var numberArray : [UInt16] = []
        
        for char in data {
            
            if char == " "
            {
                spaceFlag = true
                continue
            }
            if char == "\n"
            {
                newlineFlag = true
                spaceFlag = false
            }
            
            if spaceFlag == true
            {
                charBuffer.append(char)
            }
            if newlineFlag == true
            {
                // char buffer to Integer type and append to number Array
                let number : UInt16? = UInt16(String(charBuffer))
                if let safeNumber = number
                {
                    numberArray.append(safeNumber)
                    newlineFlag = false
                    charBuffer.removeAll()
                }
                else
                {
                    print("number conversion not successful")
                }
            }
        }
        
        if numberArray.count != 4
        {
            return nil
        }
        
        return numberArray
    }
}
