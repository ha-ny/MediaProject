//
//  MediaInfo.swift
//  MediaProject
//
//  Created by 김하은 on 2023/08/12.
//

import Foundation
import Alamofire
import SwiftyJSON

struct MediaData{
    let id: String
    let title: String
    let overview: String
    let release_date: String
    let backdrop_path: String
    let poster_path: String
}

struct ProfileData{
    let profileImage: String
    let name: String
    let overview: String
}

enum DetailSection: Int, CaseIterable{
    case Crew
    case Cast
}

struct MediaInfo{
    
    static func mediaAPI(url: String, valueJson: @escaping (JSON) -> ()) {
        let url = url
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result{
            case .success(let value):
                let json = JSON(value)
                valueJson(json)
            case .failure(let error):
                print(error)
            }
        }
    }
}
