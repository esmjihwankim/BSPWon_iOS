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
    
    // Plot for
    var currentPlot : CPTScatterPlot!
    
    // Value for setting equal to all plots
    var currentIndex: Int!
    var maxDataPoints = 100
    var frameRate = 5.0
    var alphaValue = 0.25
    
    /*
     @brief Called when sensor value updated to 
     */
    func drawPlot()
    {
        let graph = self.hostedGraph
        let plot = graph?.plot(withIdentifier: ID.wSensorValue as NSCopying)
        
        if((plot) != nil)
        {
            if(self.plotDataW.count >= maxDataPoints)
            {
                self.plotDataW.removeFirst()
                plot?.deleteData(inIndexRange: _NSRange(location: 0, length: 1))
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
        
        CPTAnimation.animate(plotSpace, property: "xRange", from: oldRange, to: newRange, duration: 0.002)
        
        self.currentIndex += 1
        
        let point = Double(SingletonBlackboard.shared.data.dataW)
        
        self.plotDataW.append(point)
        plot?.insertData(at: UInt(self.plotDataW.count-1), numberOfRecords: 1)
    }
    
}

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
