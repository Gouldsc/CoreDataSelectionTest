//
//  CoreDataSelectionTestApp.swift
//  CoreDataSelectionTest
//
//  Created by Scott Gould on 8/30/21.
//

import SwiftUI

@main
struct CoreDataSelectionTestApp: App
{
    let persistenceController = PersistenceController.shared

    var body: some Scene
	{
        WindowGroup
		{
            ContentView()
                .environment( \.managedObjectContext, persistenceController.container.viewContext )
        }
    }
}
