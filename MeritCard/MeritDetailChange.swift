//
//  MeritDetailChange.swift
//  MeritCard
//
//  Created by Jonathan Preston on 12/09/2024.
//

import SwiftUI

struct MeritDetailChange: View {
    @Environment(\.modelContext) var modelContext
    @Bindable var merit: Merit
    @Bindable var meritcard: MeritCard
    @State var starType: Bool
    
    var body: some View {
        VStack(alignment: .center){
            Image(systemName: starType ? "checkmark.circle" : "plus.circle").resizable().aspectRatio(contentMode: .fit).onTapGesture
            {
                withAnimation(.bouncy){starType.toggle()}
                merit.allocated.toggle()
                merit.allocated ? (meritcard.count += 1) : (meritcard.count -= 1)
                merit.allocated ? (merit.date = Date()) : ()
                addLogEntry(meritcardname: meritcard.name, position: merit.position, allocated: merit.allocated)
            }
            .frame(width: 300, height: 300)
            //.foregroundStyle(merit.allocated ? (Color(meritcard.name)) : (Color.black))
            
           TextField("Comment", text: $merit.comment, axis: .vertical).lineLimit(10)
                .font(.largeTitle)
                .padding(.horizontal, 20)
                .multilineTextAlignment(.center)
                .onChange(of: merit.comment) {
                    updateData()
                }
            Text(merit.date!, style: .date).font(.headline)
        }
    }
    
    func updateData() {
        
        // Added to ensure that the comment field updates
        
        do {
            
            try modelContext.save()
        }
        catch {
            print("Update of merit comment failed")
        }
        
    }
    
    func addLogEntry (meritcardname: String, position: Int, allocated: Bool) {
        
        // Add a log entry for the change in the merit and ensure that the data is saved
        
        var allocation: String = ""
        
        if allocated {
            allocation = "Merit Allocated"
        }
        else {
            allocation = "Merit De-Allocated"
        }
        
        let logEntry = MeritLogFile(when: Date(), meritcard: meritcardname, meritpos: position, transaction: allocation)
        
        modelContext.insert(logEntry)
        do {
            
            try modelContext.save()
        }
        catch {
            print("Update of merit failed")
        }
    }
}

//#Preview {
//    MeritDetailChange()
//}
