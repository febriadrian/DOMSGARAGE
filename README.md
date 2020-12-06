# DOMSGARAGE (iOS)

## Xcode 11.5 - Swift 5

## Architecture : MVVM + RxSwift

## MVVM + RxSwift Template :
`https://github.com/febriadrian/MVVM-RxSwift-Xcode-Templates`

## Story : Tool tracking for Dominic Toretto

## Problem Statement
Dominic Toretto has retired from his fast and the furious driving days and spends his
days tinkering in his garage. His friends always come to borrow tools from him and he’s finding it difficult to keep track of who took what. He has hired you to build an app to keep track of his tools.

## Requirements
* Dominic wants to see all the tools in his toolshed in a convenient list. The tool name and an easily identifiable icon or image must be in the list. See next page for a list of tools he owns.
* In this list, per tool, he would also like to see the total item count and the borrowed (number of items loaned to friends) item count.
* Whenever he is loaning out a tool, he’d like to tap on the tool and enter the name of his friend to whom he is giving the tool. Press “Ok” and one item will be marked as loaned. The item counts in the list should update accordingly.
* In a separate screen or page he would like to see a list of his friends. Luckily he has only 5 friends: Brian, Luke, Letty, Shaw and Parker
* By tapping the friend’s name, he wants to see what tools have been loaned out to that friend.
* Similar to the homepage list, the borrowed count must be displayed per tool. Dominic should be able to tap on a tool which will prompt to mark one item as returned. Pressing “OK” will mark the item as returned.
* When the borrowed count is zero, that tool should not appear in the friend’s list anymore.
* Item counts per tool should be up to date when navigating from screen to screen.
* Dominic is a very old fashioned guy and his phone doesn’t have access to the internet. So all the app data must be stored only locally (no external services) and must not be lost when the app restarts.

## Toretto's Tools
* Wrench - 6
* Cutter - 15
* Pliers  - 12
* Screwdriver - 13
* Welding machine - 3
* Welding glasses - 7
* Hammer  - 4
* Measuring Tape  - 9
* Alan key set - 4
* Air compressor - 2
