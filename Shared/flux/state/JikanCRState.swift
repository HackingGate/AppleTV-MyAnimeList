//
//  JikanCRState.swift
//  MyAnimeList
//
//  Created by HG on 2020/09/22.
//

import Foundation
import SwiftUIFlux
import JikanSwift

struct JikanCRState: FluxState, Codable {
    var malIdSeriesId: [Int: Int] = [:]
}
