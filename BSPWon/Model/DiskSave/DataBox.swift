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
    let dateFormatter = DateFormatter()
    
    var count : Int
    {
        return _cnt
    }
    
    func append()
    {
        let currentTime = Date()
        dateFormatter.dateFormat = "HH:mm:ss:SSSS"
        let timestamp = dateFormatter.string(from: currentTime)
        dataCollection.append(String(timestamp))
        dataCollection.append(",")
        dataCollection.append(String(SingletonBlackboard.shared.data.dataW))
        dataCollection.append(",")
        dataCollection.append(String(SingletonBlackboard.shared.data.dataX))
        dataCollection.append(",")
        dataCollection.append(String(SingletonBlackboard.shared.data.dataY))
        dataCollection.append(",")
        dataCollection.append(String(SingletonBlackboard.shared.data.dataZ))
        dataCollection.append("\n")
        
        _cnt += 4
        
        if(count > 100000)
        {
            DispatchQueue.global(qos: .background).async
            {
                self.saveToFileSystem()
                self.clear()
            }
        }
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
        dateFormatter.dateFormat = "YYYY.mm.dd.HH_mm"
        let fileName = dateFormatter.string(from: currentDateTime)
        
        guard let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        else
        {
            print("invalid url")
            return
        }
        let fileURL = dir.appendingPathComponent("\(fileName).csv")
        // writing to the file
        do
        {
            try dataCollection.write(to: fileURL, atomically: true, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
            print("FilePath : \(fileURL.path)")
        }
        catch { print(error.localizedDescription) }
    }
    
}
