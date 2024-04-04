//
//  PopularTVsView.swift
//  SwiftUIMovieApp
//
//  Created by Jason Hwang on 4/3/24.
//

import SwiftUI
import ComposableArchitecture

struct PopularTVsView: View {
    @Bindable var store: StoreOf<PopularTVsDomain>
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                Color("Background")
                    .ignoresSafeArea()
                
                VisualEffectView(effect: UIBlurEffect(style: .dark))
                    .ignoresSafeArea()
                
                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible()),GridItem(.flexible())], alignment: .center, spacing: 4) {
                        ForEach(store.tvList) { element in
                            TVCard(info: element)
                                .frame(width: proxy.size.width / 2, height: proxy.size.height / 2)
                                .task {
                                    // ResTV의 첫번째 Element 가 보일때 다음 페이지 가져오기
                                    if (element.id == store.checkPointID) {
                                        print("Requested: \(element.id), CheckPoint:\(String(describing: store.checkPointID))")
                                        store.send(.fetchTVList(store.currentPage+1))
                                    }
                                }
                        }
                    }
                }
            }
            .frame(width: proxy.size.width, height: proxy.size.height)
        }
        .tint(.white)
        .task {
            store.send(.fetchTVList(store.currentPage+1))
        }
    }
}

#Preview {
    PopularTVsView(store: Store(initialState: PopularTVsDomain.State()) {
        PopularTVsDomain()
    })
}
