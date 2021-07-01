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
    func drawPlot(plotID : String)
    {
        let graph = self.hostedGraph
        let myPlot = graph?.plot(withIdentifier: plotID as NSCopying)
        
        var myPoint : Double!
        var myPlotData : [Double]
        
        switch plotID
        {
        case ID.wSensorValue:
            myPoint = Double(SingletonBlackboard.shared.data.dataW)
            myPlotData = plotDataW
            break
        case ID.xSensorValue:
            myPoint = Double(SingletonBlackboard.shared.data.dataX)
            myPlotData = plotDataX
            break
        case ID.ySensorValue:
            myPoint = Double(SingletonBlackboard.shared.data.dataY)
            myPlotData = plotDataY
            break
        case ID.zSensorValue:
            myPoint = Double(SingletonBlackboard.shared.data.dataZ)
            myPlotData = plotDataZ
            break
        default:
            myPoint = 0.0
            myPlotData = []
            print("PlotManager::Wrong Plot ID Entered!!")
            break
        }


        if((myPlot) != nil)
        {
            if(self.plotDataW.count >= maxDataPoints)
            {
                myPlotData.removeFirst()
                myPlot?.deleteData(inIndexRange: _NSRange(location: 0, length: 1))
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

        myPlotData.append(myPoint)
        
        myPlot?.insertData(at: UInt(myPlotData.count-1), numberOfRecords: 1)

    }
    
}
