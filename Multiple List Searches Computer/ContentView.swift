//
//  ContentView.swift
//  Multiple List Searches Computer
//
//  Created by Amos Deane on 07/03/2024.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            ContentView()
                .tabItem {
                    Label("Computers", systemImage: "list.dash")
                }

            SecondView()
                .tabItem {
                    Label("Policies", systemImage: "square.and.pencil")
                }
        }
    }
}


struct ContentView: View {
    
    let computers = ["Big Mac", "Mac Mini", "iBook" ]
    
    @State var searchText = ""
    @State var selection = Set<String>()
    
    var body: some View {
        
        
        VStack(alignment: .leading) {

            Text("Computers").bold()
            List(searchResults, id: \.self, selection: $selection) { computer in
                
                HStack {
                    Image(systemName: "apple.logo")
                    Text(computer ).font(.system(size: 12.0)).foregroundColor(.blue)
                }
                .foregroundColor(.blue)
            }
            .searchable(text: $searchText)
        }
        .padding()

    }
    
    var searchResults: [String] {
        if searchText.isEmpty {
            print("Policy search is empty")
            return computers
        } else {
            print("Computer search added - item is:\(searchText)")
            return computers.filter { $0.contains(searchText) }
        }
    }
}



struct SecondView: View {
    
    let policies = ["Do hoovering", "Auto-Sandwich", "Water Plants"]
    @State var searchText = ""
    @State var selection = Set<String>()
        
    var body: some View {
        
        VStack(alignment: .leading) {
            
            Text("Policies").bold()

            List(searchResults, id: \.self, selection: $selection) { policy in
                
                HStack {
                    Image(systemName: "house")
                    Text(policy ).font(.system(size: 12.0)).foregroundColor(.blue)
                }
                .foregroundColor(.blue)
            }
            .searchable(text: $searchText)
        }
        .padding()
    }
    
    var searchResults: [String] {
        if searchText.isEmpty {
            print("Policy search  is empty")
            return policies
        } else {
            print("Policy search Added")
            return policies.filter { $0.contains(searchText) }
        }
    }
}



