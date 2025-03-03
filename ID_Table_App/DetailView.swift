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
    @State private var showConfirmation = false
    
    var body: some View {
        Form {
            Section(header: Text("Cable Details")) {
                Text("Cable Name: \(cable.ケーブル名)")
                Text("Connector: \(cable.コネクタ名 ?? "")")
                Text("ID: \(cable.ID)")
                Text("Manufacturer: \(cable.コネクタメーカー ?? "")")
                Text("Registration Machine: \(cable.登録機 ?? "")")
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
                        viewModel.saveData() // Save data to UserDefaults
                        showConfirmation = true
                    }
                }
                .alert(isPresented: $showConfirmation) {
                    Alert(title: Text("Saved"), message: Text("Your remarks have been updated and saved."), dismissButton: .default(Text("OK")))
                }
    }
}







#Preview {
    DetailView(
        cable: CableItem(
            No: 1,
            ケーブル名: "Sample Cable",
            コネクタ名: "Sample Connector",
            ID: "H179013-1.5D2V",
            コネクタメーカー: "Test Manufacturer",
            登録機: "CS5300",
            備考: "Sample Remarks"
        ),
        viewModel: CableViewModel()
    )
}
