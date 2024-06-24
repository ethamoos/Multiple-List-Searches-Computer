//
//  ComplexView.swift
//  Multiple List Searches Computer
//
//  Created by Amos Deane on 24/06/2024.
//

import SwiftUI

struct ComplexView: View {

    
    var server: String
    var user: String
    var password: String
//    var selectedResourceType: ResourceType
    
//    @EnvironmentObject var progress: Progress
//    @EnvironmentObject var layout: Layout
    
    @EnvironmentObject var networkController: NetworkController
    
    @State var categories: [Category] = []
    
//    @State  var categorySelection: Category = Category(jamfId: 0, name: "")
    
    @State var enableDisable: Bool = true
    
    @State var ldapGroupName = ""
    
    @State var ldapGroupID = ""
    
//    @State private var policiesSelection = Set<Policy>()

    @State var searchText = ""
    
    @State var status: Bool = true
    
    @State private var showingWarning = false


    
    var body: some View {
        

//              ################################################################################
//              List policies
//              ################################################################################


        VStack(alignment: .leading) {
            
            if networkController.policies.count > 0 {
                
                List(searchResults, id: \.self, selection: $policiesSelection) { policy in
                    
                    HStack {
                        Image(systemName:"text.justify")
                        Text("\(policy.name)")
                        //                        Text("\(policy.general?.category?.name ?? "")")
                        //                        Text("\t\t\(String(describing: policy.jamfId))")
                    }
                    //                    .navigationTitle("JamfPolicy")
                    .foregroundColor(.blue)
                }
                .searchable(text: $searchText)



//              ################################################################################
//              Show selections
//              ################################################################################


//            Text("Your selections are:").fontWeight(.bold)
//                .overlay(
//                    RoundedRectangle(cornerRadius: 40)
//
//                        .strokeBorder(
//                            Color.black.opacity(0.4),
//                            style: StrokeStyle()
//                        )
//                        .padding()
//                )
//        }

//              ################################################################################
//              PROCESSING
//              ################################################################################

//                Text("Processing status:\(String(describing: networkController.processingComplete))")

//              ################################################################################
//                              BUTTONS
//              ################################################################################


//              ################################################################################
//              DELETE
//              ################################################################################

                
                LazyVGrid(columns: layout.columnsFlex, spacing: 20) {
//                LazyVGrid(columns: layout.fourColumnsFlex, spacing: 20) {
                    
                    HStack(spacing:30) {
                        
                        Button(action: {
                            
                            showingWarning = true
                            progress.showProgressView = true
                            print("Set showProgressView to true")
                            print(progress.showProgressView)
                            progress.waitForABit()
                            print("Check processingComplete")
                            print(String(describing: networkController.processingComplete))
                            networkController.processDeletePolicies(selection: policiesSelection, server: server, user: user, password: password, resourceType: ResourceType.policies)
                            
                        }) {
                            
//                            HStack(spacing:30) {
                                Text("Delete Selection")
                                
//                            }
                        }
                        .alert(isPresented: $showingWarning) {
                            Alert(title: Text("Caution!"), message: Text("This action will delete data.\n Always ensure that you have a backup!"), dismissButton: .default(Text("I understand!")))
                        }
                        //                    }
                        //              ################################################################################
                        //              Update Category
                        //              ################################################################################
                        
                        Button(action: {
                            
                            progress.showProgressView = true
                            networkController.processingComplete = false
                            progress.waitForABit()
                            print("Setting category to:\(String(describing: categorySelection))")
                            print("Policy enable/disable status is set as:\(String(describing: enableDisable))")
                            
                            networkController.selectedCategory = categorySelection
                            networkController.processUpdatePolicies(selection: policiesSelection, server: server, user: user, password: password, resourceType: ResourceType.policies, enableDisable: enableDisable)
                            
                        }) {
                            
                            //                            HStack(spacing:30) {
                            Text("Update Category")
                            //                            }
                        }
                        
                        
                        
                        
                        //              ################################################################################
                        //              Enable or Disable Policies Toggle
                        //              ################################################################################
                        
                        
                        Toggle("", isOn: $enableDisable)
                        
                            .toggleStyle(SwitchToggleStyle(tint: .red))
                        
                        if enableDisable {
                            Text("Enabled")
                        } else {
                            Text("Disabled")
                            
                        }
                    }
                }
                    
                    
//              ################################################################################
//              Update LDAP Scoping Limitations
//              ################################################################################

                Divider()
                
//                LazyVGrid(columns: layout.threeColumnsFlex, spacing: 20) {
                LazyVGrid(columns: layout.columnsFlex, spacing: 20) {
                    
                    HStack {
                        TextField("LDAP Group Name", text: $ldapGroupName)
                        TextField("LDAP Group ID", text: $ldapGroupID)
                        
                        Button(action: {
                            
                            progress.showProgressView = true
                            print("Set showProgressView to true")
                            
                            networkController.updateScopeLimitationsPoliciesSelected(selection: policiesSelection, user: user, password: password, server: server, resourceType: ResourceType.policyDetail
                                                                                     , user_groupLdapID: ldapGroupID, user_groupLdapName: ldapGroupName)
                            
                        }) {
                            //                                HStack(spacing: 10) {
                            Image(systemName: "plus.square.fill.on.square.fill")
                            Text("Set Limitations")
                            //                                }
                        }
                    }
                }
//            }
                
                
//              ################################################################################
//              Category
//              ################################################################################

                
                Divider()
                
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 250)), GridItem(.flexible())]) {
                    
                    HStack {
                        Picker(selection: $categorySelection, label: Text("Category:\t\t")) {
                            Text("").tag("") //basically added empty tag and it solve the case
                            ForEach(networkController.categories, id: \.self) { category in
                                Text(String(describing: category.name))
                            }
                        }
                        
                        Button(action: {
                            
                            networkController.connect(to: server, as: user, password: password, resourceType:  ResourceType.policies)
                            print("Refresh")
                            
                        }) {
                            HStack(spacing: 10) {
                                Image(systemName: "arrow.clockwise")
                                Text("Refresh")
                            }
                        }
                    }
                    
                }

//              ################################################################################
//              UPDATE POLICY - COMPLETE
//              ################################################################################
                
                Divider()
                
                Text("Selections").fontWeight(.bold)

                List(Array(policiesSelection), id: \.self) { policy in
                    
                    Text(policy.name )
                    
                }
                
//                .toolbar {
//                    Text("Total Policies").fontWeight(.bold)
//                    Text("\(networkController.policies.count)")
//                }
                
                
                
//                Text("Selection:\t\(String(selectionName))")
//                Button(action: {runScriptInternal(chosenScript: selectedScript ?? defaultInternalScript! )}) {
//                Text("Run Selected Script")
//                              }
//                              Button(action: updateList) {
//                                  Text("Update List")
//                              }
                
                if progress.showProgressView == true {
                    
                    ProgressView {
                        Text("Processing")
                            .padding()
                    }
                } else {
                    Text("")
                }
          
            } else {
                
                ProgressView {
                    Text("Loading")
                }
                .padding()
                Spacer()
            }
        }
        
        .onAppear {
            print("\(selectedResourceType) View appeared - connecting")
            print("Searching for \(selectedResourceType)")
            handleConnect(resourceType: selectedResourceType)
            handleConnect(resourceType: ResourceType.category)
        }
        
        .frame(minWidth: 200, minHeight: 0, alignment: .center)
        .padding()
        
    }
    
    func handleConnect(resourceType: ResourceType) {
        print("Running handleConnect. resourceType is set as:\(resourceType)")
        networkController.connect(to: server, as: user, password: password, resourceType: resourceType)
    }
    
    private func getAllPolicies() {
        print("Clicking Button")
    }
    
    var searchResults: [Policy] {
        if searchText.isEmpty {
            print("Search is empty")
            return networkController.policies
        } else {
            print("Search is currently:\(searchText)")

            return networkController.policies.filter { $0.name.contains(searchText) }
        }
    }
}


//struct PoliciesActionView2_Previews: PreviewProvider {
//    static var previews: some View {
//        PoliciesActionView2()
//    }
//}


//#Preview {
//    ComplexView()
//}
