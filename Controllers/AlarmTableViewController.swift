//
//  AlarmTableViewController.swift
//  K-KinderGarten
//
//  Created by 임재욱 on 2021/10/29.
//

import UIKit
import RxSwift
import RxRelay
import RxCocoa
import Alamofire

class AlarmTableViewController: UITableViewController {
    let alarmViewModel = AlarmViewModel()
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = nil
        tableView.dataSource = nil
        setUp()
    }
}

extension AlarmTableViewController{
    func setUp(){
        alarmViewModel.alarmData
            .drive(tableView.rx.items(cellIdentifier: "alarmCell")){ _, alarm, cell in
                cell.textLabel?.text = alarm.title
                cell.detailTextLabel?.text = alarm.description
            }
            .disposed(by: disposeBag)
    }
}
