//
//  BlurredImageBackground.swift
//  SwiftUIMovieApp
//
//  Created by Jason Hwang on 4/5/24.
//

import SwiftUI

struct BlurredImageBackground<Content>: View where Content:View {
    let imageURL: String?
    @ViewBuilder let content: Content
    
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                if let backdrop = imageURL {
                    AsyncImage(url: URL(string: ContentImageHelper.getURL(path: backdrop))) { phase in
                        if let image = phase.image {
                            image
                                .resizable()
                                .scaledToFill()
                                .ignoresSafeArea()
                                .frame(width: proxy.size.width, height: proxy.size.height)
                                .blur(radius: 8)
                        }
                    }
                    .padding(.all, 0)
                }
                
                VisualEffectView(effect: UIBlurEffect(style: .dark))
                    .ignoresSafeArea()
                
                content
            }
        }
    }
}
