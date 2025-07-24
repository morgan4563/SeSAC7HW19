//
//  Movie.swift
//  SeSAC7HW19
//
//  Created by hyunMac on 7/24/25.
//

import Foundation

struct Movie: Decodable {
    let boxOfficeResult: DailyBoxOfficeList
}

struct DailyBoxOfficeList: Decodable {
    let dailyBoxOfficeList: [MovieData]
}

struct MovieData: Decodable {
    let rank: String
    let movieNm: String
    let openDt: String
}
