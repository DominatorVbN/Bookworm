//
//  StartView.swift
//  Bookworm
//
//  Created by dominator on 18/12/19.
//  Copyright © 2019 dominator. All rights reserved.
//

import SwiftUI

struct RatingView: View {
    
    /// to report back to paren of change
    @Binding var rating: Int
    
    /// label text
    var label = ""
    
    /// max number of star to be drwan
    var maximumRating = 5
    
    /// image for state off
    var offImage: Image?
    
    /// image for on state default is star from sfsymbol
    var onImage: Image = Image(systemName: "star.fill")
    
    /// color of star on off state
    var offColor: Color = .gray
    
    /// color of star on on stale
    var onColor: Color = .yellow
    
    var body: some View {
        HStack{
            Text(label)
            ForEach(1...maximumRating, id: \.self){ number in
                self.image(for: number).foregroundColor(number > self.rating ? self.offColor : self.onColor)
                    .onTapGesture {
                        self.rating = number
                }
            }
        }
    }
    
    func image(for number: Int)->Image{
        if number > rating{
            return offImage ?? onImage
        }else{
            return onImage
        }
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        RatingView(rating: .constant(5))
    }
}
