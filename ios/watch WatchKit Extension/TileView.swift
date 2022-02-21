//
//  TileView.swift
//  watch WatchKit Extension
//
//  Created by Piotr FLEURY on 20/02/2022.
//

import SwiftUI

struct TileView: View {
    let value: Int
    let action: (Int) -> Void
    
    var body: some View {
        if(value == 0) {
            Text(" ")
                .frame(width: 48)
        } else {
            Button(action: {
                action(value)
            }) {
                Text("\(value)")
            }
                .frame(width: 48)
        }
        
    }
}

struct TileView_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            TileView(value: 0, action: {_ in })
            TileView(value: 1, action: {_ in })
            TileView(value: 2, action: {_ in })
        }
    }
}
