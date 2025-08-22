//
//  LockedBook.swift
//  HPTrivia
//
//  Created by Javier Jara Montoya on 21/8/25.
//

import SwiftUI

struct LockedBook: View {
    @State var book: Book
    var body: some View {
        ZStack(alignment: .center) {
            Image(book.image)
                .resizable()
                .scaledToFit()
                .shadow(radius: 7)
                .overlay {
                    Rectangle().opacity(0.75)
                }
            Image(systemName: "lock.fill")
                .font(.largeTitle)
                .imageScale(.large)
                .shadow(color: .white, radius: 2)
        }
    }
}

#Preview {
    LockedBook(book: BookQuestions().books[0])
}
