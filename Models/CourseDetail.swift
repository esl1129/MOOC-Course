//
//  CourseDetail.swift
//  MOOC-Class
//
//  Created by 임재욱 on 2021/11/26.
//

import Foundation
struct CourseDetail: Codable{
    var htmlStr: String
    
    enum CodingKeys: String, CodingKey{
        case htmlStr = "overview"
    }
    init(){
        self.htmlStr = "None"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        htmlStr = try values.decodeIfPresent(String.self, forKey: .htmlStr) ?? "-"
    }
}
