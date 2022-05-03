//
//  SingletonData.swift
//  BSPWon
//
//  Created by Jihwan Kim on 2021/02/21.
//

import Foundation

//MARK: - Read/Write Singleton
// Must Provide interface for reading and writing

final class SingletonBlackboard
{

    static let shared : SingletonBlackboard = SingletonBlackboard()
        
    var data : SensorData = SensorData()
    var log_message : String?
    var peripheral_state : String?
    
}
