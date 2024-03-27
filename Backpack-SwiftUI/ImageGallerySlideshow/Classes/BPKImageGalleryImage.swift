/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018 Skyscanner Ltd
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import SwiftUI

public enum BPKImageGalleryDisplayContext {
    case grid
    case slideshow
}

public struct BPKImageGalleryImage<Content: View> {
    public let title: String
    public let description: String?
    public let credit: String?
    public let content: (BPKImageGalleryDisplayContext) -> Content

    public init(
        title: String,
        description: String? = nil,
        credit: String? = nil,
        @ViewBuilder content: @escaping (BPKImageGalleryDisplayContext) -> Content
    ) {
        self.title = title
        self.description = description
        self.credit = credit
        self.content = content
    }
}
