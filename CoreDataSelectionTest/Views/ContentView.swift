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
	@SceneStorage( "selectedListItemId" ) private var selectedListItemId: Selection.ID?
	
    var body: some View
	{
		NavigationView
		{
			SourceListView( entityAs: entityAs, selection: $selectedListItemId )
				.environment( \.managedObjectContext, viewContext )
			Text( "Detail, no selection" )
		}
    }
}

