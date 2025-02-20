//
//  ContentView.swift
//  ID_Table_App
//
//  Created by apple on 2025/02/19.
//

import SwiftUI

// Main List View with a Search Bar
struct ContentView: View {
    @StateObject var viewModel = CableViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.filteredCables) { cable in
                NavigationLink(destination: DetailView(cable: cable, viewModel: viewModel)) {
                    VStack(alignment: .leading) {
                        Text(cable.ケーブル名).font(.headline)
                        Text("Connector: \(cable.コネクタ名)").font(.subheadline)
                    }
                }
            }
            .navigationTitle("Cable List")
            .searchable(text: $viewModel.searchText)
        }
    }
}

#Preview {
    ContentView()
}
