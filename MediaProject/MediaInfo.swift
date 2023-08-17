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

