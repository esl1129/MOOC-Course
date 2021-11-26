//
//  LicenseTableViewController.swift
//  K-KinderGarten
//
//  Created by 임재욱 on 2021/11/01.
//

import UIKit
import RxSwift
import RxRelay
import RxCocoa

class LicenseTableViewController: UITableViewController {
    let urlData = [
        ["https://github.com/Alamofire/Alamofire",
         "https://github.com/ReactiveX/RxSwift",
         "https://github.com/ReactiveX/RxSwift/tree/main/RxCocoa",
         "https://github.com/ReactiveX/RxSwift/tree/main/RxRelay",
         "https://github.com/SwiftyJSON/SwiftyJSON",
        "https://github.com/realm"],
        ["https://e-childschoolinfo.moe.go.kr/openApi/openApiIntro.do"]
    ]
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
}
extension LicenseTableViewController{
    func setUp(){
        tableView.rx.itemSelected
            .subscribe(onNext: { indexPath in
                if let url = URL(string: self.urlData[indexPath.section][indexPath.row]) {
                    UIApplication.shared.open(url, options: [:])
                }
            })
            .disposed(by: disposeBag)
    }
}
