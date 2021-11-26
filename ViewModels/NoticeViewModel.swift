
import Foundation
import RxSwift
import RxCocoa

class NoticeViewModel{
    var count = BehaviorRelay<Int>(value: 10)
    lazy var noticeData: Driver<[Notice]> = {
        return self.count.asObservable()
            .throttle(.milliseconds(200), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .flatMapLatest(AlarmNoticeManager.shared.getNotices)
            .asDriver(onErrorJustReturn: [])
    }()
}
