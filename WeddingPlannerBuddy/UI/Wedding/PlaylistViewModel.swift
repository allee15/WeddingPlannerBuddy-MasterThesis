//
//  PlaylistViewModel.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 27.12.2024.
//

import SwiftUI
import MusicKit
import MediaPlayer
import AVFoundation

enum PlaylistState {
    case loading
    case failure
    case value([Song])
}

class PlaylistViewModel: BaseViewModel {
    @Published var playlistState: PlaylistState = .loading
    @Published var songs: [Song] = []
    @Published var playlist: [Song] = []
    private var player = AVPlayer()
    
    override init() {
        super.init()
        self.fetchLibrarySongs()
    }
    
    func fetchLibrarySongs() {
        self.playlistState = .loading
        
        guard requestMusicLibraryAccess() else {
            self.playlistState = .failure
            return
        }
        
        let query = MPMediaQuery.songs()
        let items = query.items ?? []
        print("📌 Număr melodii găsite: \(items.count)")
        
        DispatchQueue.main.async {
            let songs = items.map { Song(from: $0) }
            if songs.isEmpty {
                self.playlistState = .failure
            } else {
                self.playlistState = .value(songs)
            }
        }
    }
    
    private func requestMusicLibraryAccess() -> Bool {
        let status = MPMediaLibrary.authorizationStatus()
        print("🔐 Status acces: \(status.rawValue)")
        return status == .authorized
    }
    
    func addToPlaylist(song: Song) {
        if !playlist.contains(song) {
            playlist.append(song)
        }
    }
    
    func removeFromPlaylist(song: Song) {
        playlist.removeAll { $0.id == song.id }
    }
    
    func playSong(_ song: Song) {
        guard let url = song.url else { return }
        let playerItem = AVPlayerItem(url: url)
        player.replaceCurrentItem(with: playerItem)
        player.play()
    }
}
