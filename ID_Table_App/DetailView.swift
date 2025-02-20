//
//  DetailView.swift
//  ID_Table_App
//
//  Created by apple on 2025/02/19.
//

import SwiftUI

// Detail View for Viewing and Editing Remarks
struct DetailView: View {
    @State var cable: CableItem
    @ObservedObject var viewModel: CableViewModel
    
    var body: some View {
        Form {
            Section(header: Text("Cable Details")) {
                Text("Cable Name: \(cable.ケーブル名)")
                Text("Connector: \(String(describing: cable.コネクタ名))")//ここを変えた
                Text("ID: \(cable.ID)")
                Text("Manufacturer: \(cable.コネクタメーカー ?? "Unknown")")
                Text("Registration Machine: \(cable.登録機 ?? "Unknown")")
            }
            
            Section(header: Text("Edit Remarks")) {
                TextField("Remarks", text: Binding(
                    get: { cable.備考 ?? "" },
                    set: { cable.備考 = $0 }
                ))
            }
        }
        .navigationTitle("Detail View")
        .toolbar {
            Button("Save") {
                if let index = viewModel.cables.firstIndex(where: { $0.No == cable.No }) {
                    viewModel.cables[index].備考 = cable.備考
                }
            }
        }
    }
}

#Preview {
    //DetailView(cable: CableItem, viewModel: CableViewModel)
}
