//
//  PlaylistScreen.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 02.02.2025.
//

import SwiftUI
//TODO: fixme
struct PlaylistScreen: View {
    @StateObject private var viewModel = PlaylistViewModel()
    @EnvironmentObject private var navigation: Navigation
    
    var body: some View {
        VStack {
            LeftNavBarView(title: "Playlist") {
                navigation.pop(animated: true)
            }
            
            ScrollView(showsIndicators: false) {
                Text("Library Songs")
                    .font(.headline)
                
                List(viewModel.songs, id: \.id) { song in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(song.title)
                            Text(song.artist).font(.subheadline).foregroundColor(.gray)
                        }
                        Spacer()
                        Button("+") {
                            viewModel.addToPlaylist(song: song)
                        }
                    }
                }
                
                Text("My Playlist")
                    .font(.headline)
                
                List(viewModel.playlist, id: \.id) { song in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(song.title)
                            Text(song.artist).font(.subheadline).foregroundColor(.gray)
                        }
                        Spacer()
                        Button("Play") {
                            viewModel.playSong(song)
                        }
                        Button("Remove") {
                            viewModel.removeFromPlaylist(song: song)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    PlaylistScreen()
}
