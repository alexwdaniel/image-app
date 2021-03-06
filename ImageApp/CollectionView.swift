//
//  CollectionView.swift
//  ImageApp
//
//  Created by Alex Daniel on 4/14/20.
//  Copyright © 2020 adaniel. All rights reserved.
//

import SwiftUI

extension Array {
    func chunk(size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            return Array(self[$0..<Swift.min($0 + size, count)])
        }
    }
}

extension Array: Identifiable where Element: Identifiable {
    public var id: String {
        let result =  map({ "\($0.id)" }).joined(separator: ":")
        return result
    }
}

struct CollectionView: View {
    @State var width = 2
    @State var spacing: CGFloat = 5
    @State var items: [UIImage]

    var body: some View {
        GeometryReader { proxy in
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(self.items.chunk(size: self.width), id: \.self) { row in
                        HStack(alignment: .center, spacing: self.spacing) {
                            ForEach(row, id: \.self) { item in
                                Image(uiImage: item).resizable()
                                    .frame(
                                        width: proxy.frame(in: .local).width / CGFloat(self.width) - self.spacing,
                                        height: proxy.frame(in: .local).width / CGFloat(self.width) - self.spacing
                                    )
                            }
                        }
                    }
                }
                .offset(x: self.spacing / 2, y: 0)
            }
        }
    }
}
