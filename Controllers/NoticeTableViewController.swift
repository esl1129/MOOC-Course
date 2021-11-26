//
//  NoticeTableViewController.swift
//  K-KinderGarten
//
//  Created by 임재욱 on 2021/11/01.
//

import UIKit
import RxSwift
import RxRelay
import RxCocoa

class NoticeTableViewController: UITableViewController {
    let noticeViewModel = NoticeViewModel()
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = nil
        tableView.dataSource = nil
        setUp()
    }
}
extension NoticeTableViewController{
    func setUp(){
        noticeViewModel.noticeData
            .drive(tableView.rx.items(cellIdentifier: "noticeCell")){ _, notice, cell in
                cell.textLabel?.text = notice.title
                cell.detailTextLabel?.text = notice.description
            }
            .disposed(by: disposeBag)
    }
}
