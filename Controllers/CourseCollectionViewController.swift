//
//  CourseCollectionViewController.swift
//  MOOC-Class
//
//  Created by 임재욱 on 2021/11/24.
//

import UIKit
import RxSwift
import RxRelay
import RxCocoa
private let reuseIdentifier = "courseCell"

class CourseCollectionViewController: UICollectionViewController {
    let courseViewModel = CourseViewModel()
    let disposeBag = DisposeBag()
    var spin = UIActivityIndicatorView(style: .large)
    
    var imageDict = [String:Data]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = nil
        collectionView.dataSource = nil
        collectionView.register(UINib(nibName: "CourseCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        imageDict = (UserDefaults.standard.object(forKey: "imageCache") ?? Dictionary<String, Data>()) as! Dictionary<String, Data>
        setUp()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        contentSetUp()
    }
    override func viewWillDisappear(_ animated: Bool) {
        UserDefaults.standard.set(imageDict, forKey: "imageCache")
        UserDefaults.standard.synchronize()
    }
}
extension CourseCollectionViewController{
    func setUp(){
        self.spin.center = view.center
        self.spin.hidesWhenStopped = true
        self.spin.color = UIColor(named: "point")
        self.view.addSubview(spin)
        self.view.bringSubviewToFront(spin)
        courseViewModel.CourseData
            .drive(collectionView.rx.items(cellIdentifier: "courseCell")){ index, course, cell in
                cell.backgroundColor = index%2 == 0 ? UIColor(named: "collectionback1") : UIColor(named: "collectionback2")
                let cell = cell as! CourseCollectionViewCell
                cell.mainTitle.text = course.name
                cell.subTitle.text = course.teachers
                var imageData: Data?
                if let cacheData = self.imageDict[course.id]{
                    imageData = cacheData
                }else if let url = URL(string: course.media.image.largeImage), let urlData = try? Data(contentsOf: url){
                    self.imageDict[course.id] = urlData
                    imageData = urlData
                }
                cell.photoView.image = UIImage(data: imageData!)
//
//                var imgData: Data?
//                if let cacheData = UserDefaults.standard.object(forKey: course.id) as? Data{
//                    imgData = cacheData
//                }else if let url = URL(string: course.media.image.largeImage), let urlData = try? Data(contentsOf: url){
//                    imgData = urlData
//                    UserDefaults.standard.set(urlData, forKey: course.id)
//                    UserDefaults.standard.synchronize()
//                }
//                cell.photoView.image = UIImage(data: imgData!)
            }
            .disposed(by: disposeBag)
        
        courseViewModel.touchRight
            .subscribe(onNext: { [weak self] check in
                if let strongSelf = self{
                    if check{
                        strongSelf.courseViewModel.pageNo
                            .accept((strongSelf.courseViewModel.contentWidth.value-170)/360 == 0 ? 1 : (strongSelf.courseViewModel.contentWidth.value-170)/360+1)
                    }
                }
            })
            .disposed(by: disposeBag)
        
        collectionView.rx.modelSelected(Course.self)
            .subscribe(onNext: { model in
                self.performSegue(withIdentifier: "showDetail", sender: model)
            })
            .disposed(by: disposeBag)
        
        NotificationCenter.default.addObserver(self, selector: #selector(startSpin(_:)), name: Notification.Name("startSpin"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(stopSpin(_:)), name: Notification.Name("stopSpin"), object: nil)
    }
    
    func contentSetUp(){
        self.view.rx
            .observe(CGRect.self, #keyPath(UIView.frame))
            .asDriver(onErrorJustReturn: CGRect.zero)
            .map{Int(($0?.size.width)!)}
            .drive(courseViewModel.windowWidth)
            .disposed(by: disposeBag)
        
        collectionView.rx
            .observe(CGPoint.self, #keyPath(UICollectionView.contentOffset))
            .asDriver(onErrorJustReturn: CGPoint.zero)
            .map{Int(($0?.x)!)}
            .drive(courseViewModel.contentOffset)
            .disposed(by: disposeBag)
        
        collectionView.rx
            .observe(CGSize.self, #keyPath(UICollectionView.contentSize))
            .asDriver(onErrorJustReturn: CGSize.zero)
            .map{Int(($0?.width)!)}
            .drive(courseViewModel.contentWidth)
            .disposed(by: disposeBag)
        
        
    }
}

extension CourseCollectionViewController{
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail"{
            guard let course = sender as? Course else {
                return
            }
            let vc = segue.destination as! DetailTableViewController
            vc.courseViewModel.currentCourse = BehaviorRelay<Course>(value: course)
        }
    }
}

extension CourseCollectionViewController {
    @objc func startSpin(_ notification: Notification) {
        self.spin.startAnimating()
        self.view.alpha = 0.5
    }
    @objc func stopSpin(_ notification: Notification){
        self.spin.stopAnimating()
        self.view.alpha = 1.0
    }
}
