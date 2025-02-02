//
//  Song.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 02.02.2025.
//

import Foundation

struct Song: Identifiable, Hashable {
    var id = UUID()
    let title: String
    let artist: String
    let url: URL?
    
    init(from mediaItem: MPMediaItem) {
        self.title = mediaItem.title ?? "Unknown Title"
        self.artist = mediaItem.artist ?? "Unknown Artist"
        self.url = mediaItem.assetURL
    }
}
