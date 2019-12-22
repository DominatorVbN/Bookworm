//
//  ContentView.swift
//  Bookworm
//
//  Created by dominator on 16/12/19.
//  Copyright © 2019 dominator. All rights reserved.
//

import SwiftUI

struct ContentView: View {
   @Environment(\.managedObjectContext) var moc
   @FetchRequest(entity: Book.entity(), sortDescriptors: [
    NSSortDescriptor(keyPath: \Book.title, ascending: true)
   ]) var books: FetchedResults<Book>

    @State private var showingAddScreen = false
    var body: some View {
         NavigationView {
            List{
                ForEach(books, id: \.self){ (book:Book) in
                    NavigationLink(destination: DetailView(book: book)) {
                        EmojiRatingView(rating: book.rating)
                            .font(.largeTitle)
                        VStack(alignment: .leading){
                            Text(book.title ?? "Unknown Title")
                                .font(.headline)
                            Text(book.author ?? "Unknown Author")
                                .foregroundColor(.secondary)
                        }
                    }
                    
                }.onDelete(perform: deleteBooks)
            }
                .navigationBarTitle("Bookworm")
                .navigationBarItems(leading: EditButton(), trailing: Button(action: {
                    self.showingAddScreen.toggle()
                }) {
                    Image(systemName: "plus")
                })
                .sheet(isPresented: $showingAddScreen) {
                    AddBookView().environment(\.managedObjectContext, self.moc)
                }
        }
    }
    
    func deleteBooks(at offsets: IndexSet){
        
        for index in offsets{
            let book = books[index]
            moc.delete(book)
        }
        
        try? moc.save()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}