//
//  ShowDirectorCard.swift
//  SwiftUIMovieApp
//
//  Created by Jason Hwang on 4/5/24.
//

import SwiftUI

struct ShowDirectorCard: View {
    var director: CreatedBy
    
    var body: some View {
        VStack(alignment: .center, spacing: 4) {
            if let profilePath = director.profilePath {
                SmallPosterImage(posterPath: ContentImageHelper.getURL(path: profilePath))
            } else {
                Image(systemName: "person.fill")
                    .frame(width: 150,
                           height: 200)
                    .foregroundStyle(.white)
                    .background(.gray)
                    .cornerRadius(4)
            }
            Text(director.name)
                .font(.title2).fontWeight(.medium)
                .padding(.top, 4)
        }
    }
}

#Preview {
    ShowDirectorCard(director: CreatedBy(id: 52139, creditID: "5256e83c19c2956ff60ed821", name: "Seth MacFarlane", gender: 2, profilePath: "/8oQJqM51Z0Qtdb7sE6ZfX1peNCB.jpg"))
}
