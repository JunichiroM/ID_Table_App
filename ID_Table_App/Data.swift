//
//  Data.swift
//  ID_Table_App
//
//  Created by apple on 2025/02/19.
//

import Foundation

// Model to represent the data structure
struct CableItem: Identifiable, Codable {
    let id: UUID = UUID()
    let No: Int
    let ケーブル名: String
    let コネクタ名: String?
    let ID: String
    let コネクタメーカー: String?
    let 登録機: String?
    var 備考: String? // This is the "remarks" field that can be edited
}

// ViewModel to handle data loading and filtering
class CableViewModel: ObservableObject {
    @Published var cables: [CableItem] = []
    @Published var searchText: String = ""
    
    init() {
        loadData()
    }
    
    func loadData() {
        if let url = Bundle.main.url(forResource: "ID_table", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decodedData = try JSONDecoder().decode([CableItem].self, from: data)
                self.cables = decodedData
            } catch {
                print("Error loading JSON: \(error)")
            }
        }
    }
    
//    var filteredCables: [CableItem] {
//        if searchText.isEmpty {
//            return cables
//        } else {
//            return cables.filter { $0.ケーブル名.contains(searchText) || ($0.コネクタ名 ?? "").contains(searchText) }
//        }
//    }
    
    var filteredCables: [CableItem] {
        if searchText.isEmpty {
            return cables
        } else {
            let lowercasedSearchText = searchText.lowercased()
            return cables.filter {
                $0.ケーブル名.lowercased().contains(lowercasedSearchText) ||
                ($0.コネクタ名?.lowercased().contains(lowercasedSearchText) ?? false)
            }
        }
    }
}
