//
//  CourseCollectionViewCell.swift
//  MOOC-Class
//
//  Created by 임재욱 on 2021/11/24.
//

import UIKit
import RxSwift

class CourseCollectionViewCell: UICollectionViewCell {
    var disposeBag = DisposeBag()

    @IBOutlet weak var subTitle: UILabel!
    @IBOutlet weak var mainTitle: UILabel!
    @IBOutlet weak var photoView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        mainTitle.text = "Sample"
        subTitle.text = "Sample"
        
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }

}
