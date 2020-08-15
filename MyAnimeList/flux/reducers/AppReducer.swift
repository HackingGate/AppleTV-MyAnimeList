//
//  AppReducer.swift
//  MyAnimeList
//
//  Created by HG on 2020/07/26.
//

import Foundation
import SwiftUIFlux

func appStateReducer(state: AppState, action: Action) -> AppState {
    var state = state
    state.crState = crStateReducer(state: state.crState, action: action)
    state.playState = playStateReducer(state: state.playState, action: action)
    return state
}
