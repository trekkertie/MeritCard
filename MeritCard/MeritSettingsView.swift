//
//  MeritSettingsView.swift
//  MeritCard
//
//  Created by Jonathan Preston on 27/10/2025.
//

import SwiftUI
import SwiftData
import PhotosUI

struct MeritSettingsView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort:\MeritCard.rank) var meritcards: [MeritCard]
    @Binding var iconImage: UIImage
    @State var meritLogoData: Data = Data()
    @State private var iconItem: PhotosPickerItem?
    @State private var iconUIImage: UIImage = UIImage()
    @Query private var iconData: [MeritIcon]

    var body: some View {
        VStack {
            PhotosPicker(selection: $iconItem, matching: .images) {
                Image(uiImage: iconImage)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 150)
                    .padding()
                }
            List(meritcards) { card in
                HStack {
                    Text(card.name)
                        .font(.title)
                    Spacer()
                }
                .listRowBackground(Color(card.name))
                .onAppear {
                    print(card.name)
                }
            }
            .environment(\.defaultMinListRowHeight, 70)
            .listRowSeparator(.visible)
            .navigationTitle("Meritcard Settings")
        }
        .background(.blue)
        .onAppear {
            if let iconImageTemp =  UIImage(data: iconData.first?.iconData ?? Data()) {
                iconImage = iconImageTemp
            } else {
                iconImage = UIImage(systemName: "photo") ?? UIImage()

            }
        }
        .onChange(of: iconItem) { _, newItem in
            Task {
                
                if let newItem = newItem, let loaded = try? await newItem.loadTransferable(type: Data.self) {
                    if let uiImage = UIImage(data: loaded) {
                        iconImage = uiImage
                        // Create a new MeritIcon and insert it into the model context
                        let newIcon = MeritIcon(iconData: loaded)
                        for icon in iconData {
                            modelContext.delete(icon)
                        }
                        modelContext.insert(newIcon)
                    }
                    do {
                        try modelContext.save()
                    }
                    catch {
                        print("Failed to save image: \(error)")
                    }
                } else {
                    print("Failed")
                }
            }
        }
    }
}

//#Preview {
   // MeritSettingsView()
//}
