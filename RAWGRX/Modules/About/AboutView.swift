//
//  ProfileView.swift
//  RAWGRX
//
//  Created by Ikhwan Setyo on 20/12/25.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        VStack {
            Image("me")
                .resizable()
                .scaledToFill()
                .frame(width: 140, height: 140)
                .clipShape(Circle())
            
            Text("Ikhwan Setyo")
                .fontWeight(.bold)
            
            Text("Sleman, Yogyakarta")
        }
    }
}
