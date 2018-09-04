//
//  Definitions.swift
//  NewsRuReader
//
//  Created by Rost on 01.09.2018.
//  Copyright © 2018 Rost Gress. All rights reserved.
//

import Foundation

    /// ---> API urls <--- ///

let gazetaUrl               = "https://www.gazeta.ru/export/rss/lenta.xml"
let lentaUrl                = "https://lenta.ru/rss"


    /// ---> UserDefaults keys <--- ///

let showCategory            = "showCategoryKey"
let refreshInterval         = "refreshIntervalKey"
let showInterval            = "showIntervalKey"

    /// ---> Observer keys <--- ///

let categoryDidChanged      = "categoryDidChangedKey"
let refreshTimeDidChanged   = "refreshTimeDidChangedKey"
let showTimeDidChanged      = "showTimeDidChangedKey"


    /// ---> Titles <--- ///

let allNews                 = "Все новости"

let showIntervalTitle       = "Интервал отображения"
let refreshIntervalTitle    = "Частота обновления"
let categoryNewsTitle       = "Категории новостей"

let freshTitle              = "Cвежие"
let byHourTitle             = "За час"
let byTodayTitle            = "За сегодня"
let allTitle                = "Все"

let oneMin                  = "1 мин."
let fiveMin                 = "5 мин."
let fifteenMin              = "15 мин."
let halfHour                = "30 мин."
let oneHour                 = "1 час"

    /// ---> Enums <--- ///

enum NewsShowModes: Int {
    case UsualMode
    case ExtendedMode
}

enum SettingsSections: Int {
    case ShowInterval
    case RefreshInterval
    case Categories
}

enum RefreshIntervals: Int {
    case OneMinute
    case FiveMinutes
    case FithteenMinutes
    case HalfHour
    case OneHour
}

enum ShowIntervals: Int {
    case LastNews
    case HourlyNews
    case DaylyNews
    case TotalNews
}

enum TimeInSeconds: Int {
    case HalfHourSeconds = 1800
    case HourSeconds = 3600
    case DaySeconds = 86400
}
