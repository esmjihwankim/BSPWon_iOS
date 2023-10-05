//
//  PerformanceMetric.swift
//  BSPWon
//
//  Created by skkuwon on 2023/10/05.
//

import Foundation

class PerformanceMetric {
    
    static var startTime : UInt64 = 0
    static var endTime : UInt64 = 0
    static var elasedTime : UInt64 = 0
    
    static func timeBlockWithMach () -> TimeInterval {
        var info = mach_timebase_info()
        guard mach_timebase_info(&info) == KERN_SUCCESS else {return -1}
        
        if (PerformanceMetric.startTime != 0) && (PerformanceMetric.endTime != 0)
        {
            PerformanceMetric.elasedTime = PerformanceMetric.endTime - PerformanceMetric.startTime
            PerformanceMetric.startTime = 0
            PerformanceMetric.endTime = 0
            let nanos = PerformanceMetric.elasedTime * UInt64(info.numer) / UInt64(info.denom)
            return TimeInterval(nanos) / TimeInterval(NSEC_PER_SEC)
        }
        else
        {
            return 0
        }
    }
}
