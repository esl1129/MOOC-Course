//
//  AlarmManager.swift
//  K-KinderGarten
//
//  Created by 임재욱 on 2021/10/29.
//

import Foundation
import RxSwift
import RxCocoa


final class AlarmNoticeManager{
    static let shared = AlarmNoticeManager()
    
}
extension AlarmNoticeManager{
    public func getAlarms(_ count : Int) -> Observable<[Alarm]> {
        NSLog("Try : getAlarms")
        var alarms: [Alarm] = []
        for i in 1...count{
            alarms.append(Alarm(title: "알람 : \(i)", description: "Alarm_Description : \(i)"))
        }
        NSLog("Success : getAlarms")
        return Observable.just(alarms)
    }
    public func getNotices(_ count : Int) -> Observable<[Notice]> {
        NSLog("Try : getNotices")
        var alarms: [Notice] = []
        for i in 1...count{
            alarms.append(Notice(title: "공지사항 : \(i)", description: "Notice_Description : \(i)"))
        }
        NSLog("Success : getNotices")
        return Observable.just(alarms)
    }
}
