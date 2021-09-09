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
	var managedObjectContext: NSManagedObjectContext
	{
		let rContext = persistenceController.container.viewContext
		rContext.undoManager = UndoManager()
		
		return rContext
	}

    var body: some Scene
	{
        WindowGroup
		{
            ContentView()
                .environment( \.managedObjectContext, managedObjectContext )
        }
		.commands
		{
			SidebarCommands()
			ToolbarCommands()
			ItemCommands()
		}
    }
}
