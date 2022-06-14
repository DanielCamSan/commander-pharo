Class {
	#name : #EgContactBookPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'table',
		'contactBook'
	],
	#category : #EgContactBook
}

{ #category : #layout }
EgContactBookPresenter class >> buildCommandsGroupWith: presenter forRoot: rootCommandGroup [

	rootCommandGroup
		register: (EgAddContactCommand forSpec context: presenter);
		register: (EgRemoveContactCommand forSpec context: presenter)
]

{ #category : #layout }
EgContactBookPresenter class >> coworkersExample [

	<example>

 	^ (self on: EgContactBook coworkers) open 
]

{ #category : #layout }
EgContactBookPresenter class >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		  add: #table;
		  yourself
]

{ #category : #accessing }
EgContactBookPresenter >> contactBook [

	^ contactBook
]

{ #category : #accessing }
EgContactBookPresenter >> contactBook: anObject [

	contactBook := anObject
]

{ #category : #accessing }
EgContactBookPresenter >> initializePresenters [

	table := self newTable.
	table
		addColumn: (SpStringTableColumn title: 'Name' evaluated: #name);
		addColumn: (SpStringTableColumn title: 'Phone' evaluated: #phone).
	table contextMenu: [ self rootCommandsGroup beRoot asMenuPresenter ].

	table items: contactBook contents
]

{ #category : #accessing }
EgContactBookPresenter >> isContactSelected [

	^ self table selectedItems isNotEmpty
]

{ #category : #accessing }
EgContactBookPresenter >> newContact [

	| rawData splitted |
	rawData := self
		           request:
		           'Enter new contact name and phone (split by comma)'
		           initialAnswer: ''
		           title: 'Create new contact'.
	splitted := rawData splitOn: $,.
	(splitted size = 2 and: [ splitted allSatisfy: #isNotEmpty ]) 
		ifFalse: [ 
			SpInvalidUserInput signal: 'Please enter contact name
and phone (split by comma)' ].
	^ EgContact new
		  name: splitted first;
		  phone: splitted second;
		  yourself
]

{ #category : #accessing }
EgContactBookPresenter >> selectedContact [

	^ table selection selectedItem
]

{ #category : #accessing }
EgContactBookPresenter >> setModelBeforeInitialization: aContactBook [

	super setModelBeforeInitialization: aContactBook.
	contactBook := aContactBook
]

{ #category : #accessing }
EgContactBookPresenter >> table [

	^ table
]

{ #category : #accessing }
EgContactBookPresenter >> table: anObject [

	table := anObject
]

{ #category : #accessing }
EgContactBookPresenter >> updateView [

	table items: contactBook contacts
]
