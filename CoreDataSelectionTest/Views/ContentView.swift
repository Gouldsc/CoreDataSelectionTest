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
	@SceneStorage( ManagerKeys.selection ) private var selectedListItemId: Selection?

	private var selection: Binding<SelectableObject?>
	{
		Binding(
			get:
				{
					guard let tSelectedID = selectedListItemId?.selectedId,
						  let tNSManagedObjectID = PersistenceController.shared.managedObjectFor( url: tSelectedID ),
						  let rSelectableObject = tNSManagedObjectID as? SelectableObject
					else
					{
						return nil
					}
					return rSelectableObject
				},
			set:
				{
					newValue in
						guard let tURLRepresentation = newValue?.objectID.uriRepresentation()
						else
						{
							selectedListItemId = nil
							return
						}
						let tSelectedItem = Selection( selectedId: tURLRepresentation )
						selectedListItemId = tSelectedItem
				} )
	}
    var body: some View
	{
		NavigationView
		{
			SourceListView( entityAs: entityAs, selection: selection )
				.environment( \.managedObjectContext, viewContext )
			Text( "Detail, no selection" )
		}
    }
}

