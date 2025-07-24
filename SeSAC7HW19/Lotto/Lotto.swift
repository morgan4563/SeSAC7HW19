//
//  Lotto.swift
//  SeSAC7HW19
//
//  Created by hyunMac on 7/24/25.
//

import Foundation

struct Lotto: Decodable {
    //추첨일
    let drwNoDate: String
    //회차
    let drwNo: Int
    //당첨번호
    let drwtNo1: Int
    let drwtNo2: Int
    let drwtNo3: Int
    let drwtNo4: Int
    let drwtNo5: Int
    let drwtNo6: Int
    //보너스번호
    let bnusNo: Int
}
