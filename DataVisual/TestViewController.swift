//
//  TestViewController.swift
//  DataVisual
//
//  Created by Kristin Ho on 4/11/16.
//  Copyright © 2016 Kristin Ho. All rights reserved.
//

import UIKit
import SwiftCharts

class TestViewController: UIViewController {

    private var chart: Chart? // arc
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let labelSettings = ChartLabelSettings(font: UIFont.systemFontOfSize(UIFont.systemFontSize()))
        let chartSettings = ChartSettings()
        chartSettings.leading = 20
        chartSettings.top = 20
        chartSettings.trailing = 20
        chartSettings.bottom = 20
        chartSettings.labelsToAxisSpacingX = 10
        chartSettings.labelsToAxisSpacingY = 10
        chartSettings.axisTitleLabelsToLabelsSpacing = 5
        chartSettings.axisStrokeWidth = 1
        chartSettings.spacingBetweenAxesX = 15
        chartSettings.spacingBetweenAxesY = 15
        
        let chartPoints0 = [
            self.createChartPoint(0, 2, labelSettings),
            self.createChartPoint(1, -4, labelSettings),
            self.createChartPoint(2, 1, labelSettings),
            self.createChartPoint(3, 11.5, labelSettings),
            self.createChartPoint(4, 15.9, labelSettings),
            self.createChartPoint(5, 3, labelSettings),
            self.createChartPoint(6, 24, labelSettings),
            self.createChartPoint(7, 0, labelSettings),
            self.createChartPoint(8, 29, labelSettings),
            self.createChartPoint(9, 10, labelSettings),
            self.createChartPoint(10, 10, labelSettings),
            self.createChartPoint(11, 15, labelSettings),
            self.createChartPoint(12, 6, labelSettings),
            self.createChartPoint(13, 10, labelSettings),
            self.createChartPoint(14, 2, labelSettings),
            self.createChartPoint(15, 0, labelSettings),
            self.createChartPoint(16, 29, labelSettings),
            self.createChartPoint(17, 10, labelSettings),
            self.createChartPoint(18, 10, labelSettings),
            self.createChartPoint(19, 15, labelSettings),
            self.createChartPoint(20, 14, labelSettings),
            self.createChartPoint(21, 10, labelSettings),
            self.createChartPoint(22, 2, labelSettings),
            self.createChartPoint(23, 2, labelSettings)
        ]
        
        let chartPoints1 = [
            self.createChartPoint(0, 2, labelSettings),
            self.createChartPoint(1, -4, labelSettings),
            self.createChartPoint(2, 1, labelSettings),
            self.createChartPoint(3, 11.5, labelSettings),
            self.createChartPoint(4, 15.9, labelSettings),
            self.createChartPoint(5, 3, labelSettings),
            self.createChartPoint(6, 24, labelSettings),
            self.createChartPoint(7, 0, labelSettings),
            self.createChartPoint(8, 29, labelSettings),
            self.createChartPoint(9, 10, labelSettings),
            self.createChartPoint(10, 10, labelSettings),
            self.createChartPoint(11, 15, labelSettings),
            self.createChartPoint(12, 6, labelSettings),
            self.createChartPoint(13, 10, labelSettings),
            self.createChartPoint(14, 2, labelSettings),
            self.createChartPoint(15, 0, labelSettings),
            self.createChartPoint(16, 29, labelSettings),
            self.createChartPoint(17, 10, labelSettings),
            self.createChartPoint(18, 10, labelSettings),
            self.createChartPoint(19, 15, labelSettings),
            self.createChartPoint(20, 14, labelSettings),
            self.createChartPoint(21, 10, labelSettings),
            self.createChartPoint(22, 2, labelSettings),
            self.createChartPoint(23, 2, labelSettings)
        ]
        
        let xValues = 0.stride(through: 24, by: 1).map {ChartAxisValueFloat(CGFloat($0), labelSettings: labelSettings)}
        let yValues = ChartAxisValuesGenerator.generateYAxisValuesWithChartPoints(chartPoints0, minSegmentCount: 10, maxSegmentCount: 20, multiple: 2, axisValueGenerator: {ChartAxisValueDouble($0, labelSettings: labelSettings)}, addPaddingSegmentIfEdge: false)
        
        let xModel = ChartAxisModel(axisValues: xValues, axisTitleLabel: ChartAxisLabel(text: "Hour (Military Time)", settings: labelSettings))
        let yModel = ChartAxisModel(axisValues: yValues, axisTitleLabel: ChartAxisLabel(text: "Average kWh", settings: labelSettings.defaultVertical()))
        let scrollViewFrame = CGRectMake(0, 70, self.view.bounds.width, self.view.bounds.height - 70)
        let chartFrame = CGRectMake(0, 0, 1400, scrollViewFrame.size.height)
        
        // calculate coords space in the background to keep UI smooth
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            let coordsSpace = ChartCoordsSpaceLeftBottomSingleAxis(chartSettings: chartSettings, chartFrame: chartFrame, xModel: xModel, yModel: yModel)
            
            dispatch_async(dispatch_get_main_queue()) {
                let (xAxis, yAxis, innerFrame) = (coordsSpace.xAxis, coordsSpace.yAxis, coordsSpace.chartInnerFrame)
                
                let lineModel0 = ChartLineModel(chartPoints: chartPoints0, lineColor: UIColor.redColor(), animDuration: 1, animDelay: 0)
                let lineModel1 = ChartLineModel(chartPoints: chartPoints1, lineColor: UIColor.blueColor(), animDuration: 1, animDelay: 0)
                let chartPointsLineLayer = ChartPointsLineLayer(xAxis: xAxis, yAxis: yAxis, innerFrame: innerFrame, lineModels: [lineModel0, lineModel1])
                
                let settings = ChartGuideLinesDottedLayerSettings(linesColor: UIColor.blackColor(), linesWidth: 0.1)
                let guidelinesLayer = ChartGuideLinesDottedLayer(xAxis: xAxis, yAxis: yAxis, innerFrame: innerFrame, settings: settings)
                
                let scrollView = UIScrollView(frame: scrollViewFrame)
                scrollView.contentSize = CGSizeMake(chartFrame.size.width, scrollViewFrame.size.height)
                //        self.automaticallyAdjustsScrollViewInsets = false // nested view controller - this is in parent
                
                let chart = Chart(
                    frame: chartFrame,
                    layers: [
                        xAxis,
                        yAxis,
                        guidelinesLayer,
                        chartPointsLineLayer
                    ]
                )
                
                scrollView.addSubview(chart.view)
                self.view.addSubview(scrollView)
                self.chart = chart
                
            }
        }
    }
    
    private func createChartPoint(x: Double, _ y: Double, _ labelSettings: ChartLabelSettings) -> ChartPoint {
        return ChartPoint(x: ChartAxisValueDouble(x, labelSettings: labelSettings), y: ChartAxisValueDouble(y))
    }

}
