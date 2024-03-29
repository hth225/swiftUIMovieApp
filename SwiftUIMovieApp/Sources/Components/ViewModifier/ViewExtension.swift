//
//  ViewExtension.swift
//  SwiftUIMovieApp
//
//  Created by Jason Hwang on 3/28/24.
//

import Foundation
import SwiftUI

extension View {
    func title2() -> some View {
        modifier(MediumTitleModifier())
    }
}
