//
//  TodayHeartRateViewController.swift
//  Hypnos
//
//  Created by Fay on 16/5/25.
//  Copyright © 2016年 DMT312. All rights reserved.
//

import UIKit
import PNChart

class TodayHeartRateViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var sleepTime: UILabel!
    @IBOutlet weak var averRate: UILabel!
    var dataArr:[UInt32] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        drawLine()
        averRate.text = "\(arc4random_uniform(70)+60)Bmp"
        sleepTime.text = randomTime()

    }

    // 画折线图
    func drawLine() {
        
        let lineChart = PNLineChart(frame: self.containerView.bounds)
        lineChart.showCoordinateAxis = true
        lineChart.axisColor = UIColor.grayColor()
        lineChart.setXLabels(["3","6","9","12","15","18","21","24"], withWidth: 40)
        
        for _ in 0..<8 {
            let random = (arc4random_uniform(90)+60)
            dataArr.append(random)
        }
        
        let data = PNLineChartData()
        data.color = HypnosConfig.DefaultThemeColor
        data.itemCount = (UInt)(dataArr.count)
        data.showPointLabel = false
        data.getData = ({(index:UInt)->PNLineChartDataItem in
            let y:CGFloat = (CGFloat)(self.dataArr[(Int)(index)])
            return PNLineChartDataItem(y: y)
        })
        
        lineChart.chartData = [data]
        lineChart.strokeChart()
        containerView.addSubview(lineChart)
        
        }

    }
    
    // 睡眠时间
    private func randomTime() -> String {
        let random = arc4random_uniform(360)+240
        let hour = random / 60
        let min = random % 60
        return "\(hour)小时\(min)分"
    }
    



