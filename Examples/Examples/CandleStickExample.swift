//
//  CandleStickExample.swift
//  SwiftCharts
//
//  Created by ischuetz on 04/05/15.
//  Copyright (c) 2015 ivanschuetz. All rights reserved.
//

import UIKit
import SwiftCharts

class CandleStickExample: UIViewController {

    private var chart: Chart? // arc

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let labelSettings = ChartLabelSettings(font: ExamplesDefaults.labelFont)

        var readFormatter = NSDateFormatter()
        readFormatter.dateFormat = "dd.MM.yyyy"
        
        var displayFormatter = NSDateFormatter()
        displayFormatter.dateFormat = "MMM dd"
        
        let date = {(str: String) -> NSDate in
            return readFormatter.dateFromString(str)!
        }
        
        let calendar = NSCalendar.currentCalendar()
        
        let dateWithComponents = {(day: Int, month: Int, year: Int) -> NSDate in
            let components = NSDateComponents()
            components.day = day
            components.month = month
            components.year = year
            return calendar.dateFromComponents(components)!
        }
        
        func filler(date: NSDate) -> ChartAxisValueDate {
            let filler = ChartAxisValueDate(date: date, formatter: displayFormatter)
            filler.hidden = true
            return filler
        }
        
        let chartPoints = [
            ChartPointCandleStick(date: date("01.10.2015"), formatter: displayFormatter, high: 40, low: 37, open: 39.5, close: 39),
            ChartPointCandleStick(date: date("02.10.2015"), formatter: displayFormatter, high: 39.8, low: 38, open: 39.5, close: 38.4),
            ChartPointCandleStick(date: date("03.10.2015"), formatter: displayFormatter, high: 43, low: 39, open: 41.5, close: 42.5),
            ChartPointCandleStick(date: date("04.10.2015"), formatter: displayFormatter, high: 48, low: 42, open: 44.6, close: 44.5),
            ChartPointCandleStick(date: date("05.10.2015"), formatter: displayFormatter, high: 45, low: 41.6, open: 43, close: 44),
            ChartPointCandleStick(date: date("06.10.2015"), formatter: displayFormatter, high: 46, low: 42.6, open: 44, close: 46),
            ChartPointCandleStick(date: date("07.10.2015"), formatter: displayFormatter, high: 47.5, low: 41, open: 42, close: 45.5),
            ChartPointCandleStick(date: date("08.10.2015"), formatter: displayFormatter, high: 50, low: 46, open: 46, close: 49),
            ChartPointCandleStick(date: date("09.10.2015"), formatter: displayFormatter, high: 45, low: 41, open: 44, close: 43.5),
            ChartPointCandleStick(date: date("11.10.2015"), formatter: displayFormatter, high: 47, low: 35, open: 45, close: 39),
            ChartPointCandleStick(date: date("12.10.2015"), formatter: displayFormatter, high: 45, low: 33, open: 44, close: 40),
            ChartPointCandleStick(date: date("13.10.2015"), formatter: displayFormatter, high: 43, low: 36, open: 41, close: 38),
            ChartPointCandleStick(date: date("14.10.2015"), formatter: displayFormatter, high: 42, low: 31, open: 38, close: 39),
            ChartPointCandleStick(date: date("15.10.2015"), formatter: displayFormatter, high: 39, low: 34, open: 37, close: 36),
            ChartPointCandleStick(date: date("16.10.2015"), formatter: displayFormatter, high: 35, low: 32, open: 34, close: 33.5),
            ChartPointCandleStick(date: date("17.10.2015"), formatter: displayFormatter, high: 32, low: 29, open: 31.5, close: 31),
            ChartPointCandleStick(date: date("18.10.2015"), formatter: displayFormatter, high: 31, low: 29.5, open: 29.5, close: 30),
            ChartPointCandleStick(date: date("19.10.2015"), formatter: displayFormatter, high: 29, low: 25, open: 25.5, close: 25),
            ChartPointCandleStick(date: date("20.10.2015"), formatter: displayFormatter, high: 28, low: 24, open: 26.7, close: 27.5),
            ChartPointCandleStick(date: date("21.10.2015"), formatter: displayFormatter, high: 28.5, low: 25.3, open: 26, close: 27),
            ChartPointCandleStick(date: date("22.10.2015"), formatter: displayFormatter, high: 30, low: 28, open: 28, close: 30),
            ChartPointCandleStick(date: date("25.10.2015"), formatter: displayFormatter, high: 31, low: 29, open: 31, close: 31),
            ChartPointCandleStick(date: date("26.10.2015"), formatter: displayFormatter, high: 31.5, low: 29.2, open: 29.6, close: 29.6),
            ChartPointCandleStick(date: date("27.10.2015"), formatter: displayFormatter, high: 30, low: 27, open: 29, close: 28.5),
            ChartPointCandleStick(date: date("28.10.2015"), formatter: displayFormatter, high: 32, low: 30, open: 31, close: 30.6),
            ChartPointCandleStick(date: date("29.10.2015"), formatter: displayFormatter, high: 35, low: 31, open: 31, close: 33)
        ]
        
        let yValues = Array(stride(from: 20, through: 55, by: 5)).map {ChartAxisValueDouble($0, labelSettings: labelSettings)}
        
        func generateDateAxisValues(month: Int, year: Int) -> [ChartAxisValueDate] {
            let date = dateWithComponents(1, month, year)
            let calendar = NSCalendar.currentCalendar()
            let monthDays = calendar.rangeOfUnit(.CalendarUnitDay, inUnit: .CalendarUnitMonth, forDate: date)
            return Array(monthDays.toRange()!).map {day in
                let date = dateWithComponents(day, month, year)
                let axisValue = ChartAxisValueDate(date: date, formatter: displayFormatter, labelSettings: labelSettings)
                axisValue.hidden = !(day % 5 == 0)
                return axisValue
            }
        }
        let xValues = generateDateAxisValues(10, 2015)
        
        let xModel = ChartAxisModel(axisValues: xValues, axisTitleLabel: ChartAxisLabel(text: "Axis title", settings: labelSettings))
        let yModel = ChartAxisModel(axisValues: yValues, axisTitleLabel: ChartAxisLabel(text: "Axis title", settings: labelSettings.defaultVertical()))
        let chartFrame = ExamplesDefaults.chartFrame(self.view.bounds)
        let coordsSpace = ChartCoordsSpaceRightBottomSingleAxis(chartSettings: ExamplesDefaults.chartSettings, chartFrame: chartFrame, xModel: xModel, yModel: yModel)
        let (xAxis, yAxis, innerFrame) = (coordsSpace.xAxis, coordsSpace.yAxis, coordsSpace.chartInnerFrame)
        
        let chartPointsLineLayer = ChartCandleStickLayer<ChartPointCandleStick>(xAxis: xAxis, yAxis: yAxis, innerFrame: innerFrame, chartPoints: chartPoints, itemWidth: Env.iPad ? 10 : 5, strokeWidth: Env.iPad ? 1 : 0.6)
        
        let settings = ChartGuideLinesLayerSettings(linesColor: UIColor.blackColor(), linesWidth: ExamplesDefaults.guidelinesWidth)
        let guidelinesLayer = ChartGuideLinesLayer(xAxis: xAxis, yAxis: yAxis, innerFrame: innerFrame, settings: settings, onlyVisibleX: true)
        
        let dividersSettings =  ChartDividersLayerSettings(linesColor: UIColor.blackColor(), linesWidth: ExamplesDefaults.guidelinesWidth, start: Env.iPad ? 7 : 3, end: 0, onlyVisibleValues: true)
        let dividersLayer = ChartDividersLayer(xAxis: xAxis, yAxis: yAxis, innerFrame: innerFrame, settings: dividersSettings)
        
        let chart = Chart(
            frame: chartFrame,
            layers: [
                xAxis,
                yAxis,
                guidelinesLayer,
                dividersLayer,
                chartPointsLineLayer
            ]
        )
        
        self.view.addSubview(chart.view)
        self.chart = chart
    }
}
