//
//  PlotDatasourceDelegate.swift
//  BSPWon
//
//  Created by skkuwon on 2021/07/01.
//

import Foundation
import CorePlot


extension PlotManager : CPTScatterPlotDataSource, CPTScatterPlotDelegate
{
    func numberOfRecords(for plot: CPTPlot) -> UInt
    {
        return UInt(self.plotDataW.count)
    }
    
    
    
    func number(for plot: CPTPlot, field fieldEnum: UInt, record idx: UInt) -> Any?
    {
        switch CPTScatterPlotField(rawValue: Int(fieldEnum))!
        {
        case .X:
            return NSNumber(value: Int(idx) + self.currentIndex-self.plotDataW.count)
        case .Y:
            return self.plotDataW[Int(idx)] as NSNumber
        default:
            return 0
        }
    }
    
}

