//
//  MeritLoadInitialData.swift
//  MeritCard
//
//  Created by Jonathan Preston on 07/11/2024.
//

import SwiftUI
import SwiftData

@MainActor
let appContainer: ModelContainer = {
    do {
        let modelContext = try ModelContainer(for: MeritCard.self, MeritLogFile.self, MeritIcon.self)
        
        // Make sure the persistent store is empty. If it's not, return the non-empty container.
        var itemFetchDescriptor = FetchDescriptor<MeritCard>()
            itemFetchDescriptor.fetchLimit = 1
            
        guard try modelContext.mainContext.fetch(itemFetchDescriptor).count == 0 else { return modelContext}
            
        // This code will only run if the persistent store is empty.
        
        var arrMerit = [Merit]()
        var count = 0...24
        var timeInterval: Double = 0
        var icon = [MeritIcon]()
        
        var slogan: String = "I'm working hard and AIMING HIGH toward my Platinum Plus++ merit card."
        
        // Load initial merit data
        
        count = 0...24
        for i in count {
            arrMerit.append(Merit(position: i, allocated: false, date: Date(), comment: ""))
        }
            
        let platinumppp = MeritCard(name: "Platinum Plus++ Card", slogan: slogan, rank: 10, count: 0, merit: arrMerit)
            
        slogan = "I'm working hard and AIMING HIGH toward my Platinum Plus+ merit card."
        arrMerit.removeAll(keepingCapacity: true)
        count = 0...24
        for i in count {
            arrMerit.append(Merit(position: i, allocated: false, date: Date(), comment: ""))
        }
            
        let platinumpp = MeritCard(name: "Platinum Plus+ Card", slogan: slogan, rank: 9, count: 0, merit: arrMerit)
            
        slogan = "I'm working hard and AIMING HIGH toward my Platinum Plus merit card."
        arrMerit.removeAll(keepingCapacity: true)
        count = 0...24
        for i in count {
            arrMerit.append(Merit(position: i, allocated: false, date: Date(), comment: ""))
        }
            
        let platinump = MeritCard(name: "Platinum Plus Card", slogan:slogan, rank: 8, count: 0, merit: arrMerit)
            
            
        slogan = "I'm working hard and AIMING HIGH toward my Platinum merit card."
        arrMerit.removeAll(keepingCapacity: true)
        count = 0...24
        for i in count {
            arrMerit.append(Merit(position: i, allocated: false, date: Date(), comment: ""))
        }
            
        let platinum = MeritCard(name: "Platinum Card", slogan:slogan, rank: 7, count: 0, merit: arrMerit)
            
        slogan = "I'm working hard and AIMING HIGH toward my Gold merit card."
        arrMerit.removeAll(keepingCapacity: true)
        count = 0...24
        for i in count {
            arrMerit.append(Merit(position: i, allocated: false, date: Date(), comment: ""))
        }
            
        let gold = MeritCard(name: "Gold Card", slogan: slogan, rank: 6, count: 0, merit: arrMerit)
        
        slogan = "I'm working hard and AIMING HIGH toward my Silver merit card."
        arrMerit.removeAll(keepingCapacity: true)
        count = 0...24
        for i in count {
            arrMerit.append(Merit(position: i, allocated: false, date: Date(), comment: ""))
        }
            
        let silver = MeritCard(name: "Silver Card", slogan:slogan, rank: 5, count: 0, merit: arrMerit)
            
        slogan = "I'm working hard and AIMING HIGH toward my Bronze merit card."
        arrMerit.removeAll(keepingCapacity: true)
        count = 0...24
        for i in count {
            arrMerit.append(Merit(position: i, allocated: false, date: Date(), comment: ""))
        }
            
        let bronze = MeritCard(name: "Bronze Card", slogan:slogan, rank: 4, count: 0, merit: arrMerit)
          
        slogan = "I'm working hard and AIMING HIGH toward my Yellow merit card."
        arrMerit.removeAll(keepingCapacity: true)
        count = 0...24
        for i in count {
            arrMerit.append(Merit(position: i, allocated: false, date: Date(), comment: ""))
        }
        
        let yellow = MeritCard(name: "Yellow Card", slogan:slogan, rank: 3, count: 0, merit: arrMerit)
        
        slogan = "I'm working hard and AIMING HIGH toward my Green merit card."
        arrMerit.removeAll(keepingCapacity: true)
        count = 0...24
        for i in count {
            arrMerit.append(Merit(position: i, allocated: false, date: Date(), comment: ""))
        }
            
        let green = MeritCard(name: "Green Card", slogan:slogan, rank: 2, count: 0, merit: arrMerit)
            
        slogan = "I'm working hard and AIMING HIGH toward my Blue merit card."
        arrMerit.removeAll(keepingCapacity: true)
        count = 0...24
        for i in count {
            arrMerit.append(Merit(position: i, allocated: false, date: Date.now.addingTimeInterval(86400), comment: ""))
        }
            
        let blue = MeritCard(name: "Blue Card", slogan: slogan, rank: 1, count: 0, merit: arrMerit)
        
        modelContext.mainContext.insert(platinumppp)
        modelContext.mainContext.insert(platinumpp)
        modelContext.mainContext.insert(platinump)
        modelContext.mainContext.insert(platinum)
        modelContext.mainContext.insert(gold)
        modelContext.mainContext.insert(silver)
        modelContext.mainContext.insert(bronze)
        modelContext.mainContext.insert(yellow)
        modelContext.mainContext.insert(green)
        modelContext.mainContext.insert(blue)
        
        return modelContext
    } catch {
        fatalError("Failed to create container")
    }
}()

