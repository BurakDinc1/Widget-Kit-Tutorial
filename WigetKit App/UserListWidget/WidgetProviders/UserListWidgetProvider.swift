//
//  UserListWidgetProvider.swift
//  UserListWidgetExtension
//
//  Created by Burak Dinç on 17.12.2022.
//

import Foundation
import WidgetKit

struct UserListWidgetProvider: TimelineProvider {
    
    func getSnapshot(in context: Context,
                     completion: @escaping (UserListWidgetEntry) -> Void) {
        let date = Date()
        let nextUpdate = Calendar.current.date(byAdding: .minute, value: 5, to: date)
        if context.isPreview {
            print("Widget--> GetSnapshot Contex isPreview")
            completion(Entry.placeholder)
        } else {
            self.getUserList() { (result) in
                switch result {
                case .success(let userList):
                    print("Widget--> GetSnapshot Response Success")
                    let userListTimeline = UserListWidgetEntry(date: nextUpdate!, userList: userList)
                    completion(userListTimeline)
                case .failure(_):
                    print("Widget--> GetSnapshot Response Failure")
                    completion(Entry.placeholder)
                }
            }
        }
    }
    
    func placeholder(in context: Context) -> UserListWidgetEntry {
        print("Widget--> Placeholder")
        return Entry.placeholder
    }
    
    func getTimeline(in context: Context,
                     completion: @escaping (Timeline<UserListWidgetEntry>) -> Void) {
        let date = Date()
        let nextUpdate = Calendar.current.date(byAdding: .minute, value: 5, to: date)
        
        self.getUserList() { (result) in
            switch result {
            case .success(let userList):
                print("OrdersWidget--> Timeline Response Success")
                let userListTimeline = UserListWidgetEntry(date: nextUpdate!, userList: userList)
                let timeline = Timeline<UserListWidgetEntry>(entries: [userListTimeline], policy: .after(nextUpdate!))
                completion(timeline)
            case .failure(_):
                print("OrdersWidget--> Timeline Response Failure")
                let timeline = Timeline<UserListWidgetEntry>(entries: [Entry.placeholder], policy: .after(nextUpdate!))
                completion(timeline)
            }
        }
    }
    
    private func getUserList(completion: @escaping (Result<[UserModel], Error>) -> Void) {
        APIService
            .shared
            .requestGetUserList(params: [:]) { result in
                switch result {
                case .success(let response):
                    completion(.success(response))
                    break
                case .failure(let error):
                    completion(.failure(error))
                    break
                }
            }
    }
    
}
