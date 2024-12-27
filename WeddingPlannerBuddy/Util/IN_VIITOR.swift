//
//  IN_VIITOR.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 27.12.2024.
//

//import SwiftUI
//import MusicKit
//
//class MusicLibraryViewModel: ObservableObject {
//    @Published var songs: [String] = []
//
//    func fetchLibrarySongs() async {
//        guard await requestMusicLibraryAccess() else { return }
//        
//        let query = MPMediaQuery.songs()
//        let items = query.items ?? []
//        
//        DispatchQueue.main.async {
//            self.songs = items.compactMap { $0.title }
//        }
//    }
//    
//    private func requestMusicLibraryAccess() async -> Bool {
//        let status = await MPMediaLibrary.requestAuthorization()
//        return status == .authorized
//    }
//}
//
//func requestMusicLibraryAccess() async -> Bool {
//    let status = await MPMediaLibrary.requestAuthorization()
//    return status == .authorized
//}
//struct MusicLibraryView: View {
//    @StateObject private var viewModel = MusicLibraryViewModel()
//
//    var body: some View {
//        VStack {
//            Button("Fetch Songs") {
//                Task {
//                    await viewModel.fetchLibrarySongs()
//                }
//            }
//            .padding()
//
//            List(viewModel.songs, id: \.self) { song in
//                Text(song)
//            }
//        }
//    }
//}

//func requestAppleMusicAccess() async -> Bool {
//    let status = await MusicAuthorization.request()
//    return status == .authorized
//}
//
//import MusicKit
//
//func searchSongs(query: String) async -> [MusicItemCollection<Song>] {
//    do {
//        let request = MusicCatalogSearchRequest(term: query, types: [Song.self])
//        let response = try await request.response()
//        return response.songs
//    } catch {
//        print("Error searching songs: \(error)")
//        return []
//    }
//}
