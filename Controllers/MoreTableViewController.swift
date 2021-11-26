//
//  NoticeTableViewController.swift
//  K-KinderGarten
//
//  Created by 임재욱 on 2021/10/29.
//

import UIKit
import RxSwift
import RxRelay
import RxCocoa

class MoreTableViewController: UITableViewController {
    let disposeBag = DisposeBag()
    let urlData = [[],[],["https://github.com/esl1129/Korea-KinderGarten","https://petalite-sycamore-04f.notion.site/RxSWIFT-K-KinderGarten-3c98c4ee9d2a483ea9cd6719d1080b4d"],["https://petalite-sycamore-04f.notion.site/Finder-8826a95f59f84529b8f276d8eabf8b9d"]]
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
}

extension MoreTableViewController{
    func setUp(){
        tableView.rx.itemSelected
            .subscribe(onNext: { index in
                switch index.section{
                case 0:
                    self.performSegue(withIdentifier: "showNotice", sender: nil)
                case 1:
                    switch index.row{
                    case 0: // 개인정보
                        self.performSegue(withIdentifier: "showPersonal", sender: nil)
                        break
                    case 1: // 오픈소스
                        self.performSegue(withIdentifier: "showLicense", sender: nil)
                        break
                    default:
                        break
                    }
                    break
                default :
                    break
                    /*
                    if let url = URL(string: self.urlData[index.section][index.row]) {
                        UIApplication.shared.open(url, options: [:])
                    }
                     */
                }
            })
            .disposed(by: disposeBag)
    }
}
