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
    
    // data received in "D: XXXX" or "L: YYYY" form is sorted
    static func sortChannel(input: String) -> (BLEReceivedDataType, String)
    {
        var dataType : BLEReceivedDataType?
        
        let start = input.index(input.startIndex, offsetBy: 2)
        let end = input.index(input.endIndex, offsetBy: -1)
        let substring = input[start...end]
        
        if(input[input.startIndex] == "D")
        {
            dataType = BLEReceivedDataType.Data
        }
        // logging channel
        else if(input[input.startIndex] == "L")
        {
            dataType = BLEReceivedDataType.Log
        }
        // state channel
        else if(input[input.startIndex] == "S")
        {
            dataType = BLEReceivedDataType.State
        }
        
        return (dataType!, String(substring))
    }
    
    // data received is stored in array and returned
    static func bleSensorStringToNumberArray(data : String) -> [Int32]
    {
        var storeFlag : Bool = false
        var charBuffer : [Character] = []
        var numberArray : [Int32] = []
        charBuffer.removeAll()
        numberArray.removeAll()
        
        for c in data
        {
            if c == " "
            {
                storeFlag = true
                continue
            }
            else if c == "."
            {
                storeFlag = false
                let number : Int32? = Int32(String(charBuffer))
                if let safeNumber = number
                {
                    numberArray.append(safeNumber)
                    charBuffer.removeAll()
                }
                continue
            }
            if storeFlag
            {
                charBuffer.append(c)
            }
            
        }
        
        return numberArray
    }
    
    
}
