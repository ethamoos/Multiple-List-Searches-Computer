//
//  ContentView.swift
//  Multiple List Searches Computer
//
//  Created by Amos Deane on 07/03/2024.
//

import SwiftUI


class MainBrain: ObservableObject {
    
    @Published var computerSelection = Set<String>()
    @Published var groupSelection: String = ""
    
}

struct MainView: View {
    
    @EnvironmentObject var mainBrain: MainBrain

    var body: some View {
        
        VStack {
            
            Text("Computer Selection is:\(String(describing: mainBrain.computerSelection))")
            
            Text("Group Selection is:\(String(describing:mainBrain.groupSelection))")
            
        }
        .padding()

        TabView {
            ContentView()
                .tabItem {
                    Label("Computers", systemImage: "list.dash")
                }

            SecondView()
                .tabItem {
                    Label("Groups", systemImage: "square.and.pencil")
                }
        }
    }
}


struct ContentView: View {
    
    @EnvironmentObject var mainBrain: MainBrain

    let computers = ["Big Mac", "Mac Mini", "iBook" ]
    
    @State var searchText = ""
    
    var body: some View {
        
        
        VStack(alignment: .leading) {

            Text("Computers").bold()
            List(searchResults, id: \.self, selection: $mainBrain.computerSelection) { computer in
                
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
            print("Group search is empty")
            return computers
        } else {
            print("Computer search added - item is:\(searchText)")
            return computers.filter { $0.contains(searchText) }
        }
    }
}



struct SecondView: View {
    
    @EnvironmentObject var mainBrain: MainBrain
    
    let groups = ["Kitchen", "Lounge", "Bedroom"]
    
    @State var searchText = ""
        
    var body: some View {
        
        VStack(alignment: .leading) {
            
            Text("Groups").bold()

            List(searchResults, id: \.self, selection: $mainBrain.groupSelection) { group in
                
                HStack {
                    Image(systemName: "house")
                    Text(group ).font(.system(size: 12.0)).foregroundColor(.blue)
                }
                .foregroundColor(.blue)
            }
            .searchable(text: $searchText)
        }
        .padding()
    }
    
    var searchResults: [String] {
        if searchText.isEmpty {
            print("Group search  is empty")
            return groups
        } else {
            print("Group search Added")
            return groups.filter { $0.contains(searchText) }
        }
    }
}



