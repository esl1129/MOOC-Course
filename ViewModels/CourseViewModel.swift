//
//  CourseViewModel.swift
//  MOOC-Class
//
//  Created by 임재욱 on 2021/11/23.
//

import Foundation
import RxSwift
import RxCocoa

class CourseViewModel{
    lazy var windowWidth = BehaviorRelay<Int>(value: 1)
    lazy var contentWidth = BehaviorRelay<Int>(value: 1)
    lazy var contentOffset = BehaviorRelay<Int>(value: 1)
    var touchRight: Observable<Bool> {
        return Observable.combineLatest(windowWidth, contentWidth, contentOffset)
            .map{ windowWidth, contentWidth, contentOffset in
                return contentOffset > contentWidth-windowWidth+30
            }
    }
    lazy var pageNo = BehaviorRelay<Int>(value: 1)
    lazy var currentCourse = BehaviorRelay<Course>(value: Course())
    lazy var CourseData: Driver<[Course]> = {
        return self.pageNo.asObservable()
            .throttle(.milliseconds(2000), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .flatMapLatest(APIManager.shared.getCourse)
            .asDriver(onErrorJustReturn: [])
    }()
    lazy var courseDetail: Observable<CourseDetail> = {
        return self.currentCourse.asObservable()
            .throttle(.milliseconds(2000), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .flatMapLatest(APIManager.shared.getDetail)
            //.asDriver(onErrorJustReturn: CourseDetail())
    }()
}
