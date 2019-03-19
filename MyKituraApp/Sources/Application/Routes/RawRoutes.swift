//
//  RawRoutes.swift
//  Application
//
//  Created by Michail Bondarenko on 3/19/19.
//

import Foundation

func initializeRawRoutes(app: App) {
    
    app.router.post("/raw") { request, response, next in
        do {
            let book = try request.read(as: Book.self)
            App.bookStore.append(book)
            response.send(book)
        } catch {
            let _ = response.send(status: .badRequest)
        }
        next()
    }
    
    app.router.get("/raw") { request, response, next in
        response.send(App.bookStore)
        next()
    }
    
    app.router.get("/raw/:id") { request, response, next in
        guard let idString = request.parameters["id"],
            let id = Int(idString),
            id >= 0,
            id < App.bookStore.count
            else {
                let _ = response.send(status: .badRequest)
                return next()
        }
        response.send(App.bookStore[id])
        next()
    }
}
extension App {
    static var bookStore = [Book]()
}
