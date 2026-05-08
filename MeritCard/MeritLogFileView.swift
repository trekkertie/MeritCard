//
//  MeritLogFileView.swift
//  MeritCard
//
//  Created by Jonathan Preston on 12/10/2024.
//

import SwiftUI
import SwiftData

struct MeritLogFileView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort:\MeritLogFile.when) var meritlogfile: [MeritLogFile]
    @State private var showConfirmation = false
    @State private var clearMerit = false
    
    var body: some View {
        VStack {
            Image("Logo")
            List {
                ForEach(meritlogfile) { meritlog in
                    HStack {
                        Text(meritlog.when.formatted(date: Date.FormatStyle.DateStyle.long, time: Date.FormatStyle.TimeStyle.standard))
                        Text(meritlog.meritcard)
                        Text(" - Position: ")
                        Text("\(meritlog.meritpos)")
                        Text(meritlog.transaction)
                    }
                }
            }.environment(\.defaultMinListRowHeight, 70)
            .listRowSeparator(.visible)
            .navigationTitle("Log File Entries")
            .toolbar {
                Menu {
                    Button (role: .destructive, action: {showConfirmation.toggle()})
                    {
                        Label("Clear Log File Data", systemImage: "minus.circle")
                    }
                }
                label: {
                    Image(systemName: "gear")}.foregroundStyle(.white)
                }
                .sheet(isPresented: $showConfirmation, onDismiss: didDismiss, content: { MeritEnterPassword(clearMerit: $clearMerit)})
        }.background(.blue)
    }
    
    func didDismiss() {
        if clearMerit {
            clearLogFile()
        }
    }
    
    func clearLogFile() {
        do {
            try modelContext.delete(model: MeritLogFile.self)
            try modelContext.save()
        } catch {
            print("Error deleting MeritLogFile: \(error)")
        }
    }
}

//#Preview {
//    MeritLogFileView()
//}
