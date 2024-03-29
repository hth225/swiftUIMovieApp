//
//  MediumTitleModifier.swift
//  SwiftUIMovieApp
//
//  Created by Jason Hwang on 3/28/24.
//

import Foundation
import SwiftUI

struct MediumTitleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title2).fontWeight(.bold)
    }
}
