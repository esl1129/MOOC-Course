//
//  Course.swift
//  MOOC-Class
//
//  Created by 임재욱 on 2021/11/23.
//

import Foundation

struct CourseList: Codable{
    var courseInfo: [Course]
    
    enum CodingKeys: String, CodingKey{
        case courseInfo = "results"
    }
}

struct Course: Codable, Hashable{
    let url: String
    let effort: String
    let start: String
    let end: String
    let enrollStart: String
    let enrollEnd: String
    let id: String
    let media: Media
    let name: String
    let desc: String
    let teachers: String
    
    enum CodingKeys: String,CodingKey {
        case url = "blocks_url"
        case effort = "effort"
        case start = "start"
        case end = "end"
        case enrollStart = "enrollment_start"
        case enrollEnd = "enrollment_end"
        case id = "id"
        case media = "media"
        case name = "name"
        case desc = "short_description"
        case teachers = "teachers"
        
    }
    init(){
        self.url = "None"
        self.effort = "-"
        self.start = "-"
        self.end = "-"
        self.enrollStart = "-"
        self.enrollEnd = "-"
        self.id = "-"
        self.name = "-"
        self.desc = "-"
        self.teachers = "-"
        self.media = Media()
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        effort = try values.decodeIfPresent(String.self, forKey: .effort) ?? "-"
        start = ParseManager.shared.formatDate(try values.decodeIfPresent(String.self, forKey: .start) ?? "-")
        end = ParseManager.shared.formatDate(try values.decodeIfPresent(String.self, forKey: .end) ?? "-")
        enrollStart = ParseManager.shared.formatDate(try values.decodeIfPresent(String.self, forKey: .enrollStart) ?? "-")
        enrollEnd = ParseManager.shared.formatDate(try values.decodeIfPresent(String.self, forKey: .enrollEnd) ?? "-")
        id = try values.decodeIfPresent(String.self, forKey: .id) ?? "-"
        url = "http://www.kmooc.kr/courses/" + id
        name = try values.decodeIfPresent(String.self, forKey: .name) ?? "-"
        desc = ParseManager.shared.formatDesc(try values.decodeIfPresent(String.self, forKey: .desc) ?? "-")
        teachers = try values.decodeIfPresent(String.self, forKey: .teachers) ?? "-"
        media = try values.decodeIfPresent(Media.self, forKey: .media) ?? Media()
    }
}

struct Media: Codable,Hashable{
    let image: Image
    enum CodingKeys: String,CodingKey {
        case image = "image"
    }
    init(){
        self.image = Image()
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        image = try values.decodeIfPresent(Image.self, forKey: .image) ?? Image()

    }
}

struct Image: Codable,Hashable{
    let rawImage: String
    let smallImage: String
    let largeImage: String
    enum CodingKeys: String,CodingKey {
        case rawImage = "raw"
        case smallImage = "small"
        case largeImage = "large"
    }
    init(){
        self.rawImage = "-"
        self.smallImage = "-"
        self.largeImage = "-"

    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        rawImage = try values.decodeIfPresent(String.self, forKey: .rawImage) ?? "-"
        smallImage = try values.decodeIfPresent(String.self, forKey: .smallImage) ?? "-"
        largeImage = try values.decodeIfPresent(String.self, forKey: .largeImage) ?? "-"

    }
}
