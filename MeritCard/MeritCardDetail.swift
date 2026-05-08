//
//  MeritCardDetail.swift
//  MeritCard
//
//  Created by Jonathan Preston on 14/08/2024.
//

import SwiftUI
import SwiftData

struct MeritCardDetail: View {
    @Bindable var meritcard: MeritCard
    @Binding var iconImage: UIImage
    @State private var selection: Merit? = nil
    @State var celebrate = false
    @Query private var iconData: [MeritIcon]
    
    let columns = [
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible())
        ]
    
    var body: some View {
        ZStack {
        ScrollView {
            VStack {
                Image(uiImage: iconImage)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 150)
                    .padding()
                Text(meritcard.slogan)
                Text("Total Stamps: " + "\(meritcard.count)")
            }
            .frame(maxWidth: .infinity).background(Color(meritcard.name))
            .onAppear {
                if let iconImageTemp =  UIImage(data: iconData.first?.iconData ?? Data()) {
                    iconImage = iconImageTemp
                } else {
                    iconImage = UIImage(systemName: "photo") ?? UIImage()
                    
                }
            }
            LazyVGrid (columns: columns) {
                ForEach(meritcard.merit.sorted { $0.position < $1.position }, id: \.position) { merit in
                    MeritCell(merit: merit, meritcard: meritcard, celebrate: $celebrate)
                }
            }.navigationTitle(meritcard.name).toolbarBackground(Color(meritcard.name), for: .navigationBar).toolbarBackground(.visible, for: .navigationBar)
        }
        // Confetti overlay
            if celebrate {
                ConfettiView()
                    .onAppear {
                        // Hide confetti after animation completes
                        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                            celebrate = false
                        }
                    }
            }
        }
    }
}

//#Preview {
//    MeritCardDetail(meritcard: MeritCard)
//}
