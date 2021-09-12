//
//  ContentView.swift
//  CoreDataSelectionTest
//
//  Created by Scott Gould on 8/30/21.
//

//	TODO: Implement the onHover "action" button contextMenu funcitonality with single click -- Default Menu macOS implementation uses popup menu which we don't want. See Notes.app for desired implementation
//	TODO: Undo support


import SwiftUI
import CoreData

struct ContentView: View
{
    @Environment(\.managedObjectContext) private var viewContext
	
	//	FIXME: This is a workaround. @SceneStorage conflicts with @FetchRequest. I'm using @AppStorage temporarily until Apple's bug is fixed.
	@AppStorage( "ContentView.selectedListItemId" ) private var selectedListItemId: Selection.ID?
//	@SceneStorage( "ContentView.selectedListItemId" ) private var selectedListItemId: Selection.ID?
	
    var body: some View
	{
		NavigationView
		{
			SourceListView( selection: $selectedListItemId )
				.environment( \.managedObjectContext, viewContext )
				.frame( minWidth: 150 )


			Text( "Detail, no selection" )
		}
    }
}

