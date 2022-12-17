//
//  UserListLargeWidget.swift
//  UserListWidgetExtension
//
//  Created by Burak Dinç on 17.12.2022.
//

import SwiftUI

struct UserListLargeWidget: View {
    
    var userListEntry: UserListWidgetEntry
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 10) {
            
            // MARK: Title
            Text("Kullanıcı Listesi")
                .font(.system(size: 14).bold())
                .foregroundColor(.white)
            
            // MARK: User List
            ForEach(self.userListEntry.userList.prefix(8), id: \.id) { user in
                
                if let userID = user.id,
                   let userName = user.username {
                    HStack(alignment: .center, spacing: 10) {
                        
                        Text(userID.description)
                            .font(.system(size: 12).italic())
                            .foregroundColor(.white.opacity(0.8))
                        
                        Text(userName)
                            .font(.system(size: 12).italic())
                            .foregroundColor(.white.opacity(0.8))
                        
                    }
                    .frame(minWidth: 0, maxWidth: .infinity)
                    
                    Divider().foregroundColor(.white)
                }
                
            }
            
        }
        .padding(30)
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .background(Color.blue)
        .unredacted()
        
    }
}

struct UserListLargeWidget_Previews: PreviewProvider {
    static var previews: some View {
        UserListLargeWidget(userListEntry: UserListWidgetEntry.placeholder)
    }
}
