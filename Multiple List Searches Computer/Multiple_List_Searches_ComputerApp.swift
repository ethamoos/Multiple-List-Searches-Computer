//
//  Multiple_List_Searches_ComputerApp.swift
//  Multiple List Searches Computer
//
//  Created by Amos Deane on 07/03/2024.
//

import SwiftUI





struct Multiple_List_Searches_ComputerApp: App {
    
    

    let networkController: NetworkController


    init() {
        self.networkController = NetworkController()

    }
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(networkController)
        }
    }
}
