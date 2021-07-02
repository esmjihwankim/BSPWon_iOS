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
    
    // Plot Instance
    var plotW = CPTScatterPlot()
    var plotX = CPTScatterPlot()
    var plotY = CPTScatterPlot()
    var plotZ = CPTScatterPlot()
    
    // Value for setting. Equal for all plots
    var currentIndex: Int!
    var maxDataPoints = 100
    var frameRate = 5.0
    var alphaValue = 0.25
    
    // @brief Called when sensor value updated
    // @param plotID
    func drawPlotW()
    {
        let graph = self.hostedGraph
        let myPlot = graph?.plot(withIdentifier: ID.wPlotValue as NSCopying)
        let point : Double = Double(SingletonBlackboard.shared.data.dataW)
        
        if((myPlot) != nil)
        {
            if plotDataW.count >= maxDataPoints
            {
                plotDataW.removeFirst()
                myPlot?.deleteData(inIndexRange: _NSRange(location: 0, length: 1))
            }
        }
        plotDataW.append(point)
        myPlot?.insertData(at: UInt(plotDataW.count-1), numberOfRecords: 1)

    }
    
    
    
    
    func drawPlotX()
    {
        let graph = self.hostedGraph
        let myPlot = graph?.plot(withIdentifier: ID.xPlotValue as NSCopying)
        let point : Double = Double(SingletonBlackboard.shared.data.dataX)
        
        if((myPlot) != nil)
        {
            if plotDataX.count >= maxDataPoints
            {
                plotDataX.removeFirst()
                myPlot?.deleteData(inIndexRange: _NSRange(location: 0, length: 1))
            }
        }
        plotDataX.append(point)
        myPlot?.insertData(at: UInt(plotDataX.count-1), numberOfRecords: 1)
    }
    
    func drawPlotY()
    {
        let graph = self.hostedGraph
        let myPlot = graph?.plot(withIdentifier: ID.yPlotValue as NSCopying)
        let point : Double = Double(SingletonBlackboard.shared.data.dataY)
        
        if((myPlot) != nil)
        {
            if plotDataY.count >= maxDataPoints
            {
                plotDataY.removeFirst()
                myPlot?.deleteData(inIndexRange: _NSRange(location: 0, length: 1))
            }
        }
        plotDataY.append(point)
        myPlot?.insertData(at: UInt(plotDataY.count-1), numberOfRecords: 1)
    }
    
    func drawPlotZ()
    {
        let graph = self.hostedGraph
        let myPlot = graph?.plot(withIdentifier: ID.zPlotValue as NSCopying)
        let point : Double = Double(SingletonBlackboard.shared.data.dataZ)
        
        if((myPlot) != nil)
        {
            if plotDataZ.count >= maxDataPoints
            {
                plotDataZ.removeFirst()
                myPlot?.deleteData(inIndexRange: _NSRange(location: 0, length: 1))
            }
            
        }
        guard let plotSpace = graph?.defaultPlotSpace as? CPTXYPlotSpace else { return }
        plotSpace.allowsUserInteraction = true

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
        plotDataZ.append(point)
        myPlot?.insertData(at: UInt(plotDataZ.count-1), numberOfRecords: 1)
    }
}
