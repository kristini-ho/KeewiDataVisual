//
//  ViewController.swift
//  DataVisual
//
//  Created by Kristin Ho on 4/10/16.
//  Copyright © 2016 Kristin Ho. All rights reserved.
//

import UIKit
import SwiftCharts

class ViewController: UIViewController {
    
    /*

    A couple comments: given more time I would have implemented a nice kind of segment control (using a pod 
    PageMenu that allows you to customize it and make it look really nice) to allow the user to select between various kinds of graphs they want to look at. Some of it's a bit messy, but given more time I'd organize it more efficiently and make it much much more complete and convenient as an app.
    
    I have below arrays for the power/Watts as well, and was also going to have a graph showing the cumulative kWh along y-axis with actual calendar dates along the x-axis (as opposed to hour of day, and average hourly usage).
    
    I did spend probably 1-2 hours more than the time limit, BUT that time was due to lots of installation issues/overhead of figuring out issues that turned out to be due to compatability and etc. (I tried to use one that required Xcode 7.3, which I discovered post trying to figure out the issues, then tried to update Xcode, which didn't work out, and a variety of installation-related stuff like that. I similarly had issues integrating Parse into the project, and had to redo it due to having the pods mess it up, before eventually investigating one that works with earlier Xcode.)
    
    Without those installation-downloading-configuring-etc type issues, my actual coding and implementation time including the figuring out how to do stuff was within the time constraint!
    */
    
    private var chart: Chart? // arc
    
    var totalHourlyKwh = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
    var hourlyKwh = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
    var hourlyKwh2 = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
    
    var avgTotalHourlyKwh = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
    var avgHourlyKwh = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
    var avgHourlyKwh2 = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
    
    var totalHourlyPower = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
    var hourlyPower = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
    var hourlyPower2 = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
    
    var avgTotalHourlyPower = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
    var avgHourlyPower = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
    var avgHourlyPower2 = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
    
    var hourRecordCount = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
    var records = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view, typically from a nib.
        let query = PFQuery(className:"Records")

        query.limit = 200
        
//        query.orderByAscending("time_stamp")
//        query.whereKey("time_stamp", containsString: "01:00")
        
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in

            print("Querying...\n")
            
            if error == nil {
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) records.")
                // Do something with the found objects
                if let objects = objects {
                    self.records = objects as NSArray
                    for record in objects {
                        //print(record["kwh"])
                        //print(record["time_stamp"])
                        
                        let timeStamp = record["time_stamp"] as! String
                        let range = timeStamp.startIndex.advancedBy(11)..<timeStamp.endIndex.advancedBy(-12)
                        let hour = Int(timeStamp[range])
                        print("hour is, ", hour, "with kwh, ", record["kwh"])
                        self.hourRecordCount[hour!]++
                        self.hourlyKwh[hour!] += record["kwh"] as! Double
                        self.hourlyKwh2[hour!] += record["kwh_2"] as! Double
                        self.totalHourlyKwh[hour!] += record["kwh_sum"] as! Double
                        
                        // DO THE SAME for power, power_2, and w_sum but don't increment record count
                        
                    }
                    self.calcAverages()
                    self.graphKWH()


                }
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func calcAverages(){

        for index in 0...23{
            let days = hourRecordCount[index]
            avgTotalHourlyKwh[index] = totalHourlyKwh[index] / days
            avgHourlyKwh[index] = hourlyKwh[index] / days
            avgHourlyKwh2[index] = hourlyKwh2[index] / days
            
            avgTotalHourlyPower[index] = totalHourlyPower[index] / days
            avgHourlyPower[index] = hourlyPower[index] / days
            avgHourlyPower2[index] = hourlyPower2[index] / days
            
            print("avg hourly kwh for hour, ", index, " is, ", avgHourlyKwh[index])
        }
        
        
        
        
    }
   
    func minMaxAvgUse(){
        // Highest energy use hour = <index of max(kwh_sum)> over the past <recordCount[index] days>.
        // Lowest energy use hour = <index of min(kwh_sum)> over the past <recordCount[index] days>.
        // <Device 522 or 523> uses more energy in that hour, by a difference of <__ kwh>.
    }
    
    func cumulativeUse(){
        // use records NSArray to select and graph line graph of cumulative kwh use for each device
    }
    
    func graphKWH(){
        let arr = avgHourlyKwh
        let arr2 = avgHourlyKwh2
        let arr3 = avgTotalHourlyKwh
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
            self.createChartPoint(0, arr[0], labelSettings),
            self.createChartPoint(1, arr[1], labelSettings),
            self.createChartPoint(2, arr[2], labelSettings),
            self.createChartPoint(3, arr[3], labelSettings),
            self.createChartPoint(4, arr[4], labelSettings),
            self.createChartPoint(5, arr[5], labelSettings),
            self.createChartPoint(6, arr[6], labelSettings),
            self.createChartPoint(7, arr[7], labelSettings),
            self.createChartPoint(8, arr[8], labelSettings),
            self.createChartPoint(9, arr[9], labelSettings),
            self.createChartPoint(10, arr[10], labelSettings),
            self.createChartPoint(11, arr[11], labelSettings),
            self.createChartPoint(12, arr[12], labelSettings),
            self.createChartPoint(13, arr[13], labelSettings),
            self.createChartPoint(14, arr[14], labelSettings),
            self.createChartPoint(15, arr[15], labelSettings),
            self.createChartPoint(16, arr[16], labelSettings),
            self.createChartPoint(17, arr[17], labelSettings),
            self.createChartPoint(18, arr[18], labelSettings),
            self.createChartPoint(19, arr[19], labelSettings),
            self.createChartPoint(20, arr[20], labelSettings),
            self.createChartPoint(21, arr[21], labelSettings),
            self.createChartPoint(22, arr[22], labelSettings),
            self.createChartPoint(23, arr[23], labelSettings)
        ]
        
        let chartPoints1 = [
            self.createChartPoint(0, arr2[0], labelSettings),
            self.createChartPoint(1, arr2[1], labelSettings),
            self.createChartPoint(2, arr2[2], labelSettings),
            self.createChartPoint(3, arr2[3], labelSettings),
            self.createChartPoint(4, arr2[4], labelSettings),
            self.createChartPoint(5, arr2[5], labelSettings),
            self.createChartPoint(6, arr2[6], labelSettings),
            self.createChartPoint(7, arr2[7], labelSettings),
            self.createChartPoint(8, arr2[8], labelSettings),
            self.createChartPoint(9, arr2[9], labelSettings),
            self.createChartPoint(10, arr2[10], labelSettings),
            self.createChartPoint(11, arr2[11], labelSettings),
            self.createChartPoint(12, arr2[12], labelSettings),
            self.createChartPoint(13, arr2[13], labelSettings),
            self.createChartPoint(14, arr2[14], labelSettings),
            self.createChartPoint(15, arr2[15], labelSettings),
            self.createChartPoint(16, arr2[16], labelSettings),
            self.createChartPoint(17, arr2[17], labelSettings),
            self.createChartPoint(18, arr2[18], labelSettings),
            self.createChartPoint(19, arr2[19], labelSettings),
            self.createChartPoint(20, arr2[20], labelSettings),
            self.createChartPoint(21, arr2[21], labelSettings),
            self.createChartPoint(22, arr2[22], labelSettings),
            self.createChartPoint(23, arr2[23], labelSettings)
        ]

        let chartPoints2 = [
            self.createChartPoint(0, arr3[0], labelSettings),
            self.createChartPoint(1, arr3[1], labelSettings),
            self.createChartPoint(2, arr3[2], labelSettings),
            self.createChartPoint(3, arr3[3], labelSettings),
            self.createChartPoint(4, arr3[4], labelSettings),
            self.createChartPoint(5, arr3[5], labelSettings),
            self.createChartPoint(6, arr3[6], labelSettings),
            self.createChartPoint(7, arr3[7], labelSettings),
            self.createChartPoint(8, arr3[8], labelSettings),
            self.createChartPoint(9, arr3[9], labelSettings),
            self.createChartPoint(10, arr3[10], labelSettings),
            self.createChartPoint(11, arr3[11], labelSettings),
            self.createChartPoint(12, arr3[12], labelSettings),
            self.createChartPoint(13, arr3[13], labelSettings),
            self.createChartPoint(14, arr3[14], labelSettings),
            self.createChartPoint(15, arr3[15], labelSettings),
            self.createChartPoint(16, arr3[16], labelSettings),
            self.createChartPoint(17, arr3[17], labelSettings),
            self.createChartPoint(18, arr3[18], labelSettings),
            self.createChartPoint(19, arr3[19], labelSettings),
            self.createChartPoint(20, arr3[20], labelSettings),
            self.createChartPoint(21, arr3[21], labelSettings),
            self.createChartPoint(22, arr3[22], labelSettings),
            self.createChartPoint(23, arr3[23], labelSettings)
        ]

        var maxVal = avgTotalHourlyKwh[0]
        
        for number in avgTotalHourlyKwh {
            if maxVal < number {
                maxVal = number
            }
        }
        
        let xValues = 0.stride(through: 23, by: 1).map {ChartAxisValueFloat(CGFloat($0), labelSettings: labelSettings)}
        let yValues = ChartAxisValuesGenerator.generateYAxisValuesWithChartPoints(chartPoints0, minSegmentCount: 10, maxSegmentCount: 25, multiple: maxVal/10, axisValueGenerator: {ChartAxisValueDouble($0, labelSettings: labelSettings)}, addPaddingSegmentIfEdge: false)
        
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
                let lineModel1 = ChartLineModel(chartPoints: chartPoints1, lineColor: UIColor.greenColor(), animDuration: 1, animDelay: 0)
                let lineModel2 = ChartLineModel(chartPoints: chartPoints2, lineColor: UIColor.blueColor(), animDuration: 1, animDelay: 0)
                
                let chartPointsLineLayer = ChartPointsLineLayer(xAxis: xAxis, yAxis: yAxis, innerFrame: innerFrame, lineModels: [lineModel0, lineModel1, lineModel2])
                
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

