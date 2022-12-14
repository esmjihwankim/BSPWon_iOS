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
    
    func labelTopRow()
    {
        dataCollection.append("Timestamp,U,V,W,X,Y,Z,PulseInfo,Us,Ub,Vs,Vb,Ws,Wb,X-,X+,Y-,Y+,Z-,Z+\n")
    }
    
    func append()
    {
        let currentTime = Date()
        dateFormatter.dateFormat = "HH:mm:ss:SSSS"
        let timestamp = dateFormatter.string(from: currentTime)
        dataCollection.append(String(timestamp))
        dataCollection.append(",")
        dataCollection.append(String(SingletonBlackboard.shared.data.dataU))
        dataCollection.append(",")
        dataCollection.append(String(SingletonBlackboard.shared.data.dataV))
        dataCollection.append(",")
        dataCollection.append(String(SingletonBlackboard.shared.data.dataW))
        dataCollection.append(",")
        dataCollection.append(String(SingletonBlackboard.shared.data.dataX))
        dataCollection.append(",")
        dataCollection.append(String(SingletonBlackboard.shared.data.dataY))
        dataCollection.append(",")
        dataCollection.append(String(SingletonBlackboard.shared.data.dataZ))
        dataCollection.append(",")
        dataCollection.append(String(SingletonBlackboard.shared.data.pulseInfo))
        dataCollection.append(",")
        dataCollection.append(String((SingletonBlackboard.shared.data.pulseInfo & 0b100000000000) >> 11)) // Us
        dataCollection.append(",")
        dataCollection.append(String((SingletonBlackboard.shared.data.pulseInfo & 0b010000000000) >> 10)) // Ub
        dataCollection.append(",")
        dataCollection.append(String((SingletonBlackboard.shared.data.pulseInfo & 0b001000000000) >> 9)) // Vs
        dataCollection.append(",")
        dataCollection.append(String((SingletonBlackboard.shared.data.pulseInfo & 0b000100000000) >> 8)) // Vb
        dataCollection.append(",")
        dataCollection.append(String((SingletonBlackboard.shared.data.pulseInfo & 0b000010000000) >> 7)) // Ws
        dataCollection.append(",")
        dataCollection.append(String((SingletonBlackboard.shared.data.pulseInfo & 0b000001000000) >> 6)) // Wb
        dataCollection.append(",")
        dataCollection.append(String((SingletonBlackboard.shared.data.pulseInfo & 0b000000100000) >> 5)) // X-
        dataCollection.append(",")
        dataCollection.append(String((SingletonBlackboard.shared.data.pulseInfo & 0b000000010000) >> 4)) // X+
        dataCollection.append(",")
        dataCollection.append(String((SingletonBlackboard.shared.data.pulseInfo & 0b000000001000) >> 3)) // Y-
        dataCollection.append(",")
        dataCollection.append(String((SingletonBlackboard.shared.data.pulseInfo & 0b000000000100) >> 2)) // Y+
        dataCollection.append(",")
        dataCollection.append(String((SingletonBlackboard.shared.data.pulseInfo & 0b000000000010) >> 1)) // Z-
        dataCollection.append(",")
        dataCollection.append(String(SingletonBlackboard.shared.data.pulseInfo & 0b000000000001)) // Z+
        dataCollection.append("\n")

        _cnt += 6
        
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
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
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
