//
//  PersistenceController.swift
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
	
	func managedObjectFor( urlString theURLString: String ) -> NSManagedObject?
	{
		guard let tURL = URL( string: theURLString ),
			  let tNSManagedObjectID = container.viewContext.persistentStoreCoordinator?.managedObjectID( forURIRepresentation: tURL )
		else
		{
			return nil
		}
		return container.viewContext.object( with: tNSManagedObjectID )
	}
	
	func nextAvailableSortOrderValue( forEntity theEntity: SelectableObject ) -> Int16
	{
		let tEntityName = entityName( forEntity: theEntity )
		let tKey = "userOrder_"
		let tFetchRequest = highestUserOrderValueRequest( forEntityName: tEntityName )

		do
		{
			let tFetchedData = try container.viewContext.fetch( tFetchRequest )
			let tFirstObject = tFetchedData.first as! SelectableObject
			if let tFoundValue = tFirstObject.value( forKey: tKey ) as? Int16
			{
				return tFoundValue + 1
			}
		}
		catch
		{
			fatalError( "nextAvailableSortOrderValue(forEntity:) called and unable to retrieve a value for the 'userOrder_' attribute" )
		}
		return 1
	}
	
	private func entityName( forEntity theEntity: SelectableObject ) -> String
	{
		var rEntityName = ""
		
		switch theEntity
		{
			case is EntityA:
				rEntityName = "EntityA"
				
			case is Group:
				rEntityName = "Group"
				
			case is EntityC:
				rEntityName = "EntityC"
				
			default:
				fatalError( "entityName(forEntity:) called with invalid object type: \( theEntity.entity )" )
		}
		return rEntityName
	}
	
	private func highestUserOrderValueRequest( forEntityName theEntityName: String, key theKey: String = "userOrder_" ) -> NSFetchRequest<NSFetchRequestResult>
	{
		let rFetchRequest = NSFetchRequest<NSFetchRequestResult>( entityName: theEntityName )
		rFetchRequest.fetchLimit = 1
		rFetchRequest.propertiesToFetch = [theKey]
		
		let tIndexSort = NSSortDescriptor.init( key: theKey,
										  ascending: false )
		rFetchRequest.sortDescriptors = [tIndexSort]
		
		return rFetchRequest
	}
}
