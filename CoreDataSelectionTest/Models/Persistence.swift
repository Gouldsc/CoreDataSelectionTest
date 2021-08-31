//
//  Persistence.swift
//  CoreDataSelectionTest
//
//  Created by Scott Gould on 8/30/21.
//

import CoreData

struct PersistenceController
{
    static let shared = PersistenceController()

    let container: NSPersistentContainer

    init( inMemory: Bool = false )
	{
        container = NSPersistentContainer( name: "CoreDataSelectionTest" )
        if inMemory
		{
            container.persistentStoreDescriptions.first!.url = URL( fileURLWithPath: "/dev/null" )
        }
        container.loadPersistentStores( completionHandler:
		{
			(storeDescription, error) in
				if let error = error as NSError?
				{
					fatalError( "Unresolved error \(error), \(error.userInfo)" )
				}
		}	 )
    }
	
	func save()
	{
		let tViewContext = container.viewContext
		do
		{
			try tViewContext.save()
		}
		catch
		{
			let tError = error as NSError
			fatalError( "Unresolved error \(tError), \(tError.userInfo)" )
		}
	}
	
	func managedObjectFor( url theURL: URL ) -> NSManagedObject?
	{
		guard let tNSManagedObjectID = container.viewContext.persistentStoreCoordinator?.managedObjectID( forURIRepresentation: theURL )
		else
		{
			return nil
		}
		return container.viewContext.object( with: tNSManagedObjectID )
	}
}
