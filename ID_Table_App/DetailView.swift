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
                VStack(alignment: .leading) {
                    TextEditor(text: Binding(
                        get: { cable.備考 ?? "" },
                        set: { cable.備考 = $0 }
                    ))
                    .frame(minHeight: 100) // Allows expansion when multiline text is entered
                    .lineLimit(nil) // Ensures text wraps to next line
                    .padding(4)
                    //.padding()
                    //                    .foregroundColor(.neumorphictextColor)
                    //                    .background(Color.background)
                    //                    .cornerRadius(6)
                    //                    .shadow(color: Color.darkShadow, radius: 3, x: 2, y: 2)
                    //                    .shadow(color: Color.lightShadow, radius: 3, x: -2, y: -2)
                }
            }
            //.textFieldStyle(RoundedBorderTextFieldStyle())
            
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


//extension Color {
//    static let lightShadow = Color(red: 255 / 255, green: 255 / 255, blue: 255 / 255)
//    static let darkShadow = Color(red: 163 / 255, green: 177 / 255, blue: 198 / 255)
//    static let background = Color(red: 224 / 255, green: 229 / 255, blue: 236 / 255)
//    static let neumorphictextColor = Color(red: 132 / 255, green: 132 / 255, blue: 132 / 255)
//}




#Preview {
    DetailView(
        cable: CableItem(
            No: 1,
            ケーブル名: "Sample Cable",
            コネクタ名: "Sample Connector",
            ID: "H179013-1.5D2V",
            コネクタメーカー: "Test Manufacturer",
            登録機: "CS5300",
            備考: "Sample Remarks Go Here... Sample Remarks Go Here..."
        ),
        viewModel: CableViewModel()
    )
}
