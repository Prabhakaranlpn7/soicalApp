//
//  Comment.swift
//  SocialFeedApp
//
//  Created by Prabhakaran on 27/10/25.
//

import SwiftUI

struct Comment: Identifiable {
    let id: UUID
    var text: String
    var timestamp: Date
}
