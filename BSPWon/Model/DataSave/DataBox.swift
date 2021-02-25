//
//  DataBox.swift
//  BSPWon
//
//  Created by Jihwan Kim on 2021/02/21.
//

import Foundation

class DataBox : DataContainer {
    var _cnt = 0
    var dataCollection : String = ""

    var count : Int
    {
        return _cnt
    }
    
    func append()
    {
        dataCollection.append(String(SingletonBlackboard.shared.data.dataW))
        dataCollection.append(",")
        dataCollection.append(String(SingletonBlackboard.shared.data.dataX))
        dataCollection.append(",")
        dataCollection.append(String(SingletonBlackboard.shared.data.dataY))
        dataCollection.append(",")
        dataCollection.append(String(SingletonBlackboard.shared.data.dataZ))
        dataCollection.append("\n")
        
        _cnt += 4
    }
    
    func clear()
    {
        dataCollection.removeAll()
        _cnt = 0
    }
    
    // save to documents directory and return date of type URL?
    func saveToFileSystem()
    {
        let currentDateTime = Date()
        let df = DateFormatter()
        df.dateFormat = "yyyy.MM.dd_HH-mm"
        let fileName = df.string(from: currentDateTime)
        
        guard let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        else
        {
            print("invalid url")
            return
        }
        let fileURL = dir.appendingPathComponent("\(fileName).txt")
        // writing to the file
        do
        {
            try dataCollection.write(to: fileURL, atomically: true, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
            print("FilePath : \(fileURL.path)")
        }
        catch { print(error.localizedDescription) }
    }
    
}
