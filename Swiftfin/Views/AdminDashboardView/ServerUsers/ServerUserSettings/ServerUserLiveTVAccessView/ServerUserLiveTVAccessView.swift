//
// Swiftfin is subject to the terms of the Mozilla Public
// License, v2.0. If a copy of the MPL was not distributed with this
// file, you can obtain one at https://mozilla.org/MPL/2.0/.
//
// Copyright (c) 2025 Jellyfin & Jellyfin Contributors
//

import Defaults
import JellyfinAPI
import SwiftUI

struct ServerUserLiveTVAccessView: View {

    // MARK: - Current Date

    @CurrentDate
    private var currentDate: Date

    // MARK: - Observed & Environment Objects

    @Router
    private var router

    @ObservedObject
    private var viewModel: ServerUserAdminViewModel

    // MARK: - Policy Variable

    @State
    private var tempPolicy: UserPolicy

    // MARK: - Error State

    @State
    private var error: Error?

    // MARK: - Initializer

    init(viewModel: ServerUserAdminViewModel) {
        self.viewModel = viewModel

        guard let policy = viewModel.user.policy else {
            preconditionFailure("User policy cannot be empty.")
        }

        self.tempPolicy = policy
    }

    // MARK: - Body

    var body: some View {
        contentView
            .navigationTitle(L10n.liveTVAccess.localizedCapitalized)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarCloseButton {
                router.dismiss()
            }
            .topBarTrailing {
                if viewModel.backgroundStates.contains(.updating) {
                    ProgressView()
                }
                Button(L10n.save) {
                    if tempPolicy != viewModel.user.policy {
                        viewModel.send(.updatePolicy(tempPolicy))
                    }
                }
                .buttonStyle(.toolbarPill)
                .disabled(viewModel.user.policy == tempPolicy)
            }
            .onReceive(viewModel.events) { event in
                switch event {
                case let .error(eventError):
                    UIDevice.feedback(.error)
                    error = eventError
                case .updated:
                    UIDevice.feedback(.success)
                    router.dismiss()
                }
            }
            .errorMessage($error)
    }

    // MARK: - Content View

    @ViewBuilder
    var contentView: some View {
        List {
            Section(L10n.access) {
                Toggle(
                    L10n.liveTVAccess,
                    isOn: $tempPolicy.enableLiveTvAccess.coalesce(false)
                )
                Toggle(
                    L10n.liveTVRecordingManagement,
                    isOn: $tempPolicy.enableLiveTvManagement.coalesce(false)
                )
            }
        }
    }
}
