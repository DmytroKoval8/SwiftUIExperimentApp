//
//  AboutViewModel.swift
//  SwiftUISampleApp
//
//  Created by Igor Kulman on 26.07.2024.
//

import Foundation


final class AboutViewModel: ObservableObject {
    let appName: String
    let appVersion: String
    @Published var showWebView = false

    private let onNavigation: (AboutView.NavigationTarget) -> Void

    init(onNavigation: @escaping (AboutView.NavigationTarget) -> Void) {
        print("AboutViewModel init")
        self.onNavigation = onNavigation

        appName = Bundle.main.appName
        appVersion = "\(Bundle.main.appVersion) (\(Bundle.main.appBuild))"
    }
    
    deinit {
        print("AboutViewModel deinit")
    }

    func showLibraries() {
        onNavigation(.libraries)
    }

    func showBlog() {
        showWebView = true
    }
}
