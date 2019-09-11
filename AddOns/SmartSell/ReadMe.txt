***********************************************************************
SmartSell
Created by Aeldra (EU-Proudmoore)
***********************************************************************

SmartSell adds additional item information to any tooltip.
But why it is called SmartSell?
SmartSell originally was designed to display the sell value of any item anywhere.
This functionalty has become integrated into the game as of World of Warcraft patch 3.2
So, what's left, is an addon to customize the item tooltip :)


- FAQ -
Q1: How can I configure SmartSell?
A1: Type in the chat "/ssell" or "/smartsell" and you get a list of all commands


- Features -
* Display of the item value all the time
* Display of the item level
* Display of the item id
* Display of the item stack count
* Display of the value of the whole stack
* Display only on quest rewards
* Different styles
* Supports all tooltips


- Styles -
* 0-2: Default money style with additional information
* 3-6: Fully customized


- Chat Commands -
Type /ssell [command] or /smartsell [command] in game

* 0-6   -  Changes the display style
* sty   -  Cycles through all styles
* ii    -  Toggle display of item icons
* iis # -  Item icon size #value
* ci    -  Toggle display of coin icons
* cis # -  Coin icon size #value
* lvl   -  Toggle display of the item level
* id    -  Toggle display of the item id
* sc    -  Toggle display of the item stack count
* sp    -  Toggle display of the stack price or single item price
* pp    -  Toggle display of the price per piece
* val   -  Toggle display of the item value
* t     -  Toggle display of the item type
* st    -  Toggle display of the item sub type
* qo    -  Toggle display of the info only for quest rewards
* bl    -  Adds a blank line before the info text
* rs    -  Reset all settings to default


- Contact -
aeldra@sonnenkinder.org

Please send me a mail or write a comment, if you discover Bugs or have Suggestions.


***********************************************************************


Changes: 
Rev     Date        Description
------  ----------  -----------------------
1.13.2c 2019-09-10  Fixed double icon and money display on recipes

1.13.2b 2019-09-07  Refactoring and cleanup

1.13.2a 2019-08-29  Inital WoW Classic release

7.0b    2016-08-21  Fixed mail issue, thanks to Veyska

7.0a    2016-08-16  Updated TOC
                    Fixed LUA errors
                    Thanks to all who have helped me to keep it alive

6.0b    2014-10-23  Fixed issue with item compare tooltips

6.0a    2014-10-16  Updated code for Warlords of Draenor

5.4a    2013-09-12  Fixed 'ranged' slot compare issue
                    Updated TOC
                    
5.0e    2012-09-05  Fixed 'Ranged Weapon' slot compare issue

5.0d    2012-09-01  Fixed possible 'taint' issue in combination with the Glyph UI

5.0c    2012-08-31  Added price per piece to style 0-2

5.0b    2012-08-30  Fixed LUA error in loot frame

5.0a    2012-08-28  Updated code for Mists of Pandaria

4.3a    2011-11-30  Updated TOC

4.1a    2011-04-28  Updated TOC

4.0d    2011-02-06  Fixed possible LUA error in style 0

4.0c    2011-01-26  Fixed wrong calculated reagent value in the skill window
                    Improved internal cleanup

4.0b    2011-01-20  Added new option: 'ii' to display item icon in the title
                    Added new option: 'iis' to adjust the item icon size
                    Added new option: 'ci' to display coin icons in all styles
                    Added new option: 'cis' to adjust the coin icon size
                    Added new option: 'pp' to add the price per piece
                    Updated tooltip styles
                    Updated event triggers

4.0a    2010-10-14  Updated code for Cataclysm

3.3b    2010-04-13  Fixed possible LUA error

3.3a    2009-12-09  Updated TOC

3.2a    2009-08-10  Added new option: 'ic' to disable display in combat, default off
                    Updated item value of WoW interal API

3.1b    2009-04-25  Added new option: 't' and 'st' adds the item type and sub type to the info text

3.1a    2009-04-23  Switched to the ItemPrice lib

3.0b    2009-04-01  Added new option: 'bl' adds a blank line before the info text
                    Fixed initialization error

3.0a    2009-03-24  Initial version of SmartSell
