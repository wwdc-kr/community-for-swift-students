//
//  ChecklistItem.swift
//  SF-Symbol-Finder-Workshop
//
//  Created by ZENA on 10/26/25.
//

import SwiftUI

struct ChecklistItem: View {
    let text: String
    @State private var isChecked = false

    var body: some View {
        HStack {
            Image(systemName: isChecked ? "checkmark.square.fill" : "square")
                .foregroundColor(.blue)
            Text(text)
                .font(.subheadline)
        }
        .contentShape(Rectangle())
        .onTapGesture {
            isChecked.toggle()
        }
    }
}
