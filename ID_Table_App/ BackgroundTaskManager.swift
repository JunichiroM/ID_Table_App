//
//   BackgroundTaskManager.swift
//  ID_Table_App
//
//  Created by apple on 2025/03/05.
//
import SwiftSMTP
import Foundation
import BackgroundTasks
import UserNotifications


class BackgroundTaskManager {
    static let shared = BackgroundTaskManager()
    
    let jsonFile: String = "output_2025_03_04.json"
    
    private init() {}
    
    func sendJsonFile() {
        print("📨 Attempting to retrieve JSON data from UserDefaults...") // ✅ Debug log
        
        guard let savedData = UserDefaults.standard.data(forKey: "savedCables") else {
            print("❌ No JSON data found in UserDefaults.")
            return
        }

        let jsonFilePath = FileManager.default.temporaryDirectory.appendingPathComponent(jsonFile)

        do {
            try savedData.write(to: jsonFilePath)
            print("✅ JSON file successfully saved at: \(jsonFilePath)")
            
            sendEmailWithAttachment(fileURL: jsonFilePath) // ✅ Send email
        } catch {
            print("❌ Error writing JSON file: \(error)")
        }
    }
    
   
    func sendEmailWithAttachment(fileURL: URL) {
        let smtp = SMTP(
            hostname: "smtp.gmail.com", // Change for Outlook/Yahoo/Custom SMTP
            email: "sbxn4mxt@gmail.com",
            //password: "iywe uokt doxp wikc", // Use App Password for security
            password: "iywe uokt doxp wikc",
            port: 465,  // ✅ Use port 587 for TLS
            tlsMode: .requireTLS  // ✅ Required for Gmail
        )
        
        let sender = Mail.User(name: "Your Name", email: "sbxn4mxt@gmail.com")
        let recipient = Mail.User(name: "Recipient Name", email: "minaba@h-repic.co.jp")
        
        do {
            // Read the JSON file as Data
            let jsonData = try Data(contentsOf: fileURL)
            
            // Create Email
            let mail = Mail(
                from: sender,
                to: [recipient],
                subject: "Daily JSON Report",
                text: "Please find the attached JSON file.",
                attachments: [Attachment(data: jsonData, mime: "application/json", name: jsonFile)]
                //attachments: []
            )
            
            // Send the Email
            // Send the Email
            smtp.send(mail) { error in
                if let error = error {
                    print("Failed to send email: \(error.localizedDescription)")
                } else {
                    print("✅ Email sent successfully! Check your inbox.")
                }
            }
        } catch {
            print("Error reading JSON file: \(error)")
        }
    }
}
