//
//  DetailTableViewController.swift
//  MOOC-Class
//
//  Created by 임재욱 on 2021/11/24.
//

import UIKit
import RxSwift
import RxRelay
import RxCocoa
import WebKit

class DetailTableViewController: UITableViewController {
    @IBOutlet weak var linkLabel: UILabel!
    @IBOutlet weak var enrollLabel: UILabel!
    @IBOutlet weak var enrollLabel2: UILabel!
    @IBOutlet weak var periodLabel: UILabel!
    @IBOutlet weak var periodLabel2: UILabel!
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var spin: UIActivityIndicatorView!
    let courseViewModel = CourseViewModel()

    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
}
extension DetailTableViewController{
    func setUp(){
        self.navigationItem.title = courseViewModel.currentCourse.value.name
        linkLabel.text = courseViewModel.currentCourse.value.url
        enrollLabel.text = courseViewModel.currentCourse.value.enrollStart
        enrollLabel2.text = " ~ \(courseViewModel.currentCourse.value.enrollEnd)"
        periodLabel.text = courseViewModel.currentCourse.value.start
        periodLabel2.text = " ~ \(courseViewModel.currentCourse.value.end)"

        NotificationCenter.default.addObserver(self, selector: #selector(startSpin(_:)), name: Notification.Name("startSpin"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(stopSpin(_:)), name: Notification.Name("stopSpin"), object: nil)
        
        
        courseViewModel.courseDetail
            .subscribe(onNext: { detail in
                self.webView.loadHTMLString(detail.htmlStr , baseURL: nil)
            })
            .disposed(by: disposeBag)
        
        tableView.rx.itemSelected
            .subscribe(onNext: { [weak self] index in
                guard let strongSelf = self else{
                    return
                }
                switch index.section{
                case 0:
                    switch index.row{
                    case 0:
                        if let url = URL(string: strongSelf.linkLabel.text!) {
                            UIApplication.shared.open(url, options: [:])
                        }
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
extension DetailTableViewController{
    @objc func startSpin(_ notification: Notification) {
        self.spin.startAnimating()
    }
    @objc func stopSpin(_ notification: Notification){
        self.spin.stopAnimating()
    }
}
