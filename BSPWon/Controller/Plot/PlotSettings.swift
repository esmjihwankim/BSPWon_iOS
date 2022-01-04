//
//  PlotSettings.swift
//  BSPWon
//
//  Created by skkuwon on 2021/06/30.
//

import Foundation
import CorePlot

extension PlotManager
{
    
    func initGraph()
    {
        configureGraphView()
        configureGraphAxis()
        configurePlot(thisPlot: plotU, thisColor: CPTColor.cyan(),      thisID: ID.uPlotValue)
        configurePlot(thisPlot: plotV, thisColor: CPTColor.lightGray(), thisID: ID.vPlotValue)
        configurePlot(thisPlot: plotW, thisColor: CPTColor.yellow(),    thisID: ID.wPlotValue)
        configurePlot(thisPlot: plotX, thisColor: CPTColor.green(),     thisID: ID.xPlotValue)
        configurePlot(thisPlot: plotY, thisColor: CPTColor.red(),       thisID: ID.yPlotValue)
        configurePlot(thisPlot: plotZ, thisColor: CPTColor.white(),     thisID: ID.zPlotValue)
    }
    
    func configureGraphView()
    {
        self.allowPinchScaling = false
        self.plotDataW.removeAll()
        self.currentIndex = 0
    }
    
    // @brief Setting X Axis and Y Axis
    // axis line and
    func configureGraphAxis()
    {
        let graph = CPTXYGraph(frame: self.bounds)
        graph.plotAreaFrame?.masksToBorder = false
        self.hostedGraph = graph
        graph.backgroundColor = UIColor.black.cgColor
        graph.paddingBottom = 40.0
        graph.paddingLeft = 50.0
        graph.paddingTop = 30.0
        graph.paddingRight = 15.0
        
        // Set title for graph
        let titleStyle = CPTMutableTextStyle()
        titleStyle.color = CPTColor.white()
        titleStyle.fontName = "HelveticaNeue-Bold"
        titleStyle.fontSize = 20.0
        titleStyle.textAlignment = .center
        graph.titleTextStyle = titleStyle
        
        let title = "Won Research Group"
        graph.title = title
        graph.titlePlotAreaFrameAnchor = .top
        graph.titleDisplacement = CGPoint(x: 0.0, y: 0.0)
        
        let axisSet = graph.axisSet as! CPTXYAxisSet
        
        let axisTextStyle = CPTMutableTextStyle()
        axisTextStyle.color = CPTColor.white()
        axisTextStyle.fontName = "HelveticaNeue-Bold"
        axisTextStyle.fontSize = 10.0
        axisTextStyle.textAlignment = .center
        let lineStyle = CPTMutableLineStyle()
        lineStyle.lineColor = CPTColor.white()
        lineStyle.lineWidth = 5
        let gridLineStyle = CPTMutableLineStyle()
        gridLineStyle.lineColor = CPTColor.gray()
        gridLineStyle.lineWidth = 0.5
       
        if let x = axisSet.xAxis
        {
            x.majorIntervalLength = 20
            x.minorTicksPerInterval = 5
            x.labelTextStyle = axisTextStyle
            x.minorGridLineStyle = gridLineStyle
            x.axisLineStyle = lineStyle
            x.axisConstraints = CPTConstraints(lowerOffset: 0.0)
            x.delegate = self
        }
        
        if let y = axisSet.yAxis
        {
            y.majorIntervalLength = 300
            y.minorTicksPerInterval = 0
            y.minorGridLineStyle = gridLineStyle
            y.labelTextStyle = axisTextStyle
            y.alternatingBandFills = [CPTFill(color: CPTColor.init(componentRed: 255, green: 255, blue: 255, alpha: 0.03)), CPTFill(color: CPTColor.black())]
            y.axisLineStyle = lineStyle
            y.axisConstraints = CPTConstraints(lowerOffset: 0.0)
            y.delegate = self
        }
        
        let xMin = 0.0
        let xMax = 100.0
        let yMin = -300.0
        let yMax = 5000.0
        
        guard let plotSpace = graph.defaultPlotSpace as? CPTXYPlotSpace else { return }
        plotSpace.xRange = CPTPlotRange(locationDecimal: CPTDecimalFromDouble(xMin), lengthDecimal: CPTDecimalFromDouble(xMax - xMin))
        plotSpace.yRange = CPTPlotRange(locationDecimal: CPTDecimalFromDouble(yMin), lengthDecimal: CPTDecimalFromDouble(yMax - yMin))
    }

    
    // @brief Setting Plot Line and Color
    // modularized to be used many times by W, X, Y, Z channel values
    func configurePlot(thisPlot      : CPTScatterPlot,
                       thisColor     : CPTColor,
                       thisID        : String)
    {
        let plotLineStyle = CPTMutableLineStyle()
        plotLineStyle.lineJoin = .round
        plotLineStyle.lineCap = .round
        plotLineStyle.lineWidth = 2
        plotLineStyle.lineColor = thisColor
        
        thisPlot.dataLineStyle = plotLineStyle
        thisPlot.curvedInterpolationOption = .catmullCustomAlpha
        thisPlot.interpolation = .curved
        thisPlot.identifier = thisID as NSCoding & NSCopying & NSObjectProtocol
        guard let graph = self.hostedGraph else { return }
        
        // Set data source and delegate
        thisPlot.dataSource = (self as CPTPlotDataSource)
        thisPlot.delegate = (self as CALayerDelegate)
        graph.add(thisPlot, to: graph.defaultPlotSpace)
    }
    
}
