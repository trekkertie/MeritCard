//
//  ContentView.smeritCard != nil {//  MeritCard
//
//  Created by Jonathan Preston on 07/08/2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort:\MeritCard.rank) var meritcards: [MeritCard]
    @Query var iconData: [MeritIcon]
    @State var iconImage: UIImage = UIImage(systemName: "photo") ?? UIImage()
    @State private var meritLogoData: Data = Data()
    @State private var showConfirmation = false
    @State private var showLogFile = false
    @State private var showSettings = false
    @State private var showAbout = false
    @State private var clearMerit = false
    
    
    var body: some View {
        NavigationStack {
            VStack {
                if let iconImageTemp =  UIImage(data: iconData.first?.iconData ?? Data()) {
                    Image(uiImage: iconImageTemp)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 150)
                        .padding()
                }
                else {
                    Image(uiImage: iconImage)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 150)
                        .padding()
                }
                List {
                    ForEach(meritcards) { meritcard in
                        NavigationLink(value: meritcard){
                            Text(meritcard.name)
                        }.disabled(isAvailable(rank: meritcard.rank))
                            .listRowBackground(Color(meritcard.name))
                            .font(.title)
                    }
                }.environment(\.defaultMinListRowHeight, 70)
                .listRowSeparator(.visible)
                .navigationDestination(for: MeritCard.self) { meritcard in
                    MeritCardDetail(meritcard: meritcard, iconImage: $iconImage)
                }
                .navigationTitle("Your Meritcards")
                .toolbar {
                    Menu {
                        Button (role: .destructive, action: {showConfirmation.toggle()})
                        {
                            Label("Clear Merit Card Data", systemImage: "minus.circle")
                        }
                        Button (action: {showLogFile = true})
                        {
                            Label("Show Log File", systemImage: "magnifyingglass.circle")
                        }
                        Button (action: {showSettings = true})
                        {
                            Label("Settings", systemImage: "gearshape.fill")
                        }
                        Button (action: {showAbout = true})
                        {
                            Label("About", systemImage: "questionmark.circle")
                        }
                    }
                    label: {
                        Image(systemName: "gear")}.foregroundStyle(.white)
                    }
                    .navigationDestination(isPresented: $showLogFile) {
                        MeritLogFileView()
                    }
                    .navigationDestination(isPresented: $showSettings) {
                        MeritSettingsView(iconImage: $iconImage)
                    }
                    .sheet(isPresented: $showAbout, onDismiss: didDismiss, content: { MeritAbout()})

                    .sheet(isPresented: $showConfirmation, onDismiss: didDismiss, content: { MeritEnterPassword(clearMerit: $clearMerit)})
            }.background(.blue)
        }
    }

    func didDismiss() {
        if clearMerit {
            clearData(meritcards: meritcards)
        }
    }
    
    func clearData(meritcards: [MeritCard]) {
        // Delete all the merit data from each merit card and set counts to 0
        let count = 0...24
        
        meritcards.forEach {meritcard in
            meritcard.count = 0
            for i in count {
                meritcard.merit[i].allocated = false
                meritcard.merit[i].date = Date()
                meritcard.merit[i].comment = ""
            }
        }
        do {
            
            try modelContext.save()
        }
        catch {
            print("Delete failed")
        }
        
        print("Data cleared")
    }
    
    func isAvailable(rank: Int) -> Bool {
        if meritcards[rank-1].rank == 1 {
            return false
        }
        if meritcards[rank-2].count == 25 {
            return false
        }
        else {
            return true
        }
    }
}

//#Preview {
//    ContentView(meritcard: MeritCard)
//}

