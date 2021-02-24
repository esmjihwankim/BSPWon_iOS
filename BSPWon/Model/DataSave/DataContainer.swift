//
//  DataContainer.swift
//  BSPWon
//
//  Created by Jihwan Kim on 2021/02/21.
//

import Foundation

protocol DataContainer {
    
    var count : Int
    {
        get
    }
    
    func append()
    func clear()
    func saveToFileSystem()
    
}
