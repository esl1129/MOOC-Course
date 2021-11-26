//
//  AlarmViewModel.swift
//  K-KinderGarten
//
//  Created by 임재욱 on 2021/10/29.
//

import Foundation
import RxSwift
import RxCocoa

class AlarmViewModel{
    var count = BehaviorRelay<Int>(value: 15)
    lazy var alarmData: Driver<[Alarm]> = {
        return self.count.asObservable()
            .throttle(.milliseconds(200), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .flatMapLatest(AlarmNoticeManager.shared.getAlarms)
            .asDriver(onErrorJustReturn: [])
    }()
}
