//
//  ViewController.swift
//  DataVisual
//
//  Created by Kristin Ho on 4/10/16.
//  Copyright © 2016 Kristin Ho. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var totalHourlyKwh = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    var hourlyKwh = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    var hourlyKwh2 = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    var hourRecordCount = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    var records = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let query = PFQuery(className:"Records")

        query.limit = 200
        query.orderByAscending("time_stamp")
        
//        query.whereKey("time_stamp", containsString: "01:00")
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
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
                        self.hourlyKwh[hour!] += record["kwh"] as! Int
                        self.hourlyKwh2[hour!] += record["kwh2"]as! Int
                        self.totalHourlyKwh[hour!] += record["kwh_sum"] as! Int
                        
                        // DO THE SAME for power, power_2, and w_sum but don't increment record count
                        
                    }


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
    
    func calcAverageKwh(){
        // for each hour, get kwh[hour] divided by recordCount[hour] for its average use of recordCount[hour] days.
        // should graph it here, both 522, 523, and total
        // line or pie chart 
        
        
    }
    func calcAveragePower(){
        // for each hour, get power[hour] divided by recordCount[hour] for its average use of recordCount[hour] days.
        // should graph it here, both 522, 523, and total
        
        
    }
    func minMaxAvgUse(){
        // Highest energy use hour = <index of max(kwh_sum)> over the past <recordCount[index] days>.
        // Lowest energy use hour = <index of min(kwh_sum)> over the past <recordCount[index] days>.
        // <Device 522 or 523> uses more energy in that hour, by a difference of <__ kwh>.
    }
    
    func cumulativeUse(){
        // use records NSArray to select and graph line graph of cumulative kwh use for each device
    }
    


}

