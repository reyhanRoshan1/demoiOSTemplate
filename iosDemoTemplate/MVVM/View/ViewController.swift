//
//  ViewController.swift
//  iosDemoTemplate
//
//  Created by Surinder kumar on 24/07/22.
//

import UIKit
import AAInfographics

class ViewController: UIViewController {

    @IBOutlet weak var vwCharts: AAChartView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let chartViewWidth  = self.view.frame.size.width
                let chartViewHeight = 300//300self.view.frame.size.height
                var aaChartView = AAChartView()
        aaChartView.frame = CGRect(x: 0,
                                            y: 0,
                                   width: Int(chartViewWidth),
                                            height: chartViewHeight)
                // set the content height of aachartView
                // aaChartView?.contentHeight = self.view.frame.size.height
        self.view.addSubview(aaChartView)
        
        let gradientColorDic1 = AAGradientColor.linearGradient(
            direction: .toBottom,
            startColor: AARgba(255, 20, 147, 1),//深粉色, alpha 透明度 1
            endColor: AARgba(255, 20, 147, 0.3)//热情的粉红, alpha 透明度 0.3
        )
        
        let aaChartModel = AAChartModel()
                   .chartType(.areaspline)//Can be any of the chart types listed under `AAChartType`.
                   .yAxisVisible(false)
                   .markerSymbol(.circle)
                   .title("TITLE")//The chart title
                   .subtitle("subtitle")//The chart subtitle
                   .markerSymbolStyle(.innerBlank)
                   .dataLabelsEnabled(false) //Enable or disable the data labels. Defaults to false
                   .tooltipValueSuffix("USD")//the value suffix of the chart tooltip
                   .categories(["Jan", "Feb", "Mar", "Apr", "May", "Jun",
                                "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"])
                   .colorsTheme(["#fe117c","#ffc069","#06caf4","#7dffc0"])
                   .series([
                    AASeriesElement()
                        .name("Tokyo Hot")
                        .lineWidth(5.0)
                        .color(AARgba(220, 20, 60, 1))//猩红色, alpha 透明度 1
                        .fillColor(gradientColorDic1)
                        .data([7.0, 6.9, 2.5, 14.5, 18.2, 21.5, 5.2, 26.5, 23.3, 45.3, 13.9, 9.6]),
                    ])
        
        aaChartView.aa_drawChartWithChartModel(aaChartModel)
        
        
    }

    private func configureGradientColorAreasplineChart() -> AAChartModel {
        let gradientColorDic1 = AAGradientColor.linearGradient(
            direction: .toBottom,
            startColor: AARgba(255, 20, 147, 1),//深粉色, alpha 透明度 1
            endColor: AARgba(255, 20, 147, 0.3)//热情的粉红, alpha 透明度 0.3
        )
        
        return AAChartModel()
            .chartType(.areaspline)
            .categories(["Jan", "二月", "三月", "四月", "五月", "六月",
                         "七月", "八月", "九月", "十月", "十一月", "十二月"])
            .yAxisTitle("")
            .markerRadius(8)//marker点半径为8个像素
            .markerSymbolStyle(.innerBlank)//marker点为空心效果
            .markerSymbol(.circle)//marker点为圆形点○
            .legendEnabled(false)
            .dataLabelsEnabled(false)
            .series([
                AASeriesElement()
                    .name("Tokyo Hot")
                    .lineWidth(5.0)
                    .color(AARgba(220, 20, 60, 1))//猩红色, alpha 透明度 1
                    .fillColor(gradientColorDic1)
                    .data([7.0, 6.9, 2.5, 14.5, 18.2, 21.5, 5.2, 26.5, 23.3, 45.3, 13.9, 9.6]),
                ])
    }
    
    

}

//MARK: API
extension ViewController{
    
    func userLogin(){
        UserViewModel.shared?.userLogin(email: "", password: "", completion: { [weak self] (success,msg) in
            if success{
                
            }else{
                
            }
        })
    }
    
}
