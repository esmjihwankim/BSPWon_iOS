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
        if plot.identifier?.description == ID.wSensorValue
        {
            return UInt(self.plotDataW.count)
        }
        else if plot.identifier?.description == ID.xSensorValue
        {
            return UInt(self.plotDataW.count)
        }
        else if plot.identifier?.description == ID.ySensorValue
        {
            return UInt(self.plotDataW.count)
        }
        else if plot.identifier?.description == ID.zSensorValue
        {
            return UInt(self.plotDataW.count)
        }
        
        return 0
    }
    
    
    
    func number(for plot: CPTPlot, field fieldEnum: UInt, record idx: UInt) -> Any?
    {
        switch CPTScatterPlotField(rawValue: Int(fieldEnum))!
        {
        case .X:
            if plot.identifier?.description == ID.wSensorValue
            {
                return NSNumber(value: Int(idx) + self.currentIndex-self.plotDataW.count)
            }
            else if plot.identifier?.description == ID.xSensorValue
            {
                return NSNumber(value: Int(idx) + self.currentIndex-self.plotDataX.count)
            }
            else if plot.identifier?.description == ID.ySensorValue
            {
                return NSNumber(value: Int(idx) + self.currentIndex-self.plotDataY.count)
            }
            else if plot.identifier?.description == ID.zSensorValue
            {
                return NSNumber(value: Int(idx) + self.currentIndex-self.plotDataZ.count)
            }

        case .Y:
            if plot.identifier?.description == ID.wSensorValue
            {
                return self.plotDataW[Int(idx)] as NSNumber
            }
            else if plot.identifier?.description == ID.xSensorValue
            {
                return self.plotDataX[Int(idx)] as NSNumber
            }
            else if plot.identifier?.description == ID.ySensorValue
            {
                return self.plotDataY[Int(idx)] as NSNumber
            }
            else if plot.identifier?.description == ID.zSensorValue
            {
                return self.plotDataZ[Int(idx)] as NSNumber
            }
            
        default:
            return 0
        }
        
        return 0
    }
    
}

