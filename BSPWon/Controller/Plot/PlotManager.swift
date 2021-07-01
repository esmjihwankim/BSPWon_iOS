//
//  ChartView.swift
//  BSPWon
//
//  Created by Jihwan Kim on 2021/03/07.
//

import UIKit
import CorePlot

class PlotManager : CPTGraphHostingView
{
    var plotDataW = [Double] (repeating: 0.0, count: 1000)
    var plotDataX = [Double] (repeating: 0.0, count: 1000)
    var plotDataY = [Double] (repeating: 0.0, count: 1000)
    var plotDataZ = [Double] (repeating: 0.0, count: 1000)
    
    // Plot for
    var plotW = CPTScatterPlot()
    var plotX = CPTScatterPlot()
    var plotY = CPTScatterPlot()
    var plotZ = CPTScatterPlot()
    
    // Value for setting equal to all plots
    var currentIndex: Int!
    var maxDataPoints = 100
    var frameRate = 5.0
    var alphaValue = 0.25
    
    
    // @brief Called when sensor value updated
    func drawPlot()
    {
        let graph = self.hostedGraph
        let plotW = graph?.plot(withIdentifier: ID.wSensorValue as NSCopying)
        let plotX = graph?.plot(withIdentifier: ID.xSensorValue as NSCopying)
        let plotY = graph?.plot(withIdentifier: ID.ySensorValue as NSCopying)
        let plotZ = graph?.plot(withIdentifier: ID.zSensorValue as NSCopying)
        
        if((plotW) != nil)
        {
            if(self.plotDataW.count >= maxDataPoints)
            {
                self.plotDataW.removeFirst()
                plotW?.deleteData(inIndexRange: _NSRange(location: 0, length: 1))
            }
        }
        
        
        guard let plotSpace = graph?.defaultPlotSpace as? CPTXYPlotSpace else { return }
        
        let location: NSInteger
        if self.currentIndex >= maxDataPoints
        {
            location = self.currentIndex - maxDataPoints + 2
        }
        else
        {
            location = 0
        }
        
        
        let range: NSInteger
        if location > 0
        {
            range = location - 1
        }
        else
        {
            range = 0
        }
        
        let oldRange = CPTPlotRange(locationDecimal: CPTDecimalFromDouble(Double(range)), lengthDecimal: CPTDecimalFromDouble(Double(maxDataPoints-2)))
        let newRange = CPTPlotRange(locationDecimal: CPTDecimalFromDouble(Double(location)), lengthDecimal: CPTDecimalFromDouble(Double(maxDataPoints-2)))
        
        CPTAnimation.animate(plotSpace, property: "xRange", from: oldRange, to: newRange, duration: 0.2)
        
        self.currentIndex += 1
        
        // Assign number to graph from Singleton
        let pointW = Double(SingletonBlackboard.shared.data.dataW)
//        let pointX = Double(SingletonBlackboard.shared.data.dataX)
//        let pointY = Double(SingletonBlackboard.shared.data.dataY)
//        let pointZ = Double(SingletonBlackboard.shared.data.dataZ)

        
        plotDataW.append(pointW)
//        plotDataX.append(pointX)
//        plotDataY.append(pointY)
//        plotDataZ.append(pointZ)

        
        plotW?.insertData(at: UInt(plotDataW.count-1), numberOfRecords: 1)
//        plotX?.insertData(at: UInt(plotDataX.count-1), numberOfRecords: 1)
//        plotY?.insertData(at: UInt(plotDataY.count-1), numberOfRecords: 1)
//        plotZ?.insertData(at: UInt(plotDataZ.count-1), numberOfRecords: 1)
    }
    
}
