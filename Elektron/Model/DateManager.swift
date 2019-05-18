//
//  DateManager.swift
//  Elektron
//
//  Created by Cosimo Orlacchio on 18/05/2019.
//  Copyright © 2019 InfraHack. All rights reserved.
//

import Foundation

class DateManager {
    // save date, so all components use the same date
    // or e.g. Calendar(identifier: .persian)
    static let shared = DateManager()
    func getStringDataFromDate(date: Date) -> String{
        /*let calendar = Calendar.current
         
         let day = calendar.component(.day, from: date)
         let month = calendar.component(.month, from: date)
         let year = calendar.component(.year, from: date)
         let stringData = String(day) + "/" + String(month) + "/" + String(year)
         
         return stringData
         */
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        //        let now = dateFormatter.string(from: Date())
        dateFormatter.dateFormat = "HH:mm"
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let date24 = dateFormatter.string(from: date)
        return date24
        
    }
    
    func getStringTimeFromDate(date: Date) -> String {
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minute = calendar.component(.minute, from: date)
        let stringTime = String(hour) + ":" + String(minute)
        return stringTime
    }
    
    func getStringDateOnlyFromDate(date: Date) -> String {
        let calendar = Calendar.current
        let day = calendar.component(.day, from: date)
        let month = calendar.component(.month, from: date)
        let year = calendar.component(.year, from: date)
        let stringDate = "\(day)-\(month)-\(year)"
        return stringDate
    }
    
    func getNowDateAndTimeString() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        
        //        let now = dateFormatter.string(from: Date())
        dateFormatter.dateFormat = "HH:mm"
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        let date24 = dateFormatter.string(from: Date())
        return date24
    }
    
    func convertStringToDate(data: String)->Date{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
        let date = dateFormatter.date(from: data)
        return date!
    }
    
    func getComponentFromDate(date: Date, component: String) -> Int{
        let calendar = Calendar.current
        switch component {
        case "day":
            let day = calendar.component(.day, from: date)
            return day
        case "month":
            let month = calendar.component(.month, from: date)
            return month
        case "year":
            let year = calendar.component(.year, from: date)
            return year
        case "weekDay":
            let weekDay = calendar.component(.weekday, from: date)
            return weekDay
        case "minute":
            let minute = calendar.component(.minute, from: date)
            return minute
        case "hour":
            let hour = calendar.component(.hour, from: date)
            return hour
        default: return -1
        }
    }
    
    func getLastWeek() -> Date{
        let lastWeek = Calendar.current.date(byAdding: .weekOfYear, value: -1, to: Date())!
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let lastWeekDateString = dateFormatter.string(from: lastWeek)
        let lastWeekDate = convertStringToOnlyDate(data: lastWeekDateString)
        return lastWeekDate
    }
    
    func convertStringToOnlyDate(data: String)->Date{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let date = dateFormatter.date(from: data)
        return date!
    }
    
    func getStringWeekDayFromInt(weekDay: Int) -> String{
        switch weekDay {
        case 2:
            return "lunedì"
        case 3:
            return "martedì"
        case 4:
            return "mercoledì"
        case 5:
            return "giovedì"
        case 6:
            return "venerdì"
        case 7:
            return "sabato"
        case 1:
            return "domenica"
        default:
            return "day error"
        }
    }
    
    func getStringWeekDayAutomaticFromDate(data: Date) -> String{
        let calendar = Calendar.current
        let day = calendar.component(.weekday, from: data)
        switch day {
        case 2:
            return "lunedì"
        case 3:
            return "martedì"
        case 4:
            return "mercoledì"
        case 5:
            return "giovedì"
        case 6:
            return "venerdì"
        case 7:
            return "sabato"
        case 1:
            return "domenica"
        default:
            return "day error"
        }
    }
    
    func getDateFromYesterday(giornoDaSottrarre: Int) -> Date{
        let lastWeek = Calendar.current.date(byAdding: .day, value: giornoDaSottrarre, to: Date())!
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let yesterdayString = dateFormatter.string(from: lastWeek)
        let yesterdayDate = convertStringToOnlyDate(data: yesterdayString)
        return yesterdayDate
    }
    
    func getStringDataAndTimeFromDate(date: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
        let date24 = dateFormatter.string(from: date)
        return date24
        
    }
    
    func getOnlyStringDataFromDate(date: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        let date24 = dateFormatter.string(from: date)
        return date24

    }
    
}
