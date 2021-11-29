//
//  APIManager.swift
//  MOOC-Class
//
//  Created by 임재욱 on 2021/11/23.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire
import UIKit

let API_KEY = "4R0BCNpHgJP36wE%2BSnQtXZ42Yj%2BqKWVxqQunOSOgV1npX3mz2qgDlM7N%2FinRtP6kBdX8i%2FfrNfpVZEJOIIOezQ%3D%3D"


final class APIManager{
    static let shared = APIManager()
    var courseData = [Course]()
}
extension Notification.Name {
    static let startSpin = Notification.Name("startSpin")
    static let stopSpin = Notification.Name("stopSpin")
}
// MARK: - Get Course List
extension APIManager{
    public func getCourse(_ pageNo: Int) -> Observable<[Course]> {
        NSLog("Try : getCourse")
        NotificationCenter.default.post(name: .startSpin, object: nil)
        return Observable.create { observer -> Disposable in
            let url = "http://www.kmooc.kr/api/courses/v1/course/list/?SG_APIM=2ug8Dm9qNBfD32JLZGPN64f3EoTlkpD8kSOHWfXpyrY&page=\(pageNo)&serviceKey=\(API_KEY)"
            AF.request(url)
                .validate(statusCode: 200..<500)
                .responseJSON{ response in
                    switch response.result {
                    case .success(let object):
                        do{
                            let dataJSON = try JSONSerialization.data(withJSONObject: object, options: .prettyPrinted)
                            if let getInstanceData = try? JSONDecoder().decode(CourseList.self, from: dataJSON){
                                NotificationCenter.default.post(name: .stopSpin, object: nil)
                                NSLog("Success : getCourse")
                                APIManager.shared.courseData += getInstanceData.courseInfo
                                observer.onNext(APIManager.shared.courseData)
                                observer.onCompleted()
                            }
                        }catch{
                        }
                    case .failure(let err):
                        NotificationCenter.default.post(name: .stopSpin, object: nil)
                        NSLog("Failure : getCourse")
                        observer.onError(err)
                    }
                }
            return Disposables.create()
        }
    }
    
    public func getDetail(_ course: Course) -> Observable<CourseDetail>{
        NotificationCenter.default.post(name: .startSpin, object: nil)
        return Observable.create { observer -> Disposable in
            let url = "http://apis.data.go.kr/B552881/kmooc/courseDetail?ServiceKey=\(API_KEY)&CourseId=\(course.id)"
            AF.request(url)
                .validate(statusCode: 200..<500)
                .responseJSON{ response in
                    switch response.result {
                    case .success(let object):
                        do{
                            let dataJSON = try JSONSerialization.data(withJSONObject: object, options: .prettyPrinted)
                            if let getInstanceData = try? JSONDecoder().decode(CourseList.self, from: dataJSON){
                                NotificationCenter.default.post(name: .stopSpin, object: nil)
                                NSLog("Success : getHtml")
                                observer.onNext(getInstanceData)
                                observer.onCompleted()
                            }
                        }catch{
                        }
                    case .failure(let err):
                        NotificationCenter.default.post(name: .stopSpin, object: nil)
                        NSLog("Failure : getHtml")
                        observer.onError(err)
                        
                    }
                }
            return Disposables.create()
        }
    }
}

