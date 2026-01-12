//
//  FeatureRow.swift
//  SF-Symbol-Finder-Workshop
//
//  Created by ZENA on 10/26/25.
//

import SwiftUI

struct FeatureRow: View {
    let icon: String
    let title: String
    let description: String

    var body: some View {
        HStack(spacing: 15) {
            Image(systemName: icon)
                .font(.title)
                .foregroundColor(.blue)
                .frame(width: 50)

            VStack(alignment: .leading, spacing: 10) {
                Text(title)
                    .font(.title3)
                    .fontWeight(.bold)
                Text(description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
    }
}
