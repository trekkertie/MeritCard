//
//  MeritCell.swift
//  MeritCard
//
//  Created by Jonathan Preston on 20/08/2024.
//

import SwiftUI

struct MeritCell: View {
    @Bindable var merit: Merit
    @Bindable var meritcard: MeritCard
    @State var starType: Bool = true
    @State private var selection: Merit? = nil
    @State var boings = 3
    @Binding var celebrate: Bool
    @State var meritcolor: Color = .blueCard
    
    var body: some View {
        ZStack {
            VStack {
                Image(systemName: merit.allocated ? "checkmark.circle" : "plus.circle").resizable().scaledToFit().clipped()
                //.foregroundStyle(Color(meritcard.name))
                    .onTapGesture{
                        self.selection = merit}
                if merit.allocated {
                    Text(merit.date!, style: .date)
                }
                Text(merit.allocated ? merit.comment : "")
            }.lineLimit(1).minimumScaleFactor(0.5)
                .frame(height: 150)
                .symbolEffect(.pulse, options: .repeat(2))
                .presentationSizing(.fitted)
                .sheet(item: $selection, onDismiss: checkMeritCount, content: {MeritDetailChange(merit: $0, meritcard: meritcard, starType: merit.allocated)})
            }
        }
    
    func checkMeritCount() {
        if meritcard.count == 25 {
            celebrate = true
            meritcolor = Color(meritcard.name)
        }
    }
}

//#Preview {
//    MeritCell()
//}

