//
//  AnimeEpisodeListView.swift
//  MyAnimeList
//
//  Created by HG on 2020/09/22.
//

import SwiftUI
import SwiftUIFlux
import CrunchyrollSwift

struct EpisodeListView: View {
    @EnvironmentObject private var store: Store<AppState>

    let collectionId: Int

    private var episodes: [CRAPIMedia] {
        return store.state.crState.collections[collectionId] ?? []
    }

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(alignment: .center, spacing: 20) {
                ForEach(episodes) {
                    if let mediaId = Int($0.id) {
                        EpisodeView(episode: $0, mediaId: mediaId)
                    }
                }
            }
            .padding(.horizontal)
        }
        .onAppear {
            if let session = store.state.crState.session {
                if episodes.count == 0 {
                    // Request only when data not yet avaliable
                    store.dispatch(action: CRActions.ListMedia(sessionId: session.id,
                                                               collectionId: collectionId,
                                                               fields: [.id, .episodeNumber, .name, .screenshotImage, .freeAvailable]))
                }
            }
        }
    }
}

struct EpisodeView: View {
    let episode: CRAPIMedia
    let mediaId: Int
    var body: some View {
        ImageTextView(data: episode,
                      imageSize: CommonImageSize.episodeImage,
                      useModal: true) {
            FullscreenVideoPlayer(mediaId: mediaId).environmentObject(store)
        } action: {
            displayAction()
        }
    }

    func displayAction() {
        if let episodeId = Int(episode.id), let session = store.state.crState.session {
            store.dispatch(action: CRActions.Info(sessionId: session.id,
                                                  mediaId: episodeId,
                                                  fields: [.id, .streamData]))
        }
    }
}
