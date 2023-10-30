//
//  SearchResultView.swift
//  Weather
//
//  Created by Sajjad Khazraei on 10/30/23.
//

import SwiftUI
import CoreLocation

struct SearchResultView: View {
    @Binding var results: [CLPlacemark]
    @Binding var selectedResult: CLPlacemark?
    @Binding var isPresented: Bool

    var body: some View {
        if results.isEmpty {
            Text("Location not found!")
        } else {
            List(results, id: \.self) { result in
                Text(result.name ?? result.locality ?? result.country ?? "")
                    .onTapGesture {
                        selectedResult = result
                        isPresented = false
                    }
            }
            .listStyle(PlainListStyle())
        }
    }
}

//#Preview {
//    SearchView()
//}
