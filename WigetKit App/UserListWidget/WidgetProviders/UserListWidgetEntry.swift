//
//  UserListWidgetEntry.swift
//  UserListWidgetExtension
//
//  Created by Burak Dinç on 17.12.2022.
//

import Foundation
import WidgetKit

struct UserListWidgetEntry: TimelineEntry {
    
    var date: Date
    var userList: [UserModel]
    
    static var placeholder: UserListWidgetEntry {
        UserListWidgetEntry(date: Date(), userList: [])
    }
    
}
