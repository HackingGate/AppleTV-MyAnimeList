//
//  JikanActions.swift
//  MyAnimeList
//
//  Created by HG on 2020/09/21.
//

import Foundation
import SwiftUIFlux
import JikanSwift

struct JikanActions {
    
    // MARK: - Requests
    
    struct Anime: AsyncAction {
        func execute(state: FluxState?, dispatch: @escaping DispatchFunction) {
            JikanAPIService.shared.loadAnime(
                id: 1,
                request: "/",
                params: nil)
            {
                (result: Result<JikanAPIAnime, JikanAPIService.APIError>) in
                switch result {
                case let .success(response):
                    #if DEBUG
                    print(response)
                    #endif
                    dispatch(SetAnime(malID: 1, response: response))
                case .failure(_):
                    break
                }
            }
        }
    }
    
    struct Top: AsyncAction {
        func execute(state: FluxState?, dispatch: @escaping DispatchFunction) {
            JikanAPIService.shared.loadTop(
                type: "anime",
                page: 1,
                subtype: "airing",
                params: nil)
            {
                (result: Result<JikanAPITop<[JikanAPIAnime]>, JikanAPIService.APIError>) in
                switch result {
                case let .success(response):
                    #if DEBUG
                    print(response)
                    #endif
                    dispatch(SetTop(response: response))
                case .failure(_):
                    break
                }
            }
        }
    }
    
    struct SetAnime: Action {
        let malID: Int
        let response: JikanAPIAnime
    }
    
    struct SetTop: Action {
        let response: JikanAPITop<[JikanAPIAnime]>
    }
}
