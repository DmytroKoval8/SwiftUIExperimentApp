//
//  SourceSelectionView.swift
//  SwiftUISampleApp
//
//  Created by Igor Kulman on 25.07.2024.
//

//import Core
import Foundation
import SwiftUI

public struct SetupView: View {
    @ObservedObject private var viewModel: SetupViewModel

    public init(settings: Settings, onFinished: @escaping () -> Void) {
        viewModel = SetupViewModel(
            settings: settings,
            onFinished: onFinished
        )
    }

    public var body: some View {
        List(viewModel.sources, id: \.rss) { source in
            SourceRow(source: source, isSelected: viewModel.selected == source) {
                viewModel.select(source: source)
            }
        }.navigationTitle(Text("Select source", bundle: .main))
            .toolbar {
                ToolbarItem {
                    Button(NSLocalizedString("Next", bundle: .main, comment: "")) {
                        viewModel.onNext()
                    }.disabled(!viewModel.isValid)
                }
            }
    }
}

//#Preview {
//    NavigationStack {
//        SetupView(settings: .mock(selected: nil), onFinished: {})
//    }
//}
