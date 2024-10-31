//
//  AboutView.swift
//  SwiftUISampleApp
//
//  Created by Igor Kulman on 26.07.2024.
//

import Foundation
import SafariServices
import SwiftUI

public struct AboutView: View {
    public enum NavigationTarget {
        case libraries
    }

    @StateObject private var viewModel: AboutViewModel

    public init(onNavigation: @escaping (NavigationTarget) -> Void) {
        _viewModel = StateObject(wrappedValue: AboutViewModel(onNavigation: onNavigation))
    }

    public var body: some View {
        List {
            HStack(alignment: .center) {
                Spacer()
                VStack {
                    Image(systemName: "person")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100)
                        .padding(16)
                    Text(viewModel.appName)
                        .font(.headline)
                    Text(viewModel.appVersion)
                        .font(.caption2)
                }
                Spacer()
            }
            AboutRow(title: NSLocalizedString("Used libraries", bundle: .main, comment: "")) {
                viewModel.showLibraries()
            }
            AboutRow(title: NSLocalizedString("Author's blog", bundle: .main, comment: "")) {
                viewModel.showBlog()
            }
        }
        .fullScreenCover(isPresented: $viewModel.showWebView) {
            SafariWebView(url: URL(string: "https://blog.kulman.sk")!)
                .ignoresSafeArea()
        }
        .navigationTitle(Text("About", bundle: .main))
    }
}

//#Preview {
//    NavigationStack {
//        AboutView(onNavigation: { _ in })
//    }
//}
