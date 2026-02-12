//
//  ZoomImageView.swift
//  WeddingPlannerBuddy
//
//  Created by Alexia Aldea on 03.12.2024.
//

import SwiftUI
import Kingfisher

@MainActor
struct ZoomImageScreen: View {
    private let mainNavigation = EnvironmentObjects.navigation
    var imageToZoom: String?
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                BackButton(imageColor: .white) {
                    mainNavigation?.pop(animated: true)
                }
                Spacer()
                
                if let imageToZoom = imageToZoom {
                    Button(action: {
                        saveImageToGallery(imageURL: imageToZoom)
                    }) {
                        Image(systemName: "square.and.arrow.down")
                            .foregroundColor(.white)
                            .frame(width: 32, height: 32)
                    }
                }
            }.padding([.top, .horizontal], 16)
            
            GeometryReader { geometry in
                if let image = imageToZoom {
                    zoomableImageView(imageURL: image, geometry: geometry)
                    
                }
            }
        }.background(Color.black)
    }
    
    private func zoomableImageView(imageURL: String, geometry: GeometryProxy) -> some View {
        ZoomableScrollView {
            KFImage(URL(string: imageURL))
                .resizable()
                .placeholder {
                    Image(.imgPlaceholder)
                        .resizable()
                }
                .scaledToFit()
                .frame(width: geometry.size.width, height: geometry.size.height)
                .clipped()
        }.frame(width: geometry.size.width, height: geometry.size.height)
    }
    
    private func saveImageToGallery(imageURL: String) {
        guard let url = URL(string: imageURL) else { return }
        
        KingfisherManager.shared.retrieveImage(with: url) { result in
            switch result {
            case .success(let value):
                UIImageWriteToSavedPhotosAlbum(value.image, nil, nil, nil) 
                print("Imagine salvată cu succes!")
            case .failure(let error):
                print("Eroare la descărcarea imaginii: \(error.localizedDescription)")
            }
        }
    }
}
