//
//  FeedViewModel.swift
//  SwiftUISampleApp
//
//  Created by Igor Kulman on 26.07.2024.
//

import Foundation

final class FeedViewModel: ObservableObject {
    var title: String {
        source.title
    }
    @Published var state: ScreenState<[RssItem]> = .loading

    private let onNavigation: (FeedView.NavigationTarget) -> Void
    private let feed: Feed
    private let source: RssSource

    init(settings: Settings, feed: Feed, onNavigation: @escaping (FeedView.NavigationTarget) -> Void) {
        print("FeedViewModel init")
        guard let source = settings.get() else {
            fatalError()
        }
        self.onNavigation = onNavigation
        self.feed = feed
        self.source = source
    }
    
    deinit {
        print("FeedViewModel deinit")
    }
    
    func load() async {
        do {
            let items = try await feed.get(source)
            await MainActor.run {
                state = .loaded(data: items)
            }
        } catch {
            state.toError(error: error)
        }
    }

    func showDetail(item: RssItem) {
        onNavigation(.item(item))
    }

    func showAbout() {
        onNavigation(.about)
    }

    func showSettings() {
        onNavigation(.settings)
    }
}
