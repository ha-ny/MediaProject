//
//  MediaInfo.swift
//  MediaProject
//
//  Created by 김하은 on 2023/08/12.
//

import Foundation

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
