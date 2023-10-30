//
//  SearchBar.swift
//  Weather
//
//  Created by Sajjad Khazraei on 10/30/23.
//

import SwiftUI

struct SearchBar: View {
    @Binding var searchText: String
    @Binding var isShowingSearchResults: Bool
    var onEdit: () -> Void
    var onBack: () -> Void
    
    var body: some View {
        HStack {
            if isShowingSearchResults {
                Button(action: {
                    onBack()
                }, label: {
                    Image(systemName: "arrow.backward")
                })
            }
            TextField("Enter Location",
                      text: $searchText, onEditingChanged: { isEditing in
                if isEditing {
                    onEdit()
                }
            })
            .padding()
            .background(
                isShowingSearchResults ?
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.white)
                    .shadow(radius: 0, x: 0, y: 0)
                :
                RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(.white)
                        .shadow(radius: 5, x: 0, y: 2)
            )
        }
    }
}

//#Preview {
//    SearchBar()
//}
