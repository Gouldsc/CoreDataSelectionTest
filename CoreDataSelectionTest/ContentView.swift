//
//  ContentView.swift
//  CoreDataSelectionTest
//
//  Created by Scott Gould on 8/30/21.
//

import SwiftUI
import CoreData

struct ContentView: View
{
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest( sortDescriptors: [NSSortDescriptor( keyPath: \EntityA.name_,
													 ascending: true )],
						 animation: .default )
    private var entityAs: FetchedResults<EntityA>

    var body: some View
	{
		NavigationView
		{
			Section( "Entity A", content:{
				List
				{
					ForEach( entityAs )
					{
						tEntityA in
							NavigationLink( "EntityA \(tEntityA.name).", destination: EntityADetailView( entityA: tEntityA) )
					}
					.onDelete(perform: deleteItems)
				}
			})
			.toolbar
			{
				Button( action: addItem )
				{
					Label( "Add Item", systemImage: "plus" )
				}
			}
			Text( "Detail" )

		}
    }

    private func addItem()
	{
        withAnimation
		{
            let entityA = EntityA( context: viewContext )
            entityA.name = "EntityA: \(Date())"

			PersistenceController.shared.save()
        }
    }

    private func deleteItems( offsets: IndexSet )
	{
        withAnimation
		{
            offsets.map { entityAs[$0] }.forEach( viewContext.delete )

			PersistenceController.shared.save()
        }
    }
}
