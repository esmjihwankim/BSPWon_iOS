//
//  DataBox.swift
//  BSPWon
//
//  Created by Jihwan Kim on 2021/02/21.
//

import Foundation

class DataBox : DataContainer {
    
    var dataCollection : [SensorData] = []

    var count : Int
    {
        return dataCollection.count
    }
    
    func append()
    {
        dataCollection.append(SingletonBlackboard.shared.data)
    }
    
    func clear()
    {
        dataCollection.removeAll()
    }
    
    func saveToFileSystem()
    {
        
    }
    
    
    
}
