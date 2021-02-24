//
//  DataConversion.swift
//  BSPWon
//
//  Created by Jihwan Kim on 2021/02/14.
//

// https://devzone.nordicsemi.com/nordic/nordic-blog/b/blog/posts/nrf_2d00_connect_2d00_simd_2d00_optimizations_2d00_in_2d00_swift
// https://devzone.nordicsemi.com/nordic/nordic-blog/b/blog/posts/on-nrf-connect-for-ios-and-its-unnecessary-bitfield-collection-in-swift

// https://stackoverflow.com/questions/32894363/reading-a-ble-peripheral-characteristic-and-checking-its-value
// https://stackoverflow.com/questions/38023838/round-trip-swift-number-types-to-from-data

import Foundation
import CoreBluetooth



class DataConversion
{
    
    static func bleSensorStringToNumberArray(data : String) -> [UInt16]
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
        
        return numberArray
                
    }
    
}
