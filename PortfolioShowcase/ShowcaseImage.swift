//
//  ShowcaseImage.swift
//  ShowcaseImage
//
//  Created by Sergio Bost on 8/16/21.
//

import SwiftUI

struct ShowcaseImage: View {
    var mini = false
    var body: some View {
        Image("sim1")
            .resizable()
            .scaledToFit()
            .frame(height: mini ? 100 : 450)
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: mini ? 3 : 20)
                    .stroke(lineWidth: mini ? 1 : 3)
            )
            .padding(.bottom)
    }
}

struct ShowcaseImage_Previews: PreviewProvider {
    static var previews: some View {
        ShowcaseImage(mini: true)
    }
}
