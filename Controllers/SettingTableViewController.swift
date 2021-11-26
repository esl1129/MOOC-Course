//
//  SettingTableViewController.swift
//  K-KinderGarten
//
//  Created by 임재욱 on 2021/11/19.
//

import UIKit

import RxSwift
import RxRelay
import RxCocoa
class SettingTableViewController: UITableViewController {
    let disposeBag = DisposeBag()
    @IBOutlet weak var displayStyleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.displayStyleLabel.text = (UserDefaults.standard.object(forKey: "interfaceStyle") ?? "dark") as! String == "dark" ? "라이트 모드로 변경하기" : "다크 모드로 변경하기"
        setUp()
    }
}

extension SettingTableViewController{
    func setUp(){
        tableView.rx.itemSelected
            .subscribe(onNext: { [weak self] index in
                guard let strongSelf = self else{
                    return
                }
                switch index.section{
                case 0:
                    switch index.row{
                    case 0:
                        if (UserDefaults.standard.object(forKey: "interfaceStyle") ?? "dark") as! String == "dark"{
                            strongSelf.displayStyleLabel.text = "다크 모드로 변경하기"
                            UIApplication.shared.windows.first!.overrideUserInterfaceStyle = .light
                            UserDefaults.standard.set("light", forKey: "interfaceStyle")
                            UserDefaults.standard.synchronize()
                            break
                        }
                        strongSelf.displayStyleLabel.text = "라이트 모드로 변경하기"
                        UIApplication.shared.windows.first!.overrideUserInterfaceStyle = .dark
                        UserDefaults.standard.set("dark", forKey: "interfaceStyle")
                        UserDefaults.standard.synchronize()
                    default:
                        break
                    }
                default:
                    break
                }
            })
            .disposed(by: disposeBag)
    }
}
