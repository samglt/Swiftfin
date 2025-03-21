//
// Swiftfin is subject to the terms of the Mozilla Public
// License, v2.0. If a copy of the MPL was not distributed with this
// file, you can obtain one at https://mozilla.org/MPL/2.0/.
//
// Copyright (c) 2025 Jellyfin & Jellyfin Contributors
//

import Foundation

enum MaxBitratePolicy: Int, Displayable, CaseIterable {

    case unlimited = 0
    case custom = 10_000_000 // Default to 10mbps

    // MARK: - Display Title

    var displayTitle: String {
        switch self {
        case .unlimited:
            return L10n.unlimited
        case .custom:
            return L10n.custom
        }
    }

    init?(rawValue: Int?) {
        guard let rawValue else { return nil }
        self.init(rawValue: rawValue)
    }
}
