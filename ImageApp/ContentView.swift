//
//  ContentView.swift
//  ImageApp
//
//  Created by Alexander Daniel on 4/4/20.
//  Copyright © 2020 adaniel. All rights reserved.
//

import SwiftUI
import UIKit

struct GradientBackgroundStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding()
            .foregroundColor(.white)
            .background(LinearGradient(gradient: Gradient(colors: [Color.black, Color.white]), startPoint: .leading, endPoint: .trailing))
            .cornerRadius(40)
            .padding(.horizontal, 20)
    }
}

struct ContentView: View {
    
    @State var uiImage: UIImage?
    @State var image: Image?
    @State var showCaptureImageView: Bool = false
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Photo.entity(), sortDescriptors: []) var photos: FetchedResults<Photo>
    
    @ObservedObject var viewModel = PhotoViewModel()
    
    var body: some View {
        ZStack {
            VStack {
                CollectionView(items: viewModel.images)
                
                Spacer()
                Button(action: {
                  self.showCaptureImageView.toggle()
                    }) {
                    Text("Choose photos")
                }.buttonStyle(GradientBackgroundStyle())

                if (showCaptureImageView) {
                    CaptureImageView(isShown: $showCaptureImageView, image: $image, uiImage: $uiImage)
                }

                if image != nil {
                    image?.resizable().frame(width: 100, height: 100)
                    
                    Button(action: {
                        guard let image = self.uiImage else { return }
                        let imageSaver = ImageSaver()
                        if let file = imageSaver.save(image: image) {
                            let entity = Photo(context: self.moc)
                            entity.name = file
                            entity.date = Date()
                            print(entity)
                            try? self.moc.save()
                            self.image = nil
                        }
                    }) {
                        Text("Save")
                    }.buttonStyle(GradientBackgroundStyle())
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
