//
// Swiftfin is subject to the terms of the Mozilla Public
// License, v2.0. If a copy of the MPL was not distributed with this
// file, you can obtain one at https://mozilla.org/MPL/2.0/.
//
// Copyright (c) 2025 Jellyfin & Jellyfin Contributors
//

import SwiftUI

extension ItemView {

    struct AttributesHStack: View {

        @ObservedObject
        var viewModel: ItemViewModel

        var body: some View {
            HStack {
                if let criticRating = viewModel.item.criticRating {
                    HStack(spacing: 2) {
                        Group {
                            if criticRating >= 60 {
                                Image(.tomatoFresh)
                                    .symbolRenderingMode(.hierarchical)
                            } else {
                                Image(.tomatoRotten)
                            }
                        }
                        .font(.caption2)

                        Text("\(criticRating, specifier: "%.0f")")
                    }
                    .asAttributeStyle(.outline)
                }

                if let communityRating = viewModel.item.communityRating {
                    HStack(spacing: 2) {
                        Image(systemName: "star.fill")
                            .font(.caption2)

                        Text("\(communityRating, specifier: "%.1f")")
                    }
                    .asAttributeStyle(.outline)
                }

                if let officialRating = viewModel.item.officialRating {
                    Text(officialRating)
                        .asAttributeStyle(.outline)
                }

                if let mediaStreams = viewModel.selectedMediaSource?.mediaStreams {

                    if mediaStreams.hasHDVideo {
                        Text("HD")
                            .asAttributeStyle(.fill)
                    }

                    if mediaStreams.has4KVideo {
                        Text("4K")
                            .asAttributeStyle(.fill)
                    }

                    if mediaStreams.has51AudioChannelLayout {
                        Text("5.1")
                            .asAttributeStyle(.fill)
                    }

                    if mediaStreams.has71AudioChannelLayout {
                        Text("7.1")
                            .asAttributeStyle(.fill)
                    }

                    if mediaStreams.hasSubtitles {
                        Text("CC")
                            .asAttributeStyle(.outline)
                    }
                }
            }
            .foregroundColor(Color(UIColor.darkGray))
        }
    }
}
