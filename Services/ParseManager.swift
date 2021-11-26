//
//  ParseManager.swift
//  MOOC-Class
//
//  Created by 임재욱 on 2021/11/23.
//

import Foundation
import RxSwift
import RxCocoa

final class ParseManager{
    static let shared = ParseManager()
}
// MARK: - Parse Format
extension ParseManager{
    func formatDate(_ str: String) -> String{
        if str == "-" { return str }
        let strToDate = DateFormatter()
        strToDate.locale = Locale(identifier:"ko_KR")
        strToDate.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = strToDate.date(from: str)
        
        let dateToStr = DateFormatter()
        dateToStr.dateFormat = "yyyy년 M월 d일 HH시 mm분"
        let convertStr = dateToStr.string(from: date!)
        return convertStr
    }
    func formatDay(_ str: String) -> String{
        return str == "-" ? "-" : "\(str)일"
    }
    func formatCnt(_ str: String,_ suf: String) -> String{
        return str.first! == "0" ? "-" : str.first! == "-" ? "-" : str+suf
    }
    func formatYN(_ str: String) -> String{
        return str == "Y" ? "O" : "X"
    }
    func formatArea(_ str: String) -> String{
        if str.count == 1 || str.first! == "0"{
            return "없음"
        }
        return str
    }
    func formatDesc(_ str: String) -> String{
        return str.replacingOccurrences(of: "\n", with: "\n\n").replacingOccurrences(of: ".", with: "\n\n")
    }
}
