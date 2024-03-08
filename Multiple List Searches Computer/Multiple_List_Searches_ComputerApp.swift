//
//  Multiple_List_Searches_ComputerApp.swift
//  Multiple List Searches Computer
//
//  Created by Amos Deane on 07/03/2024.
//

import SwiftUI

@main


struct Multiple_List_Searches_ComputerApp: App {
    
    let mainBrain: MainBrain

    init() {
        self.mainBrain = MainBrain()
    }

    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(mainBrain)
        }
    }
}
