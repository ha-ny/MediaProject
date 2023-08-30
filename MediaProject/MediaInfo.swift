//
//  MediaInfo.swift
//  MediaProject
//
//  Created by 김하은 on 2023/08/12.
//

import Foundation
import Alamofire

enum DetailSection: Int, CaseIterable{
    case Cast
    case Crew
}

//재활용하고싶다...
class TmdbManager{
    
    static let shard = TmdbManager()

    func callApiData(url: String, backValue: @escaping (TmdbListData.MovieListData) -> Void){

        AF.request(url).validate().responseDecodable(of: TmdbListData.MovieListData.self) { response in
            switch response.result{
            case .success(let value):
                backValue(value)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func callApiData(url: String, backValue: @escaping (TmdbDetailData.MovieDetail) -> Void){

        AF.request(url).validate().responseDecodable(of: TmdbDetailData.MovieDetail.self) { response in
            switch response.result{
            case .success(let value):
                backValue(value)
            case .failure(let error):
                print(error)
            }
        }
    }
}

class ProfileList{

    struct ProfileCase{
        var title: String
        var placeHolder: String
    }
    
    enum TextFieldTag: Int{
        case name
        case nickName
        case introduce
    }
    
    static let ProfileTextField: [TextFieldTag:ProfileCase] = [
        .name: ProfileCase(title: "이름", placeHolder: "이름을 입력해주세요"),
        .nickName: ProfileCase(title: "사용자 이름", placeHolder: "사용자 이름을 입력해주세요"),
        .introduce: ProfileCase(title: "소개", placeHolder: "인사말을 입력해주세요")
    ]
}
